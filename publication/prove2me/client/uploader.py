#!/usr/bin/env python3
"""Bounded, fail-closed Prove2Me publisher. Default operation is offline dry-run."""
from __future__ import annotations

import argparse
import contextlib
from concurrent.futures import ThreadPoolExecutor, wait, FIRST_COMPLETED
import hashlib
import json
import os
from pathlib import Path
import re
import subprocess
import sys
import tempfile
import threading
import time
import urllib.error
import urllib.parse
import urllib.request
import uuid

BASE = "https://prove2.me/api/v1"
TOOLCHAIN = "leanprover/lean4:v4.33.1"
PROTOCOL_VERSION = "0.9.8"
MAX_FILE_BYTES = 8 * 1024 * 1024
ID = re.compile(r"^[A-Za-z0-9_-]{1,200}$")
SHA256 = re.compile(r"^[a-f0-9]{64}$")
SHA1 = re.compile(r"^[a-f0-9]{40}$")


class Stop(Exception):
    """Safe user-facing error; must never contain credentials or server body."""


def canonical(value):
    return json.dumps(value, sort_keys=True, separators=(",", ":"), ensure_ascii=False).encode()


def digest(data):
    return hashlib.sha256(data).hexdigest()


def read_bytes(path):
    data = path.read_bytes()
    if len(data) > MAX_FILE_BYTES:
        raise Stop("A package file exceeds the 8 MiB limit")
    return data


def safe_id(value):
    if not isinstance(value, str) or not ID.fullmatch(value):
        raise Stop("Server returned an invalid or missing identifier")
    return value


def atomic_json(path, value):
    path.parent.mkdir(parents=True, exist_ok=True)
    fd, tmp = tempfile.mkstemp(prefix=path.name + ".", dir=path.parent)
    try:
        with os.fdopen(fd, "wb") as stream:
            os.fchmod(stream.fileno(), 0o600)
            stream.write(canonical(value) + b"\n")
            stream.flush()
            os.fsync(stream.fileno())
        os.replace(tmp, path)
        directory = os.open(path.parent, os.O_RDONLY)
        try:
            os.fsync(directory)
        finally:
            os.close(directory)
    finally:
        if os.path.exists(tmp):
            os.unlink(tmp)


@contextlib.contextmanager
def lock_state(path):
    """Nonblocking process lock, released by the OS even after a killed process."""
    import fcntl
    path.parent.mkdir(parents=True, exist_ok=True)
    with open(str(path) + ".lock", "a") as stream:
        try:
            fcntl.flock(stream, fcntl.LOCK_EX | fcntl.LOCK_NB)
        except BlockingIOError:
            raise Stop("Another uploader owns this state file") from None
        yield


