#!/usr/bin/env bash
# Optional local compatibility launcher; normal verification is `lake build`.
set -euo pipefail

: "${PROBE_LEAN_ROOT:?Set PROBE_LEAN_ROOT to the extracted Lean 4.33.1 directory}"
task_script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
task_shim_dir="$(mktemp -d)"
trap 'rm -rf -- "$task_shim_dir"' EXIT

cc -shared -fPIC "$task_script_dir/local-runtime-location.c" \
  -ldl -o "$task_shim_dir/runtime-location.so"
export LEAN_APP_PATH="$PROBE_LEAN_ROOT/bin/lake"
export LD_PRELOAD="$task_shim_dir/runtime-location.so${LD_PRELOAD:+:$LD_PRELOAD}"
export PATH="$PROBE_LEAN_ROOT/bin:$PATH"
"$PROBE_LEAN_ROOT/bin/lake" "$@"
