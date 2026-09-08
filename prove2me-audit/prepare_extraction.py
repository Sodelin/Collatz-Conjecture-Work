from pathlib import Path
import shutil, json, hashlib, subprocess, os, concurrent.futures
ROOT = Path(__file__).resolve().parents[1]
AUDIT = ROOT / 'prove2me-audit'
UP = Path('/root/prove2me_workspace/scripts')
LAKE = ['bash', str(AUDIT/'runtime/local-lake.sh')]
ENV = dict(os.environ, PROBE_LEAN_ROOT='/root/.elan/toolchains/leanprover--lean4---v4.33.1')
def run(args, out):
    p = subprocess.run(LAKE+args, cwd=ROOT, env=ENV, text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    out.write_text(p.stdout)
    if p.returncode: raise RuntimeError(f'{args}: see {out}')
    return str(out.relative_to(ROOT))
files = list(sorted((ROOT/'lean').rglob('*.lean')))
manifest=[]
for f in files:
    manifest.append(dict(path=str(f.relative_to(ROOT)), extraction_path=str(f.relative_to(ROOT)), module='.'.join(f.relative_to(ROOT/'lean').with_suffix('').parts), sha256=hashlib.sha256(f.read_bytes()).hexdigest()))
for f in sorted((ROOT/'research/blind-2026-09-05').glob('*.lean')):
    target=AUDIT/'archive'/('Archive'+f.name)
    shutil.copyfile(f,target)
    manifest.append(dict(path=str(f.relative_to(ROOT)), extraction_path=str(target.relative_to(ROOT)), module=target.stem, sha256=hashlib.sha256(f.read_bytes()).hexdigest()))
(AUDIT/'source-inventory.json').write_text(json.dumps(manifest, indent=2)+'\n')
graph=(UP/'extract_decl_graph.lean').read_text().replace('import SumSquares','import Lean\n'+'\n'.join('import '+r['module'] for r in manifest))
graph=graph.replace('let projPrefix := `SumSquares','let projPrefix := `CollatzWork').replace('let isProj : Name → Bool := fun m => projPrefix.isPrefixOf m','let isProj : Name → Bool := fun m => projPrefix.isPrefixOf m || m.toString.startsWith "Archive"')
graph=graph.replace('IO.FS.writeFile "decl_graph.jsonl"','IO.FS.writeFile "prove2me-audit/decl_graph.jsonl"')
(AUDIT/'extract_decl_graph.lean').write_text(graph)
sketch=(UP/'extract_sketch_info.lean').read_text()
sketch=sketch.replace('  -- decl facts: one per top-level declaration command', '''  -- Additional parser-grounded command metadata for skeleton subtraction.
  -- These do not change the official decl/ref extraction semantics.
  for cmd in s.commands do
    let some ds := cmd.getPos? | continue
    let some de := cmd.getTailPos? | continue
    IO.println (Json.mkObj [("kind", Json.str "command"),
      ("syntaxKind", Json.str cmd.getKind.toString),
      ("start", posJson fm ds), ("end", posJson fm de)]).compress
  -- decl facts: one per top-level declaration command''')
sketch=sketch.replace('("nameText", nameText?.map', '("nameRange", rangeJson fm (declId?.map (·[0]))),\n                   ("nameText", nameText?.map')
(AUDIT/'extract_sketch_info.lean').write_text(sketch)
if __name__=='__main__':
    run(['build','CollatzWork','CollatzWork.ResidueAncestorTails'],AUDIT/'build.log')
    for row in manifest:
        if row['module'].startswith('Archive'):
            run(['env','lean','-R','prove2me-audit/archive','-o',str(ROOT/'.lake/build/lib/lean'/ (row['module']+'.olean')),row['extraction_path']], AUDIT/(row['module']+'.build.log'))
    run(['env','lean','prove2me-audit/extract_decl_graph.lean'], AUDIT/'graph-extraction.log')
    def extract(row):
        return run(['env','lean','--run','prove2me-audit/extract_sketch_info.lean',row['extraction_path']], AUDIT/('sketch.'+row['module']+'.jsonl'))
    with concurrent.futures.ThreadPoolExecutor(max_workers=4) as pool:
        for result in pool.map(extract,manifest): print(result,flush=True)
