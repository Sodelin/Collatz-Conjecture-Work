#!/usr/bin/env python3
"""Compare each compiled solution and target at rigid, independently named universe levels."""
import concurrent.futures,datetime,hashlib,json,os,pathlib,subprocess,sys
CHECK=pathlib.Path(__file__).resolve().parent
ROOT=CHECK.parent.parent
WORK=ROOT.parents[3]
LAUNCH=WORK/'Collatz-Conjecture-Work/prove2me-audit/runtime/local-lake.sh'
ENV=os.environ.copy();ENV['PROBE_LEAN_ROOT']=str(WORK/'lean-runtime/lean-4.33.1-linux')
items=[x for x in json.loads((ROOT/'manifest.json').read_text())['items'] if x['kind']=='theorem']
if len(sys.argv)>1: items=[x for x in items if sys.argv[1] in x['key']]
def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def check(item):
 name=item['key'][4:]; slug=name.replace('.','_')
 sol=ROOT/item['solution_file']; target=ROOT/item['theorem_file']
 before={'solution_sha256':digest(sol),'theorem_sha256':digest(target)}
 source='import Lean\nimport '+item['solution_file'][:-5].replace('/','.')+'\nimport '+item['theorem_file'][:-5].replace('/','.')+'\n'+r"""
open Lean Meta
set_option maxHeartbeats 0
set_option maxRecDepth 10000
set_option pp.universes true
set_option pp.explicit true
set_option pp.fullNames true
run_meta do
  let si ← getConstInfo `solution
  let ti ← getConstInfo `THEOREM_NAME
  let countEqual := si.levelParams.length == ti.levelParams.length
  let levels := (List.range si.levelParams.length).map fun i => Level.param (Name.mkSimple ("audit_universe_" ++ toString i))
  let st := si.type.instantiateLevelParams si.levelParams levels
  let tt := ti.type.instantiateLevelParams ti.levelParams levels
  let noMetavariables := !(st.hasMVar || tt.hasMVar || st.hasLevelMVar || tt.hasLevelMVar)
  let matched ← if countEqual && noMetavariables then isDefEq st tt else pure false
  let sty ← ppExpr st
  let tty ← ppExpr tt
  let row := Json.mkObj [
    ("theorem_name", toJson "THEOREM_NAME"),
    ("passed", toJson (countEqual && noMetavariables && matched)),
    ("universe_count_equal", toJson countEqual),
    ("solution_universe_parameters", toJson (si.levelParams.map toString)),
    ("target_universe_parameters", toJson (ti.levelParams.map toString)),
    ("rigid_universe_parameters", toJson ((List.range si.levelParams.length).map fun i => "audit_universe_" ++ toString i)),
    ("no_metavariables", toJson noMetavariables),
    ("definitionally_equal_at_rigid_levels", toJson matched),
    ("solution_type", toJson sty.pretty),
    ("target_type", toJson tty.pretty)]
  IO.println ("TYPECHECK_JSON " ++ row.compress)
  unless countEqual && noMetavariables && matched do
    throwError "solution and target differ at independent rigid universe parameters"
""".replace('THEOREM_NAME',name)
 path=CHECK/(slug+'.lean');path.write_text(source)
 try:
  r=subprocess.run(['bash',str(LAUNCH),'env','lean','-DautoImplicit=false',str(path)],cwd=ROOT,env=ENV,text=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,timeout=120)
  output=r.stdout;exitcode=r.returncode
 except subprocess.TimeoutExpired as e:output=str(e);exitcode=-1
 (CHECK/(slug+'.log')).write_text(output)
 rows=[json.loads(l.removeprefix('TYPECHECK_JSON ')) for l in output.splitlines() if l.startswith('TYPECHECK_JSON ')]
 row=rows[0] if len(rows)==1 else {'theorem_name':name,'passed':False,'error':'missing unambiguous Lean result'}
 row.update(before);row['exit_code']=exitcode;row['audit_file']=str(path.relative_to(ROOT));row['source_files_unchanged']=before=={'solution_sha256':digest(sol),'theorem_sha256':digest(target)}
 row['passed']=bool(row['passed'] and exitcode==0 and row['source_files_unchanged'])
 (CHECK/(slug+'.json')).write_text(json.dumps(row,ensure_ascii=False,indent=2)+'\n')
 return row
with concurrent.futures.ThreadPoolExecutor(max_workers=4) as pool:
 results=list(pool.map(check,items))
summary={'checked_at':datetime.datetime.now(datetime.timezone.utc).isoformat(),'method':'Lean definitional equality of compiled solution and target types after replacing universe parameters by equal-length lists of distinct rigid parameters in declaration order; no expression or universe metavariables permitted. Source files hashed before/after.','autoImplicit':False,'expected_theorem_count':113,'checked':len(results),'passed':sum(x['passed'] for x in results),'failed':sum(not x['passed'] for x in results),'all_passed':len(results)==113 and all(x['passed'] for x in results),'results':results}
out=ROOT/'evidence/solution-type-comparison.json';out.write_text(json.dumps(summary,ensure_ascii=False,indent=2)+'\n')
print(json.dumps({k:v for k,v in summary.items() if k!='results'},indent=2));print('failures:',[r['theorem_name'] for r in results if not r['passed']])
