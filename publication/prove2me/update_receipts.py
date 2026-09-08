#!/usr/bin/env python3
"""Export credential-free, resumable publication receipts from known state files."""
import argparse
from datetime import datetime, timezone
import json
from pathlib import Path
import re

parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('state_directory',type=Path)
args=parser.parse_args()
base=Path(__file__).resolve().parent
out=base/'receipts';out.mkdir(exist_ok=True)
report={'checked_at':datetime.now(timezone.utc).isoformat(),'account':'Sodelin','projects':[],'complete':True}
for slug in ('collatz','erdos302','egyptian295','newmath'):
 state_path=args.state_directory/(slug+'.state.json')
 manifest_path=base/('collatz/manifest.json' if slug=='collatz' else 'projects/'+slug+'/candidate/manifest.json')
 manifest=json.loads(manifest_path.read_text())
 state=json.loads(state_path.read_text()) if state_path.exists() else {'items':{},'complete':False}
 serialized=json.dumps(state,indent=2)
 if re.search(r'"(?:api_key|access_token|refresh_token|password)"\s*:',serialized) or re.search(r'p2m_[A-Za-z0-9_-]{20,}\.',serialized):
  raise SystemExit('Refusing to export a state containing credential fields')
 (out/(slug+'.json')).write_text(serialized+'\n')
 kinds={i['key']:i['kind'] for i in manifest['items']}
 counts={kind:sum(v==kind for v in kinds.values()) for kind in ('definition','theorem')}
 complete={kind:sum(kinds.get(k)==kind and r.get('status')=='complete' for k,r in state['items'].items()) for kind in counts}
 row={'project':slug,'source':manifest['source']['repository'],'source_commit':manifest['source']['commit'],'expected_theorems':counts['theorem'],'proved_theorems':complete['theorem'],'expected_definitions':counts['definition'],'published_definitions':complete['definition'],'final_verification_passed':bool(state.get('complete')),'receipt':'receipts/'+slug+'.json','failed_items':[k for k,r in state['items'].items() if r.get('status')=='failed'],'uncertain_items':[k for k,r in state['items'].items() if r.get('status') in ('publish_intent','verify_intent','needs_reconciliation')]}
 report['projects'].append(row)
 report['complete'] &= row['final_verification_passed']
report['proved_theorems']=sum(p['proved_theorems'] for p in report['projects'])
report['published_definitions']=sum(p['published_definitions'] for p in report['projects'])
(base/'PUBLICATION_STATUS.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps({k:report[k] for k in ('complete','proved_theorems','published_definitions')}))
