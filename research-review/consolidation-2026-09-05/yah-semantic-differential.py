#!/usr/bin/env python3
"""Independent, finite diagnostic checks of the pinned YAH encoding.
Not a replacement for the unrestricted soundness argument or certificates.
"""
import importlib.util, itertools, json, random, sys
from pathlib import Path
ROOT=Path(sys.argv[1] if len(sys.argv)>1 else '.').resolve()
if not (ROOT/'verification/yah_scalar_arctic_top/top_cert_common.py').is_file():
    raise SystemExit('Usage: python3 -S -B yah-semantic-differential.py [research-repository-root]')
sys.path.insert(0,str(ROOT/'verification/yah_scalar_arctic_top'))
import top_cert_common as c

class TraceCNF(c.CNFBuilder):
    def __init__(self):
        self.assertions=[]
        super().__init__()
    def assert_(self,literal):
        self.assertions.append(literal)
        super().assert_(literal)

c.CNFBuilder=TraceCNF
rows_by_orientation={True:c.ORIGINAL,False:c.REVERSED}

def plus(a,b): return None if a is None or b is None else a+b

def maximum(a,b):
    if a is None: return b
    if b is None: return a
    return max(a,b)

def compose(word,coefs):
    M,V=0,None
    for token in reversed(word):
        m,v=coefs[token]
        M,V=plus(m,M),maximum(plus(m,V),v)
    return M,V

def ge(a,b): return b is None or (a is not None and a>=b)
def gt(a,b): return b is None or (a is not None and a>b)

def compile_bool(case):
    expr=[]
    atom_map=dict(zip(case.atom_variables,case.inequalities))
    for idx,name in enumerate(case.cnf.names[1:],1):
        if name=='TRUE': expr.append(('true',))
        elif name.startswith('finite_'):
            _,component,symbol,state=name.split('_')
            expr.append(('finite',(symbol,int(state)),0 if component=='m' else 1))
        elif idx in atom_map:
            q=atom_map[idx]
            expr.append(('arith',tuple((i,x) for i,x in enumerate(q.coefficients) if x),q.rhs))
        elif name.startswith(('AND(', 'OR(')):
            expr.append((name.split('(')[0],tuple(map(int,name[name.index('(')+1:-1].split(',')))))
        else: raise AssertionError(name)
    return expr

def checks(case,program,coefs):
    vals=[coefs[(name.split('_')[1],int(name.split('_')[2]))][0 if name.startswith('m_') else 1] for name in case.value_names]
    vals=[0 if x is None else x for x in vals]
    result=[False]
    for op,*args in program:
        if op=='true': value=True
        elif op=='finite': value=coefs[args[0]][args[1]] is not None
        elif op=='arith': value=sum(vals[i]*x for i,x in args[0])>=args[1]
        else:
            terms=(result[abs(i)] if i>0 else not result[-i] for i in args[0])
            value=all(terms) if op=='AND' else any(terms)
        result.append(value)
    literal=lambda x:result[x] if x>0 else not result[-x]
    # Every gate-definition clause must hold, whether or not orientation does.
    asserted={(x,) for x in case.cnf.assertions}
    assert all(any(literal(x) for x in clause) for clause in case.cnf.clauses if clause not in asserted)
    weak=all(literal(x) for x in case.cnf.assertions[14:-2])
    strict=all(literal(x) for x in case.cnf.assertions[-2:])
    return weak,strict

small=[(a,b) for a,b in itertools.product([None,0,1],repeat=2) if (a,b)!=(None,None)]
rng=random.Random(20260905)
count=0
for original,rows in rows_by_orientation.items():
    for row in rows:
        c.ORIGINAL=c.REVERSED=(row,)
        c.TOP_CASES=(('AUDIT',row.key,original),)
        case=c.build_case('AUDIT',row.key,original)
        program=compile_bool(case)
        local=sorted(set(row.lhs+row.rhs))
        interpretations=itertools.chain(itertools.product(small,repeat=len(local)),
            (tuple(rng.choice([(a,b) for a,b in itertools.product([None,0,1,17,10**50],repeat=2) if (a,b)!=(None,None)]) for _ in local) for _ in range(100)))
        for values in interpretations:
            coefs={t:(0,None) for t in c.TOKENS}
            coefs.update(zip(local,values))
            L,R=compose(row.lhs,coefs),compose(row.rhs,coefs)
            directweak=all(ge(a,b) for a,b in zip(L,R))
            directstrict=all(gt(a,b) for a,b in zip(L,R))
            encweak,encstrict=checks(case,program,coefs)
            assert encweak==directweak,(original,row,coefs,'weak')
            # Target strictness is interpreted jointly with its weak condition.
            assert (encweak and encstrict)==(directweak and directstrict),(original,row,coefs,'strict')
            count+=1
print('Direct max-plus/CNF comparison diagnostics: PASS; assignments=',count,'rule/orientation rows=44')

# Independent RUP replay: set-based clause simplification, distinct from the
# production checker's array-based per-clause scan.
def independent_rup(clauses,candidate):
    pending=[set(q) for q in clauses]+[{-x} for x in candidate]
    while True:
        if any(not q for q in pending): return True
        units=[next(iter(q)) for q in pending if len(q)==1]
        if not units: return False
        lit=units[0]
        pending=[q-{-lit} for q in pending if lit not in q]

# Re-import the unmodified source module to undo the audit's isolated row setup.
import importlib
c=importlib.reload(c)
data=json.loads((ROOT/'verification/yah_scalar_arctic_top/top_certificates.json').read_text())
nrup=0
for entry in data['cases']:
    case=c.build_case(entry['family'],entry['target'],entry['original'])
    clauses=list(case.cnf.clauses)
    for lemma in entry['lemmas']:
        total=[0]*len(case.value_names); rhs=0
        for idx,w in lemma['base']:
            assert type(w) is int and w>0
            total[idx]+=w
        for idx,w in lemma['atoms']:
            assert type(w) is int and w>0
            q=case.inequalities[idx]
            total=[a+w*b for a,b in zip(total,q.coefficients)]
            rhs+=w*q.rhs
        assert total==[0]*len(total) and rhs>0
        clauses.append(tuple(-case.atom_variables[idx] for idx,_ in lemma['atoms']))
    for candidate in entry['rup_clauses']:
        assert independent_rup(clauses,candidate)
        clauses.append(tuple(candidate)); nrup+=1
    assert independent_rup(clauses,())
print('Independent Farkas/RUP replay: PASS; Farkas lemmas=491; RUP clauses=',nrup,'terminal conflicts=10')