class Package:
    def __init__(self, path, source_root=None):
        self.path = Path(path).resolve()
        self.root = self.path.parent
        raw = read_bytes(self.path)
        self.sha = digest(raw)
        self.data = json.loads(raw)
        self.source_root = Path(source_root).resolve() if source_root else None
        if self.data.get("schema_version") != 1:
            raise Stop("Unsupported manifest schema_version")
        env = self.data.get("environment", {})
        if env.get("toolchain") != TOOLCHAIN or not isinstance(env.get("mathlib_rev"), str) or not SHA1.fullmatch(env["mathlib_rev"]):
            raise Stop("Manifest must pin Lean v4.33.1 and an exact Mathlib commit")
        self.env = env
        self.tag = self.data.get("project_tag")
        if not isinstance(self.tag, str) or not self.tag.strip():
            raise Stop("Missing project_tag")
        source = self.data.get("source", {})
        if not isinstance(source.get("commit"), str) or not SHA1.fullmatch(source["commit"]) or not isinstance(source.get("repository"), str) or not source["repository"].startswith("https://github.com/"):
            raise Stop("Source must identify a GitHub repository and exact commit")
        self.files = self.data.get("files", {})
        if not isinstance(self.files, dict) or not self.files:
            raise Stop("Manifest has no package file digests")
        self.check_files()
        raw_items = self.data.get("items", [])
        if not isinstance(raw_items, list) or not raw_items:
            raise Stop("Manifest has no publication items")
        self.items = {}
        names = set()
        for raw_item in raw_items:
            item = dict(raw_item)
            key = item.get("key")
            if not isinstance(key, str) or not key or key in self.items:
                raise Stop("Item keys must be nonempty and unique")
            kind = item.get("kind")
            if kind not in {"definition", "theorem"}:
                raise Stop("Item kind must be definition or theorem")
            if ("payload" in item) == ("payload_file" in item):
                raise Stop("Each item needs exactly one payload or payload_file")
            payload = item.get("payload")
            if payload is None:
                payload = json.loads(self.file_bytes(item["payload_file"]))
            if not isinstance(payload, dict):
                raise Stop("Item payload must be a JSON object")
            payload = dict(payload)
            name = payload.get(kind + "_name", "")
            pattern = r"[A-Za-z_][A-Za-z0-9_]*(?:\.[A-Za-z_][A-Za-z0-9_]*)*" if kind == "theorem" else r"[A-Za-z_][A-Za-z0-9_]*"
            if not isinstance(name, str) or not re.fullmatch(pattern, name) or name in names:
                raise Stop("Publication names must be unique conservative ASCII identifiers")
            names.add(name)
            if not payload.get(kind + "_title") or len(payload[kind + "_title"]) > 200:
                raise Stop("Every publication requires a title of at most 200 characters")
            if not payload.get("natural_language_statement") or not payload.get("source"):
                raise Stop("Every publication requires a description and source")
            if self.tag not in payload.get("tags", []):
                raise Stop("Each payload must carry the shared project_tag")
            if payload.get("private", False) is not False:
                raise Stop("This public-library client requires private=false")
            if payload.get("env", self.env["mathlib_rev"]) != self.env["mathlib_rev"]:
                raise Stop("Payload environment differs from manifest environment")
            payload["env"] = self.env["mathlib_rev"]
            payload["private"] = False
            if kind == "definition":
                if not isinstance(payload.get("definition"), str) or not payload["definition"].strip():
                    raise Stop("Definition payload lacks Lean code")
            else:
                if not isinstance(payload.get("formal_statement"), str) or not payload["formal_statement"].rstrip().endswith(":= by sorry"):
                    raise Stop("Theorem formal_statement must end with := by sorry")
                if not item.get("explanation"):
                    raise Stop("Each theorem solution requires an explanation")
                self.file_bytes(item.get("solution_file"))
            deps = item.get("depends_on", [])
            if not isinstance(deps, list) or not all(isinstance(d, str) for d in deps):
                raise Stop("depends_on must be a list of item keys")
            item.update(payload=payload, name=name, depends_on=deps)
            self.items[key] = item
        self.order = self.topological_order()

    def local_path(self, relative):
        if not isinstance(relative, str) or not relative or Path(relative).is_absolute():
            raise Stop("Package paths must be relative")
        path = (self.root / relative).resolve()
        if not path.is_relative_to(self.root):
            raise Stop("Package path escapes the package root")
        return path

    def file_bytes(self, relative):
        if relative not in self.files:
            raise Stop("Referenced package file has no digest")
        data = read_bytes(self.local_path(relative))
        if digest(data) != self.files[relative]:
            raise Stop("Package digest mismatch; regenerate and revalidate the package")
        return data

    def check_files(self):
        if digest(read_bytes(self.path)) != self.sha:
            raise Stop("Manifest changed during this run")
        for path, expected in self.files.items():
            if not isinstance(expected, str) or not SHA256.fullmatch(expected):
                raise Stop("Invalid package SHA-256 digest")
            self.file_bytes(path)

    def topological_order(self):
        order, active, done = [], set(), set()

        def visit(key):
            if key not in self.items:
                raise Stop("Dependency names a missing item")
            if key in active:
                raise Stop("Publication dependency cycle")
            if key in done:
                return
            active.add(key)
            for dep in self.items[key]["depends_on"]:
                visit(dep)
            active.remove(key)
            done.add(key)
            order.append(key)

        for key in self.items:
            visit(key)
        return order

    def execution_gate(self):
        self.check_files()
        validation = self.data.get("validation", {})
        evidence = validation.get("evidence_files", [])
        if validation.get("status") != "passed" or not evidence:
            raise Stop("Execution needs passed local validation with hashed evidence_files")
        for path in evidence:
            self.file_bytes(path)
        source = self.data["source"]
        source_digests = source.get("digests", {})
        if self.source_root is None or not source_digests:
            raise Stop("Execution requires --source-root and source.digests")

        def git(*args):
            result = subprocess.run(["git", "-C", str(self.source_root), *args], capture_output=True)
            if result.returncode:
                raise Stop("Unable to verify source checkout and committed source bytes")
            return result.stdout

        if git("rev-parse", "HEAD").decode().strip() != source["commit"]:
            raise Stop("Source checkout HEAD differs from the manifest commit")
        for relative, expected in source_digests.items():
            path = (self.source_root / relative).resolve()
            if Path(relative).is_absolute() or not path.is_relative_to(self.source_root):
                raise Stop("Source digest path escapes source root")
            if not isinstance(expected, str) or not SHA256.fullmatch(expected):
                raise Stop("Invalid source digest")
            if digest(read_bytes(path)) != expected or digest(git("show", source["commit"] + ":" + relative)) != expected:
                raise Stop("Source bytes differ from the pinned committed source")

    def summary(self):
        return {"mode": "dry-run", "network_requests": 0, "manifest_sha256": self.sha,
                "environment": self.env, "source": {k: self.data["source"][k] for k in ("repository", "commit")},
                "definitions": sum(i["kind"] == "definition" for i in self.items.values()),
                "theorems": sum(i["kind"] == "theorem" for i in self.items.values()),
                "validation_status": self.data.get("validation", {}).get("status", "missing"),
                "order": self.order}


