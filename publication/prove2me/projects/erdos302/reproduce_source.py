#!/usr/bin/env python3
"""Replay exact source builds/extractions; does not authenticate or publish."""
from pathlib import Path
import json, shutil, subprocess, tempfile, hashlib
kit=Path(__file__).resolve().parent
inventory=json.loads((kit/'audit/source-inventory.json').read_text())
for entry in inventory['files']:
    data=(kit/'source'/entry['path']).read_bytes()
    assert hashlib.sha256(data).hexdigest()==entry['sha256'], entry['path']
work=Path(tempfile.mkdtemp(prefix='prove2me-source-replay-'))
shutil.copytree(kit/'source',work,dirs_exist_ok=True)
a=work/'prove2me-audit';a.mkdir(exist_ok=True)
for name in ['extract_decl_graph.lean','extract_sketch_info.lean','audit_axioms_types.lean']:
    shutil.copyfile(kit/'audit'/name,a/name)
mods=json.loads((kit/'audit/module-inventory.json').read_text())
def run(args,name):
    with (a/name).open('w') as log:
        subprocess.run(['lake',*args],cwd=work,stdout=log,stderr=subprocess.STDOUT,check=True)
run(['build',*[m['module'] for m in mods]],'build.log')
run(['env','lean','prove2me-audit/extract_decl_graph.lean'],'graph-extraction.log')
run(['env','lean','prove2me-audit/audit_axioms_types.lean'],'axiom-types.log')
for m in mods:
    run(['env','lean','--run','prove2me-audit/extract_sketch_info.lean',m['path']],'sketch.'+m['module']+'.jsonl')
allowed={'propext','Classical.choice','Quot.sound'}
for line in (a/'axiom-types.jsonl').read_text().splitlines():
    row=json.loads(line)
    assert set(row['axioms'])<=allowed,(row['name'],row['axioms'])
print('Source replay passed:',work)
print('This does not verify or publish the candidate platform decomposition.')
