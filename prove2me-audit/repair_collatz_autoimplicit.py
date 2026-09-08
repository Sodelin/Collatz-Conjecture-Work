"""Make the source's inferred generic binders explicit for server autoImplicit=false.

The selected declarations and insertion positions come from the official source
sketch oracle; the binder types were read from Lean's original ConstInfo types.
Only the generated YAH files are changed. No mathematical source is rewritten.
"""
import json, hashlib, argparse
from pathlib import Path

ROOT=None
REPO=None
INSERT={
    "adjacentPairs":" {α : Type _}",
    "countDelta":" {α : Type _}",
    "weightedCoefficient":" {ρ : Type _} {φ : Sort _}",
    "weightedGapSum":" {ρ : Type _}",
    "evalCoefficients":" {φ : Type _}",
    "weightedGapSum_nonneg":" {ρ : Type _}",
    "weightedGapSum_pos":" {ρ : Type _}",
    "positiveCertificate_ne_zero":" {ρ : Type _}",
    "evalCoefficients_zero":" {φ : Type _}",
    "evalCoefficients_add":" {φ : Type _}",
    "evalCoefficients_scale":" {φ : Type _}",
    "evalCoefficients_weightedCoefficient":" {φ : Type _} {ρ : Type _}",
    "evalCoefficients_eq_zero_of_map_eq":" {φ : Type _}",
    "evalCoefficients_eq_of_map_eq":" {φ : Type _}",
}
UNIVERSE_TARGETS={"evalCoefficients_weightedCoefficient","ffPumpWord_canonical",
    "noBoundedBelowCanonicalFFPumpWords","noTwoStateEdgeAdditiveOrder",
    "noTwoStateEdgeCertificateOrientation","noTwoStateSymbolAdditiveOrder",
    "noTwoStateSymbolCertificateOrientation","weightedGapSum_pos","yah13_forces_ff_negative"}

SOURCE_AND_ORACLE_SHA256 = {'lean/CollatzWork/YAHFiniteObstructionStatement.lean': 'b703978accc652bbdb243ac38f8aac512bbe4664791dc39dfe33476858186c3f', 'lean/CollatzWork/YAHFiniteObstruction.lean': 'c5b3e30059e8358aa59f0b4e155a09b11e5b7eb5c7caf419df9d3587b6408af4', 'prove2me-audit/sketch.CollatzWork.YAHFiniteObstructionStatement.jsonl': '533d406ef6d755b89e80d46b78a098d39e24c97e7f273dc5a46d8ac083f67d55', 'prove2me-audit/sketch.CollatzWork.YAHFiniteObstruction.jsonl': '3ecfb62b260ad592c98363de092a54fbcafe262eac7a2de6b74749ff7f51412c'}

def repair():
    for relative, expected in SOURCE_AND_ORACLE_SHA256.items():
        path=REPO/relative
        if not path.is_file() or hashlib.sha256(path.read_bytes()).hexdigest()!=expected:
            raise SystemExit("Source/oracle mismatch; rerun extraction and review new binders: "+relative)
    manifest=json.loads((ROOT/'manifest.json').read_text())
    statement=ROOT/'Definitions/Def_CollatzWork_YAHFiniteObstructionStatement.lean'
    if 'def adjacentPairs {α : Type _}' in statement.read_text():
        raise SystemExit('Explicit binder repair already applied; validate the current package instead of inserting twice.')
    # A source declaration header is copied from its parser span up to its
    # authoritative name end. That exact header survives in every inlined copy.
    headers={}
    for module in ["YAHFiniteObstructionStatement","YAHFiniteObstruction"]:
        data=(REPO/'lean/CollatzWork'/f'{module}.lean').read_bytes()
        for line in (REPO/'prove2me-audit'/f'sketch.CollatzWork.{module}.jsonl').read_text().splitlines():
            f=json.loads(line)
            if f.get('kind')=='decl' and f.get('nameText') in INSERT:
                a=f['declStart']['offset']; b=f['nameRange']['end']['offset']
                header=data[a:b].decode()
                headers[f['nameText']]=header
    changes=[]
    for item in manifest['items']:
        if not item['key'].startswith(('def:CollatzWork.YAH','thm:CollatzWork.YAH.')):continue
        payload_path=ROOT/item['payload_file']; payload=json.loads(payload_path.read_text())
        paths=[item['definition_file']] if item['kind']=='definition' else [item['theorem_file'],item['solution_file']]
        for rel in paths:
            path=ROOT/rel; text=path.read_text(); before=text
            for name,header in headers.items():
                if header in text:
                    text=text.replace(header,header+INSERT[name])
            if item['kind']=='theorem':
                name=item['key'].split(':',1)[1]; short=name.rsplit('.',1)[1]
                if short in INSERT:
                    target='solution' if rel==item['solution_file'] else name
                    header='theorem '+target
                    assert text.count(header)==1,(rel,header)
                    text=text.replace(header,header+INSERT[short])
                needs_universe=short in UNIVERSE_TARGETS
            else:needs_universe=True
            if needs_universe:
                # A helper namespace closes before the top-level solution and
                # its hoisted context. Declare the universe outside that scope.
                anchor=('namespace CollatzWork.YAH\n' if 'namespace CollatzWork.YAH\n' in text else 'open Lean.Grind\n')
                assert anchor in text,rel
                text=text.replace(anchor,'universe u\n\n'+anchor,1)
            if text!=before:path.write_text(text);changes.append(rel)
        if item['kind']=='definition':payload['definition']=(ROOT/item['definition_file']).read_text()
        else:
            short=item['key'].rsplit('.',1)[1]
            if short in INSERT:
                name=item['key'].split(':',1)[1];header='theorem '+name
                assert payload['formal_statement'].count(header)==1
                payload['formal_statement']=payload['formal_statement'].replace(header,header+INSERT[short])
            if short in UNIVERSE_TARGETS:
                payload['preamble']=payload['preamble'].replace('open Lean.Grind\n','universe u\n\nopen Lean.Grind\n',1)
            assert payload['preamble']+payload['formal_statement']==(ROOT/item['theorem_file']).read_text()
        if json.loads(payload_path.read_text())!=payload:
            payload_path.write_text(json.dumps(payload,indent=2,ensure_ascii=False)+'\n');changes.append(item['payload_file'])
    manifest['validation'].update(status='pending',strict_autoImplicit_false='pending')
    for relative in manifest['files']:
        manifest['files'][relative]=hashlib.sha256((ROOT/relative).read_bytes()).hexdigest()
    (ROOT/'manifest.json').write_text(json.dumps(manifest,indent=2,ensure_ascii=False)+'\n')
    print(json.dumps({'changed_files':changes},indent=2))

if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('source_root',type=Path)
    parser.add_argument('candidate_root',type=Path)
    args=parser.parse_args()
    REPO=args.source_root.resolve(); ROOT=args.candidate_root.resolve()
    repair()