class NoRedirect(urllib.request.HTTPRedirectHandler):
    def redirect_request(self, req, fp, code, msg, headers, newurl):
        return None


class Transport:
    def __init__(self, credentials_path, audit):
        self.credentials_path = Path(credentials_path)
        self.audit = audit
        self.token = None
        self.expires_at = 0
        self._token_lock = threading.Lock()
        self._thread_local = threading.local()

    def _request(self, method, path, data=None, content_type=None, token=None):
        if not path.startswith("/") or path.startswith("//") or ".." in path:
            raise Stop("Invalid fixed-origin API path")
        headers = {"Accept": "application/json", "User-Agent": "collatz-prove2me-publisher/1"}
        if content_type:
            headers["Content-Type"] = content_type
        if token:
            headers["Authorization"] = "Bearer " + token
        request = urllib.request.Request(BASE + path, data=data, headers=headers, method=method)
        try:
            if not hasattr(self._thread_local, "opener"):
                self._thread_local.opener = urllib.request.build_opener(NoRedirect())
            with self._thread_local.opener.open(request, timeout=45) as response:
                if response.geturl() != BASE + path:
                    raise Stop("Redirect refused; credentials are restricted to the fixed API origin")
                if response.status not in {200, 201, 202}:
                    raise Stop("Unexpected HTTP status")
                body = response.read(MAX_FILE_BYTES + 1)
                if len(body) > MAX_FILE_BYTES:
                    raise Stop("API response too large")
                value = json.loads(body)
                if not isinstance(value, dict):
                    raise Stop("API response must be a JSON object")
                return value
        except urllib.error.HTTPError as error:
            raise Stop("API request failed with HTTP " + str(error.code)) from None
        except (urllib.error.URLError, TimeoutError, OSError, ValueError):
            raise Stop("API request failed; no automatic retry was performed") from None

    def ensure_token(self):
        with self._token_lock:
            self._ensure_token_locked()

    def _ensure_token_locked(self):
        if self.token and time.time() < self.expires_at - 120:
            return
        try:
            if self.credentials_path.stat().st_mode & 0o077:
                raise Stop("Credentials file must be readable only by its owner (chmod 600)")
            credentials = json.loads(read_bytes(self.credentials_path))
        except (OSError, ValueError):
            raise Stop("Unable to load configured credentials file") from None
        key = credentials.get("api_key")
        if not isinstance(key, str) or not key.startswith("p2m_"):
            raise Stop("Credentials file needs an existing api_key")
        self.audit("credential_exchange_before", {})
        try:
            response = self._request("POST", "/agent/refresh", canonical({"api_key": key}), "application/json")
            if response.get("version") != PROTOCOL_VERSION:
                raise Stop("Platform version differs from reviewed API documentation; update the client before continuing")
            token = response.get("access_token")
            expiry = response.get("expires_at")
            if not isinstance(token, str) or not token or not isinstance(expiry, (int, float)):
                raise Stop("Invalid credential exchange response")
            self.token, self.expires_at = token, expiry
        except Exception:
            self.audit("credential_exchange_failed", {})
            raise
        self.audit("credential_exchange_after", {"version": PROTOCOL_VERSION})

    def get(self, path):
        self.ensure_token()
        return self._request("GET", path, token=self.token)

    def post_json(self, path, payload):
        self.ensure_token()
        return self._request("POST", path, canonical(payload), "application/json", self.token)

    def verify(self, theorem_id, code, explanation):
        self.ensure_token()
        boundary = "p2m_" + uuid.uuid4().hex
        chunks = []
        for key, value in (("theorem_id", theorem_id), ("proof_type", "prove"), ("explanation", explanation)):
            chunks.append(("--" + boundary + '\r\nContent-Disposition: form-data; name="' + key + '"\r\n\r\n' + value + "\r\n").encode())
        chunks.extend([("--" + boundary + '\r\nContent-Disposition: form-data; name="file"; filename="solution.lean"\r\nContent-Type: text/plain; charset=utf-8\r\n\r\n').encode(), code,
                       ("\r\n--" + boundary + "--\r\n").encode()])
        return self._request("POST", "/verify", b"".join(chunks), "multipart/form-data; boundary=" + boundary, self.token)


