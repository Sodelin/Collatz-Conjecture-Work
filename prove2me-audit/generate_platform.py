"""Generate a reviewable Prove2Me tree from Lean declaration/sketch facts.

All declaration boundaries, value cuts and binding edits come from the official
Lean oracles. No regular expression is used to discover Lean declarations.
Source files remain untouched. This tool never authenticates or publishes.
"""
from pathlib import Path
import json, hashlib, argparse, collections, subprocess

def load_jsonl(path): return [json.loads(x) for x in path.read_text().splitlines() if x.startswith('{')]
def sha(path): return hashlib.sha256(path.read_bytes()).hexdigest()
def edit_bytes(data, edits):
    last=len(data)+1
    for a,b,repl in sorted(edits, reverse=True):
        if b>last: raise ValueError(f'Overlapping oracle edits {a}:{b} after {last}')
        data=data[:a]+repl+data[b:];last=a
    return data
def slug(name):
    if not all(c.isascii() and (c.isalnum() or c in '_.') for c in name):
        raise ValueError(f'Non-ASCII upload name needs explicit oracle rename: {name}')
    return name.replace('.','_')

class Generator:
    def __init__(self,root,out):
        self.root=root;self.audit=root/'prove2me-audit';self.out=out
        invpath=self.audit/'module-inventory.json'
        if not invpath.exists():invpath=self.audit/'source-inventory.json'
        inv=json.loads(invpath.read_text())
        self.mods={r['module']:r for r in inv}
        self.rows=load_jsonl(self.audit/'decl_graph.jsonl')
        self.graph={r['name']:r for r in self.rows}
        self.units={};self.owner={};self.data={};self.facts={}
        for m,row in self.mods.items():
            data=(root/row['extraction_path']).read_bytes();self.data[m]=data
            facts=load_jsonl(self.audit/('sketch.'+m+'.jsonl'));self.facts[m]=facts
            units=[f for f in facts if f['kind']=='decl']
            for i,f in enumerate(units):
                key=(m,i);self.units[key]=dict(f,rows=[],module=m,key=key)
            for r in self.rows:
                if r['module']!=m or not r['startLine']:continue
                candidates=[(i,f) for i,f in enumerate(units) if f['declStart']['line']<=r['startLine']<=f['declEnd']['line']]
                if len(candidates)!=1:continue
                i,f=candidates[0];self.units[(m,i)]['rows'].append(r);self.owner[r['name']]=(m,i)
        self.unitdeps={k:set() for k in self.units}
        usernames={r['userName']:r['name'] for r in self.rows}
        for k,u in self.units.items():
            pending=[d for r in u['rows'] for d in r['typeDeps']+r['valueDeps']];seen=set()
            # Tactic syntax can mention a constant absent from the final proof term
            # (e.g. an unused simp argument). Preserve those elaborator-resolved refs.
            for f in self.facts[k[0]]:
                if f['kind']!='ref':continue
                if u['declStart']['offset']<=f['start']['offset']<u['declEnd']['offset']:
                    n=f['const']
                    if n not in self.graph and n.startswith('_private.'):
                        n=next((gn for un,gn in usernames.items() if n.endswith('.'+un)),n)
                    pending.append(n)
            while pending:
                d=pending.pop()
                if d in seen:continue
                seen.add(d)
                if d in self.owner:
                    if self.owner[d]!=k:self.unitdeps[k].add(self.owner[d])
                elif d in self.graph:
                    r=self.graph[d];pending.extend(r['typeDeps']+r['valueDeps'])
        simpfile=self.audit/'simp-membership.jsonl'
        if simpfile.exists():
            simp_units={self.owner[r['name']] for r in load_jsonl(simpfile) if r['name'] in self.owner}
            # The original elaborator's simp environment includes earlier local
            # source lemmas even when simplification drops their proof constants.
            for k,u in self.units.items():
                self.unitdeps[k].update(s for s in simp_units if s[0]==k[0] and self.units[s]['declStart']['offset']<u['declStart']['offset'])
        self.primary={}
        for k,u in self.units.items():
            direct=[r for r in u['rows'] if r['kind']=='theorem' and r['userName'].split('.')[-1]==u.get('nameText','').split('.')[-1]] if u.get('nameText') else []
            if len(direct)==1:self.primary[k]=direct[0]
        # Anonymous `example` commands elaborate without an exported declaration.
        # They are checked by the source build but never become importable bundles.
        self.defs={k for k,u in self.units.items() if u['rows'] and k not in self.primary}
        # A theorem needed by a definition must remain proved with that definition.
        self.defs=self.closure(self.defs)
        claims=[]
        if (root/'publication/claims.json').exists():claims=json.loads((root/'publication/claims.json').read_text())
        self.claimmap={n:c for c in claims if c.get('status')=='formal_auxiliary' for n in c.get('lean_declarations',[])}
        seeds={self.owner[n] for n in self.claimmap if n in self.owner}
        for k,r in self.primary.items():
            u=self.units[k]
            if r['isPrivate'] or k in self.defs:continue
            prooflines=u['declEnd']['line']-(u['valStart'] or u['declEnd'])['line']
            used_by=[s for s,deps in self.unitdeps.items() if k in deps]
            promoted=prooflines>40 or (prooflines>10 and (u.get('docstring') or len(used_by)>=2 or any(s[0]!=k[0] for s in used_by)))
            if promoted:seeds.add(k)
        # Leaf public results with no consumers represent independent source goals.
        for k,r in self.primary.items():
            if not r['isPrivate'] and k not in self.defs and not any(k in d for d in self.unitdeps.values()):seeds.add(k)
        self.nodes=seeds-self.defs
        self.reachable=self.closure(self.nodes|self.defs)
        self.inline=self.reachable-self.nodes-self.defs
        self.node_names={k:self.primary[k]['userName'] for k in self.nodes}
        self.defmods={k[0] for k in self.defs}

    def closure(self,seed,stop=frozenset()):
        seen=set();pending=list(seed)
        while pending:
            k=pending.pop()
            if k in seen:continue
            seen.add(k)
            if k not in stop:pending.extend(self.unitdeps[k])
        return seen
    def imports(self,defs,nodes):
        # Std and Init are the only non-project imports of these source projects.
        return 'import Std\nimport Init.Grind.Ordered.Module\n'+''.join('import Definitions.Def_'+slug(m)+'\n' for m in sorted(defs))+''.join('import Theorems.Thm_'+slug(self.node_names[k])+'\n' for k in sorted(nodes))
    def commands(self,m):return [f for f in self.facts[m] if f['kind']=='command']
    def helper_order(self,inline):
        modules={k[0] for k in inline};edges={m:set() for m in modules}
        for k in inline:
            edges[k[0]].update(d[0] for d in self.unitdeps[k] if d in inline and d[0]!=k[0])
        result=[];active=set();done=set()
        def visit(m):
            if m in done:return
            if m in active:raise ValueError('Cyclic helper-module ordering: '+m)
            active.add(m)
            for d in sorted(edges[m]):visit(d)
            active.remove(m);done.add(m);result.append(m)
        for m in sorted(modules):visit(m)
        return result
    def skeleton(self,m,keep):
        data=self.data[m];edits=[]
        for k,u in self.units.items():
            if k[0]==m and k not in keep:edits.append((u['declStart']['offset'],u['declEnd']['offset'],b''))
        for c in self.commands(m):
            if c['syntaxKind'].startswith('Lean.Parser.Command.print'):
                edits.append((c['start']['offset'],c['end']['offset'],b''))
        # The parser's first command begins after the entire import header.
        cs=self.commands(m)
        if cs:edits.append((0,cs[0]['start']['offset'],b''))
        return edit_bytes(data,edits).decode()
    def context(self,k):
        """Copy scoped commands active at the target; namespaces resolved by graph."""
        m=k[0];u=self.units[k];data=self.data[m];stack=[[]]
        for c in self.commands(m):
            if c['start']['offset']>=u['declStart']['offset']:break
            kind=c['syntaxKind'].split('.')[-1]
            if kind in ('namespace','section'):stack.append([])
            elif kind=='end':
                if len(stack)>1:stack.pop()
            elif kind in ('variable','variables','universe','universes','include','omit','open','set_option'):
                stack[-1].append(data[c['start']['offset']:c['end']['offset']].decode())
        return '\n'.join(x for scope in stack for x in scope)+'\n'
    def target(self,k,solution=False,available=frozenset()):
        u=self.units[k];data=self.data[k[0]];a=u['declStart']['offset'];b=u['declEnd']['offset'] if solution else u['valStart']['offset']
        nr=u.get('nameRange')
        if not nr:raise ValueError(f'No binding range for {k}; rerun augmented official oracle')
        name='solution' if solution else self.node_names[k]
        edits=[(nr['start']['offset']-a,nr['end']['offset']-a,name.encode())]
        for field in ('docstring','privateTok'):
            r=u.get(field)
            if r:edits.append((r['start']['offset']-a,r['end']['offset']-a,b''))
        text=edit_bytes(data[a:b],edits).decode().lstrip()
        if not solution:text+=':= by sorry\n'
        else:
            ns=self.node_names[k].rsplit('.',1)[0] if '.' in self.node_names[k] else ''
            # Dotted declarations open their own namespace; solution needs it explicitly.
            if ns and any(r['userName'].startswith(ns+'.') and self.owner.get(r['name']) in available for r in self.rows):text='open '+ns+' in\n'+text
        return text+'\n'
    def generate(self):
        for d in ('Definitions','Theorems','Solutions','payloads'):(self.out/d).mkdir(parents=True,exist_ok=True)
        # These four directories are exclusively generated by this program.
        for d in ('Definitions','Theorems','Solutions','payloads'):
            for p in (self.out/d).iterdir():
                if p.is_file() and p.suffix in ('.lean','.json'):p.unlink()
        repo=subprocess.check_output(['git','remote','get-url','origin'],cwd=self.root,text=True).strip()
        commit=subprocess.check_output(['git','rev-parse','HEAD'],cwd=self.root,text=True).strip()
        # Normalize authenticated git transport URL to public source repository.
        repo='https://github.com/Sodelin/'+self.root.name
        items=[];coverage=[]
        for m in sorted(self.defmods):
            selected={k for k in self.defs if k[0]==m}
            deps=self.closure(selected)-selected;defdeps={k[0] for k in deps if k in self.defs and k[0]!=m}
            content=self.imports(defdeps,set())+self.skeleton(m,selected)
            path='Definitions/Def_'+slug(m)+'.lean';(self.out/path).write_text(content)
            key='def:'+m
            payload=dict(definition_name=slug(m),definition_title=m+' definitions',natural_language_description='Definitions and necessary proof-bearing construction material from '+m+'.',definition=content,tags=['collatz-work-import'],source=repo+'/blob/'+commit+'/'+self.mods[m]['path'])
            pp='payloads/'+slug(m)+'.definition.json';(self.out/pp).write_text(json.dumps(payload,indent=2)+'\n')
            items.append(dict(key=key,kind='definition',depends_on=['def:'+x for x in sorted(defdeps)],payload_file=pp,definition_file=path))
        for k in sorted(self.nodes,key=lambda k:self.node_names[k]):
            name=self.node_names[k];u=self.units[k];m=k[0]
            deps=self.closure(self.unitdeps[k],stop=self.nodes|self.defs)
            inline=deps-self.nodes-self.defs
            # Inline helpers may require additional imports recursively.
            ndeps=deps&self.nodes;dmods={s[0] for s in deps&self.defs}
            imp=self.imports(dmods,ndeps)
            helper=''.join(self.skeleton(hm,{x for x in inline if x[0]==hm}) for hm in self.helper_order(inline))
            ctx=self.context(k)
            preamble=imp+'\n'+ctx
            statement=self.target(k)
            thmpath='Theorems/Thm_'+slug(name)+'.lean';solpath='Solutions/Sol_'+slug(name)+'.lean'
            (self.out/thmpath).write_text(preamble+'\n'+statement)
            available=deps|{s for s in self.defs if s[0] in dmods}
            solution=imp+helper+'\n'+ctx+'\n'+self.target(k,True,available)
            (self.out/solpath).write_text(solution)
            source=repo+'/blob/'+commit+'/'+self.mods[m]['path']+f'#L{u["declStart"]["line"]}-L{u["declEnd"]["line"]}'
            claim=self.claimmap.get(name)
            doc=u.get('docstring');docstr=self.data[m][doc['start']['offset']:doc['end']['offset']].decode()[3:-2].strip() if doc else ''
            metadata_state='existing_claim' if claim else 'needs_academic_metadata_review'
            payload=dict(theorem_name=name,theorem_title=(claim['title'] if claim else name),natural_language_statement=(claim['statement']+' Limitations: '+claim['limitations'] if claim else docstr or 'Exact formal statement is authoritative. Metadata review pending.'),preamble=preamble,formal_statement=statement,tags=['collatz-work-import'],source=source)
            pp='payloads/'+slug(name)+'.theorem.json';(self.out/pp).write_text(json.dumps(payload,indent=2)+'\n')
            items.append(dict(key='thm:'+name,kind='theorem',depends_on=['def:'+x for x in sorted(dmods)]+['thm:'+self.node_names[x] for x in sorted(ndeps)],payload_file=pp,solution_file=solpath,theorem_file=thmpath,metadata_status=metadata_state))
        for k,u in self.units.items():
            coverage.append(dict(module=k[0],name=u.get('nameText'),start_line=u['declStart']['line'],end_line=u['declEnd']['line'],classification='definition_material' if k in self.defs else 'theorem_node' if k in self.nodes else 'inline_helper' if k in self.inline else 'source_checked_no_exported_declaration' if not u['rows'] else 'unreferenced_source_helper'))
        (self.out/'coverage.json').write_text(json.dumps(coverage,indent=2)+'\n')
        (self.out/'lakefile.toml').write_text('name = "collatz_prove2me_staging"\nversion = "0.1.0"\ndefaultTargets = ["Definitions", "Theorems", "Solutions"]\n\n[[lean_lib]]\nname = "Definitions"\nglobs = ["Definitions.**"]\n\n[[lean_lib]]\nname = "Theorems"\nglobs = ["Theorems.**"]\n\n[[lean_lib]]\nname = "Solutions"\nglobs = ["Solutions.**"]\n')
        (self.out/'lean-toolchain').write_text((self.root/'lean-toolchain').read_text())
        for lib in ('Definitions','Theorems','Solutions'):
            (self.out/(lib+'.lean')).write_text('-- Generated library root; payload modules are built by Lake globs.\n')
        manifest=dict(schema_version=1,project_tag='collatz-work-import',source=dict(repository=repo,commit=commit),environment=dict(toolchain=(self.root/'lean-toolchain').read_text().strip(),mathlib_rev=None),validation=dict(status='pending',remote_status='not_submitted',required=['exact upload text compilation','exact elaborated type comparison','metadata review','platform environment pin check']),items=items)
        manifest['files']={str(p.relative_to(self.out)):sha(p) for p in self.out.rglob('*') if p.is_file() and '.lake' not in p.parts and p.name!='manifest.json'}
        (self.out/'manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
        print(json.dumps(dict(definitions=len(self.defmods),theorems=len(self.nodes),inline_helpers=len(self.inline),declaration_units=len(self.units),coverage=len(coverage))))

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('root',type=Path);p.add_argument('output',type=Path);a=p.parse_args()
    Generator(a.root.resolve(),a.output.resolve()).generate()
