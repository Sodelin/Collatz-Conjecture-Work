from pathlib import Path
import json, subprocess, concurrent.futures, os
root=Path(__file__).resolve().parents[1]; p=root/'prove2me-audit/staged'; d=p/'type-checks';d.mkdir(exist_ok=True)
m=json.loads((p/'manifest.json').read_text()); jobs=[]
for item in m['items']:
    if item['kind']!='theorem':continue
    name=item['key'][4:];slug=name.replace('.','_')
    for mode,path,decl in [('theorem',item['theorem_file'],name),('solution',item['solution_file'],'solution')]:
        module=path.removesuffix('.lean').replace('/','.')
        stem=slug+'.'+mode;file=d/(stem+'.lean');out='type-checks/'+stem+'.json'
        file.write_text('import Lean\nimport '+module+'\nopen Lean\nrun_meta do\n  let ci ← getConstInfo `'+decl+'\n  let fmt ← Lean.Meta.ppExpr ci.type\n  IO.FS.writeFile "'+out+'" (Json.str fmt.pretty).compress\n')
        jobs.append((stem,file))
def run(job):
    stem,file=job
    wrapper=os.environ.get('SOURCE_LAKE_WRAPPER')
    cmd=['bash',wrapper] if wrapper else ['lake']
    with (d/(stem+'.log')).open('w') as log:
        r=subprocess.run(cmd+['env','lean',str(file)],cwd=p,stdout=log,stderr=subprocess.STDOUT)
    return stem,r.returncode
with concurrent.futures.ThreadPoolExecutor(max_workers=4) as pool:
    for row in pool.map(run,jobs):print(row,flush=True)
original={r['name']:r['type'] for r in [json.loads(s) for s in (p.parent/'axiom-types.jsonl').read_text().splitlines()]}
results=[]
for item in m['items']:
    if item['kind']!='theorem':continue
    name=item['key'][4:];slug=name.replace('.','_');row={'name':name,'original':original[name]}
    for mode in ['theorem','solution']:
        f=d/(slug+'.'+mode+'.json');row[mode]=json.loads(f.read_text()) if f.exists() else None
    row['exact_pretty_type_match']=row['original']==row['theorem']==row['solution'];results.append(row)
(d/'comparison.json').write_text(json.dumps({'all_match':all(r['exact_pretty_type_match'] for r in results),'comparisons':results},indent=2)+'\n')
print('type comparison',sum(r['exact_pretty_type_match'] for r in results),'of',len(results),flush=True)