class Publisher:
    def __init__(self, package, state_path, transport=None):
        self.package = package
        self._state_lock = threading.RLock()
        self.path = Path(state_path)
        if self.path.exists():
            self.state = json.loads(read_bytes(self.path))
            if self.state.get("manifest_sha256") != package.sha:
                raise Stop("State belongs to different manifest bytes; do not discard it to retry")
        else:
            self.state = {"schema_version": 1, "manifest_sha256": package.sha,
                          "source": package.data["source"], "items": {}, "events": [], "complete": False}
        for key in package.items:
            self.state["items"].setdefault(key, {"status": "new"})
        self.transport = transport

    def save(self):
        with self._state_lock:
            atomic_json(self.path, self.state)

    def event(self, action, fields):
        with self._state_lock:
            self.state["events"].append({"at": time.time(), "action": action, **fields})
            self.save()

    def validate_environment(self):
        response = self.transport.get("/environments")
        if not any(env.get("mathlib_rev") == self.package.env["mathlib_rev"] and env.get("toolchain") == TOOLCHAIN for env in response.get("environments", [])):
            raise Stop("Pinned Lean/Mathlib environment is not available on the live platform")
        self.event("environment_checked", self.package.env)

    def mutate(self, key, action):
        self.package.execution_gate()
        item, record = self.package.items[key], self.state["items"][key]
        payload_hash = digest(canonical(item["payload"])) if action == "publish" else digest(self.package.file_bytes(item["solution_file"]))
        with self._state_lock:
            record["status"] = action + "_intent"
            record["intent_id"] = uuid.uuid4().hex
            self.event(action + "_before", {"key": key, "intent_id": record["intent_id"], "payload_sha256": payload_hash})
        try:
            if action == "publish":
                endpoint = "/submit-definition" if item["kind"] == "definition" else "/submit-problem"
                response = self.transport.post_json(endpoint, item["payload"])
                if response.get("errors"):
                    with self._state_lock:
                        record["status"] = "needs_reconciliation"
                        self.event("publish_response_requires_review", {"key": key})
                    raise Stop("Publish response reported rejection; reconcile before any further submission")
                job_id = response.get("job_id")
                if not job_id:
                    jobs = response.get("jobs", [])
                    if len(jobs) == 1 and jobs[0].get("name") == item["name"]:
                        job_id = jobs[0].get("job_id")
                job_id = safe_id(job_id)
                with self._state_lock:
                    record.update(status="publish_queued", job_id=job_id)
                    self.event(action + "_after", {"key": key, "job_id": job_id})
            else:
                response = self.transport.verify(record["theorem_id"], self.package.file_bytes(item["solution_file"]), item["explanation"])
                submission_id = safe_id(response.get("submission_id"))
                with self._state_lock:
                    record.update(status="verify_queued", submission_id=submission_id)
                    self.event(action + "_after", {"key": key, "submission_id": submission_id})
        except BaseException:
            with self._state_lock:
                if record["status"] in {"publish_intent", "verify_intent"}:
                    record["status"] = "needs_reconciliation"
                    record["uncertain_action"] = action
                    self.event(action + "_outcome_unknown", {"key": key})
            raise

    def check_entity(self, key, theorem_id):
        row = self.transport.get("/theorems/" + safe_id(theorem_id))
        item = self.package.items[key]
        if row.get("theorem_id") != theorem_id or row.get("theorem_name") != item["name"] or row.get("mathlib_rev") != self.package.env["mathlib_rev"]:
            raise Stop("Remote entity identity or environment does not match the manifest")
        if row.get("source") != item["payload"]["source"] or self.package.tag not in row.get("tags", []):
            raise Stop("Remote source or project tag differs from the manifest")
        if item["kind"] == "theorem":
            for field in ("formal_statement", "preamble"):
                if row.get(field, "") != item["payload"].get(field, ""):
                    raise Stop("Remote immutable theorem text differs from the validated payload")
        if row.get("deprecated_at"):
            raise Stop("Remote entity is deprecated")
        with self._state_lock:
            record = self.state["items"][key]
            record["remote_status"] = row.get("status")
            record["api_url"] = BASE + "/theorems/" + theorem_id
            url = row.get("url")
            if isinstance(url, str) and urllib.parse.urlsplit(url).scheme == "https" and urllib.parse.urlsplit(url).netloc == "prove2.me":
                record["public_url"] = url
        return row

    def poll(self, key):
        item, record = self.package.items[key], self.state["items"][key]
        if record["status"] == "publish_queued":
            response = self.transport.get("/publish-jobs/" + record["job_id"])
            if response.get("id") != record["job_id"]:
                raise Stop("Publish job ID mismatch")
            status = response.get("status")
            updates = {"publish_status": status}
            if status == "PUBLISHED":
                theorem_id = safe_id(response.get("theorem_id"))
                row = self.check_entity(key, theorem_id)
                updates.update(theorem_id=theorem_id, status="published")
                if item["kind"] == "definition" and row.get("status") == "Definition":
                    updates["status"] = "complete"
            elif status in {"FAILED", "ERROR"}:
                updates["status"] = "failed"
            elif status not in {"PENDING", "COMPILING"}:
                raise Stop("Unrecognized publish job status")
            with self._state_lock:
                record.update(updates)
                self.event("publish_polled", {"key": key, "status": status})
        elif record["status"] == "verify_queued":
            response = self.transport.get("/verify?" + urllib.parse.urlencode({"submission_id": record["submission_id"]}))
            if response.get("id") != record["submission_id"] or response.get("theorem_id") != record["theorem_id"]:
                raise Stop("Verification submission identity mismatch")
            status = response.get("status")
            updates = {"verify_status": status}
            if status == "ACCEPTED":
                updates["status"] = "accepted_pending_catalog"
            elif status == "SKETCH_ACCEPTED":
                updates["status"] = "sketch_accepted"
            elif status in {"CE", "WA", "SORRY", "FAILED", "ERROR"}:
                updates["status"] = "failed"
            elif status != "PENDING":
                raise Stop("Unrecognized proof verification status")
            with self._state_lock:
                record.update(updates)
                self.event("verify_polled", {"key": key, "status": status})
        if record["status"] in {"accepted_pending_catalog", "sketch_accepted"}:
            row = self.check_entity(key, record["theorem_id"])
            with self._state_lock:
                if row.get("status") == "Proved":
                    record["status"] = "complete"
                self.event("theorem_status_checked", {"key": key, "status": row.get("status")})

    def reconcile(self, key, job_id=None, submission_id=None):
        """Attach an independently discovered server ID; never POST to resolve uncertainty."""
        if key not in self.package.items or bool(job_id) == bool(submission_id):
            raise Stop("Reconciliation requires a valid key and exactly one server ID")
        record = self.state["items"][key]
        if record["status"] not in {"needs_reconciliation", "publish_intent", "verify_intent"}:
            raise Stop("Item has no uncertain mutation to reconcile")
        if job_id:
            response = self.transport.get("/publish-jobs/" + safe_id(job_id))
            payload = self.package.items[key]["payload"]
            name = response.get("theorem_name") or response.get("definition_name")
            if response.get("id") != job_id or name != self.package.items[key]["name"] or response.get("source") != payload["source"]:
                raise Stop("Supplied publish job does not match item identity and source")
            if self.package.items[key]["kind"] == "theorem":
                if response.get("formal_statement") != payload["formal_statement"] or response.get("definitions", "") != payload.get("preamble", ""):
                    raise Stop("Publish job text does not match validated theorem payload")
            elif response.get("definitions") != payload["definition"]:
                raise Stop("Publish job definition text differs from validated payload")
            record.update(status="publish_queued", job_id=job_id)
        else:
            if not record.get("theorem_id"):
                raise Stop("Cannot attach a solution submission without a known target ID")
            response = self.transport.get("/verify?" + urllib.parse.urlencode({"submission_id": safe_id(submission_id)}))
            if response.get("id") != submission_id or response.get("theorem_id") != record["theorem_id"]:
                raise Stop("Supplied submission belongs to a different target")
            # Target identity alone does not establish which immutable proof was uploaded.
            source = self.transport.get("/submissions/" + submission_id + "/solution")
            code = source.get("solution") or source.get("code") or source.get("content")
            if not isinstance(code, str) or code.encode() != self.package.file_bytes(self.package.items[key]["solution_file"]):
                raise Stop("Cannot reconcile unless the server returns the exact submitted proof bytes")
            record.update(status="verify_queued", submission_id=submission_id)
        self.event("uncertain_mutation_reconciled", {"key": key, "job_id": job_id, "submission_id": submission_id})

    def final_verify(self, deadline, workers=1):
        expected = {r["theorem_id"] for r in self.state["items"].values()}
        progress = self.state.setdefault("final_verification", {"page": 0, "seen": [], "scan_done": False, "checked": []})
        while not progress["scan_done"]:
            if time.monotonic() >= deadline:
                return
            page = progress["page"]
            if page >= 100:
                raise Stop("Final catalog verification exceeded page bound")
            response = self.transport.get("/theorems?" + urllib.parse.urlencode({"tags": self.package.tag, "env": self.package.env["mathlib_rev"], "limit": 200, "offset": page * 200}))
            page_rows = response.get("theorems")
            if not isinstance(page_rows, list):
                raise Stop("Malformed final catalog response")
            if any(row.get("status") not in {"Proved", "Definition"} for row in page_rows):
                raise Stop("Project tag still contains entries that are not Proved or Definition")
            progress["seen"] = sorted(set(progress["seen"]) | {safe_id(r.get("theorem_id")) for r in page_rows})
            progress["page"] += 1
            progress["scan_done"] = len(page_rows) < 200
            self.event("final_catalog_page_checked", {"page": page})
        if not expected.issubset(set(progress["seen"])):
            self.state.pop("final_verification", None)
            self.save()
            raise Stop("Final catalog has not exposed every expected publication")
        abort = threading.Event()

        def check_final(key):
            if time.monotonic() >= deadline or abort.is_set():
                return
            try:
                record = self.state["items"][key]
                row = self.check_entity(key, record["theorem_id"])
                required = "Definition" if self.package.items[key]["kind"] == "definition" else "Proved"
                if row.get("status") != required:
                    raise Stop("Final per-ID verification did not confirm the exact required status")
                with self._state_lock:
                    progress["checked"].append(key)
                    self.event("final_item_checked", {"key": key})
            except BaseException:
                abort.set()
                raise

        unchecked = [key for key in self.state["items"] if key not in progress["checked"]]
        if workers == 1:
            for key in unchecked:
                check_final(key)
        else:
            # Only these independent read-only checks fan out; paginated catalog
            # discovery above retains a single durable cursor.
            with ThreadPoolExecutor(max_workers=workers) as executor:
                try:
                    list(executor.map(check_final, unchecked))
                except BaseException:
                    abort.set()
                    raise
        if len(progress["checked"]) != len(self.state["items"]):
            return
        self.state["complete"] = True
        self.event("final_verification_passed", {"count": len(expected)})

    def run_parallel(self, max_mutations, max_seconds, workers):
        """One owner per item; concurrent I/O with serialized durable transitions.

        A tick stops starting work at its deadline, then drains in-flight calls.
        Mutation slots are reserved before the intent/POST and never refunded.
        """
        self.package.execution_gate()
        self.validate_environment()
        deadline = time.monotonic() + max_seconds
        abort = threading.Event()
        mutations = 0
        attempted, inflight = set(), {}
        first_error = None
        with self._state_lock:
            if self.state["complete"]:
                self.state["complete"] = False
                self.state.pop("final_verification", None)
            for record in self.state["items"].values():
                if record["status"] in {"publish_intent", "verify_intent", "needs_reconciliation"}:
                    raise Stop("An interrupted POST needs reconciliation; no request was repeated")
                if record["status"] == "failed":
                    raise Stop("A publish or verification job failed; inspect its server ID before repair")

        def may_continue():
            return not abort.is_set() and time.monotonic() < deadline

        def reserve():
            nonlocal mutations
            with self._state_lock:
                if not may_continue() or mutations >= max_mutations:
                    return False
                mutations += 1
                return True

        def advance(key):
            try:
                record = self.state["items"][key]
                if not may_continue():
                    return
                if record["status"] == "new":
                    with self._state_lock:
                        if mutations >= max_mutations:
                            return
                    response = self.transport.get("/theorems?" + urllib.parse.urlencode({"theorem_name": self.package.items[key]["name"], "env": self.package.env["mathlib_rev"], "limit": 2}))
                    if response.get("theorems"):
                        raise Stop("Publication name already exists; reconcile or explicitly reuse it before proceeding")
                    if not reserve():
                        return
                    self.mutate(key, "publish")
                if may_continue():
                    self.poll(key)
                if record["status"] == "published" and self.package.items[key]["kind"] == "theorem" and reserve():
                    self.mutate(key, "verify")
                    if may_continue():
                        self.poll(key)
                if record["status"] == "failed":
                    raise Stop("A publish or verification job failed; inspect its server ID before repair")
            except BaseException:
                abort.set()
                raise

        # The context manager drains every submitted operation, including on a
        # KeyboardInterrupt. Each mutation's receipt/uncertainty reaches disk
        # before this method reports an error or releases the process lock.
        with ThreadPoolExecutor(max_workers=workers) as executor:
            try:
                while True:
                    if may_continue():
                        with self._state_lock:
                            for key in self.package.order:
                                if len(inflight) >= workers:
                                    break
                                if key in attempted:
                                    continue
                                record = self.state["items"][key]
                                if record["status"] == "complete":
                                    continue
                                if record["status"] == "new" and mutations >= max_mutations:
                                    continue
                                if all(self.state["items"][dep]["status"] == "complete" for dep in self.package.items[key]["depends_on"]):
                                    attempted.add(key)
                                    inflight[executor.submit(advance, key)] = key
                    if not inflight:
                        break
                    done, _ = wait(inflight, return_when=FIRST_COMPLETED)
                    for future in done:
                        inflight.pop(future)
                        try:
                            future.result()
                        except BaseException as error:
                            abort.set()
                            if first_error is None:
                                first_error = error
            except BaseException:
                abort.set()
                raise
        self.save()
        if first_error is not None:
            raise first_error
        if all(record["status"] == "complete" for record in self.state["items"].values()):
            self.final_verify(deadline, workers=workers)
        self.save()
        return {"complete": self.state["complete"], "publication_mutations_this_run": mutations,
                "items": {key: {k: v for k, v in row.items() if k in {"status", "theorem_id", "job_id", "submission_id", "api_url", "public_url", "remote_status"}} for key, row in self.state["items"].items()}}

    def run(self, max_mutations=10, max_seconds=45, workers=1):
        if not isinstance(workers, int) or not 1 <= workers <= 8:
            raise Stop("Use 1–8 workers")
        if workers > 1:
            return self.run_parallel(max_mutations, max_seconds, workers)
        self.package.execution_gate()
        self.validate_environment()
        mutations, start = 0, time.monotonic()
        if self.state["complete"]:
            self.state["complete"] = False
            self.state.pop("final_verification", None)
        for key in self.package.order:
            if time.monotonic() - start >= max_seconds:
                break
            record = self.state["items"][key]
            if record["status"] in {"publish_intent", "verify_intent", "needs_reconciliation"}:
                raise Stop("An interrupted POST needs reconciliation; no request was repeated")
            if record["status"] == "failed":
                raise Stop("A publish or verification job failed; inspect its server ID before repair")
            if not all(self.state["items"][dep]["status"] == "complete" for dep in self.package.items[key]["depends_on"]):
                continue
            if record["status"] == "new" and mutations < max_mutations:
                # Refuse an already occupied name even after loss of local state.
                response = self.transport.get("/theorems?" + urllib.parse.urlencode({"theorem_name": self.package.items[key]["name"], "env": self.package.env["mathlib_rev"], "limit": 2}))
                if response.get("theorems"):
                    raise Stop("Publication name already exists; reconcile or explicitly reuse it before proceeding")
                self.mutate(key, "publish")
                mutations += 1
            self.poll(key)
            if record["status"] == "published" and self.package.items[key]["kind"] == "theorem" and mutations < max_mutations:
                self.mutate(key, "verify")
                mutations += 1
                self.poll(key)
        if all(record["status"] == "complete" for record in self.state["items"].values()):
            self.final_verify(start + max_seconds)
        self.save()
        return {"complete": self.state["complete"], "publication_mutations_this_run": mutations,
                "items": {key: {k: v for k, v in row.items() if k in {"status", "theorem_id", "job_id", "submission_id", "api_url", "public_url", "remote_status"}} for key, row in self.state["items"].items()}}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("manifest", type=Path)
    parser.add_argument("--source-root", type=Path)
    parser.add_argument("--execute", action="store_true", help="Publish and poll using an existing credentials file")
    parser.add_argument("--credentials", type=Path, help="Path to existing private credentials.json; never a literal key")
    parser.add_argument("--state", type=Path)
    parser.add_argument("--max-mutations", type=int, default=10)
    parser.add_argument("--max-seconds", type=int, default=45)
    parser.add_argument("--workers", type=int, default=1, help="Concurrent independent items (1–8; default 1)")
    parser.add_argument("--reconcile-key")
    parser.add_argument("--job-id")
    parser.add_argument("--submission-id")
    args = parser.parse_args()
    try:
        package = Package(args.manifest, args.source_root)
        if not args.execute:
            print(json.dumps(package.summary(), indent=2))
            return 0
        if not args.credentials or not args.state:
            raise Stop("--execute requires --credentials and --state paths")
        if not 0 <= args.max_mutations <= 100 or not 1 <= args.max_seconds <= 60:
            raise Stop("Use 0–100 publication mutations and a 1–60 second tick budget")
        package.execution_gate()
        with lock_state(args.state):
            publisher = Publisher(package, args.state)
            publisher.transport = Transport(args.credentials, publisher.event)
            if args.reconcile_key:
                publisher.validate_environment()
                publisher.reconcile(args.reconcile_key, args.job_id, args.submission_id)
            result = publisher.run(args.max_mutations, args.max_seconds, args.workers)
            print(json.dumps(result, indent=2))
            return 0 if result["complete"] else 2
    except (Stop, OSError, ValueError, TypeError, KeyError) as error:
        # Generic exceptions can contain secret-bearing document text; print only controlled Stop messages.
        print("Stopped: " + (str(error) if isinstance(error, Stop) else "Invalid local package or state; no automatic retry performed"), file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main())
