#!/usr/bin/env python3
"""Guarded v3(4r+1)>=13 smaller-S-ancestor theorem: exact independent replay."""
import json
from fractions import Fraction

# t: h, inverse tail, minimum v. t4 is split by the five TAILS below.
BASE = {1:(1,'EEEEEE',13), 2:(1,'EE',7), 5:(2,'EEEE',11),
        7:(1,'',4), 8:(2,'EEEE',11)}
# modulus, z residue, chronological inverse word, minimum v, 2^length, 3^Ocount, offset
TAILS = [(81,38,'EEO',6,8,3,1), (81,65,'OEEE',7,16,3,8),
         (243,11,'OEEEOE',8,64,9,38),
         (243,92,'EEOEEOEE',11,256,9,44),
         (243,173,'EEOOE',6,32,9,10)]

def require(condition,message):
    if not condition:
        raise RuntimeError(message)

def v3(n):
    require(n>0,'positive valuation input')
    v=0
    while n%3==0:
        n//=3; v+=1
    return v

def step(n):
    return (3*n+1)//2 if n%2 else n//2

def iterate(n,k):
    for _ in range(k): n=step(n)
    return n

def inverse_word(n,w):
    for letter in w:
        if letter=='E': n*=2
        else:
            require(n%3==2,'illegal odd inverse')
            n=(2*n-1)//3
        require(n>0,'positive inverse state')
    return n

def certificate(r):
    require(r>0 and r%27==20,'positive residue20 root')
    v=v3(4*r+1)
    if v<4: return None
    u=(4*r+1)//3**v
    t=(pow(2,v-2,9)*u)%9
    if t==4:
        h=1
        z=2**(v-2)*3*u-1
        rows=[row for row in TAILS if z%row[0]==row[1]]
        require(len(rows)==1,'exactly one refined tail')
        mod,res,word,threshold,A,D,C=rows[0]
        if v<threshold:return None
        require((A*z-C)%D==0,'exact tail endpoint division')
        m=(A*z-C)//D
    else:
        h,word,threshold=BASE[t]
        if v<threshold:return None
        z=2**(v-h-1)*3**h*u-1
        m=2**len(word)*z
    return {'root':r,'target':m,'steps':v-h+1+len(word),
            'valuation':v,'unit_class':t,'h':h,'tail':word,'z':z}

def check(c):
    r,m=c['root'],c['target']
    require(0<m<r,'strict immutable-root decrease')
    require(m%27==20,'target stays inS')
    require(v3(r+7)==3,'root missed by old internal c reduction')
    require(inverse_word(c['z'],c['tail'])==m,'tail formula and guarded word agree')
    require(iterate(m,c['steps'])==r,'actual forward T^b(m)=r')

def main():
    # Exact finite modular coverage of all z=11mod27 at common modulus243.
    for a in range(11,243,27):
        matches=[row for row in TAILS if a%row[0]==row[1]]
        require(len(matches)==1,'tail cylinders are disjoint and exhaustive')
        mod,res,w,minv,A,D,C=matches[0]
        require(A==2**len(w) and D==3**w.count('O'),'tail powers')
        # The affine offset recursion is independent of listed endpoint constants.
        offset=0; odds=0
        for letter in w:
            offset=2*offset+(3**odds if letter=='O' else 0)
            odds+=(letter=='O')
        require(offset==C,'tail affine offset')
        require(((A*a-C)//D)%27==20 and (A*a-C)%D==0,'target cylinder arithmetic')
        for q in [0,1,2,7,10**30]:
            z=a+243*q
            require(inverse_word(z,w)==(A*z-C)//D,'large and small unit-tail guards')
        require(Fraction(3*A*2**minv,D*3**minv)<1,'refined row coefficient threshold')
        require(Fraction(3*A*2**(minv-1),D*3**(minv-1))>=1,
                'refined row slope threshold sharp')
    require(Fraction(192*2**13,3**13)<1,'universal bound at13')
    require(Fraction(192*2**12,3**12)>1,'selected universal bound fails at12')
    n=0
    for v in range(4,61):
        for u in range(1,3001):
            if u%3==0 or (3**v*u-1)%4:continue
            r=(3**v*u-1)//4
            c=certificate(r)
            if c:
                check(c); n+=1
            if v>=13:require(c is not None,'full coverage at valuation>=13')
    for v in [127,256,1024]:
        for u0 in [1,17,109,1000000007]:
            u=next(u0+i for i in range(12)
                   if (u0+i)%3 and (3**v*(u0+i)-1)%4==0)
            c=certificate((3**v*u-1)//4)
            require(c is not None,'large valuation coverage');check(c);n+=1
    require(certificate(425) is None,'root425 remains explicitly uncovered')
    # Selected-table sharpness, not a no-go for every other inverse word.
    r12=(3**12*13-1)//4
    z12=3*2**10*13-1
    m12=64*z12
    require(r12==1727183 and m12==2555840 and m12>r12,'v12 sharpness witness')
    require(iterate(m12,18)==r12,'v12 identity survives but order fails')
    require(certificate(r12) is None,'reject unguarded v12 table branch')
    # Old v20 failure is now correctly covered by a different inverse tail.
    repaired=certificate((3**20*13-1)//4)
    require(repaired is not None,'old selected-v20 failure now covered');check(repaired)
    witness=certificate((3**13*103-1)//4)
    require(witness is not None and witness['root']%432==425,'self-loop family atv13')
    check(witness)
    r=witness['root']; q=iterate(r,3)
    require((8*q-7)%9==0 and (8*q-7)//9==r,'old firstreturn normalization cancels')
    require(all(iterate(r,j)%27!=20 for j in [1,2]),'first positive return')
    print(json.dumps({'status':'passed','finite_replays':n,
        'universal_theorem':'every r=20mod27 with v3(4r+1)>=13 has a smaller explicit inS ancestor',
        'covered_old_self_loop_example':witness,
        'old_v20_failure_repaired':repaired,
        'v12_counterexample_to_removing_selected_guard':{'root':r12,'candidate':m12,'steps':18},
        'uncovered_425':True,'scope':'guarded infinite family; not universal termination'},indent=2))

if __name__=='__main__':main()
