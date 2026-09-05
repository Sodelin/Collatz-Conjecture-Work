#!/usr/bin/env python3
"""Exact tests of a new q=2mod3 guarded burst-exit descent family.

The universal proof is in Q2_Exit_Descent_2026-09-05.md. No closure claim.
"""
import json

def require(ok,msg):
    if not ok:raise RuntimeError(msg)

def valuation(n,p):
    require(n>0,'positive valuation input')
    v=0
    while n%p==0:n//=p;v+=1
    return v

def step(n):return (3*n+1)//2 if n%2 else n//2

def iterate(n,k):
    for _ in range(k):n=step(n)
    return n

def canonical_e(k):return 2+18*((k+16)//18)

def parameters(k,t=0):
    require(k>=0 and t>=0,'nonnegative integer parameters')
    e=canonical_e(k); M=2**(e+1)
    a=(29*pow(27*9**k,-1,M))%M
    b=(25*pow(4*8**k,-1,729))%729
    d=((b-a)*pow(M,-1,729))%729
    u=a+M*d+729*M*t
    return k,e,u

def certificate(k,e,u):
    require(k>=0 and e>=max(2,k+1) and u>=1,'general theorem domain')
    numerator=27*9**k*u-29
    require(numerator%2**(e+1)==0,'essential EXIT guard')
    r=4*8**k*u-5
    m=numerator//2**(e+1)
    return {'k':k,'e':e,'u':u,'root':r,'target':m,'steps':3*k+3+e}

def check(c,require_S=False):
    k,e,u,r,m=(c[a] for a in ['k','e','u','root','target'])
    require(u%8==7,'guard implies exactly the needed exit parity')
    require(valuation(r+5,2)==3*k+2,'exact initial q depth')
    x=r
    for j in range(k):
        require(x==4*8**(k-j)*9**j*u-5,'burst state formula')
        for branch in 'OOE':
            require((x%2==1)==(branch=='O'),'guarded OOE branch')
            x=step(x)
    require(x==4*9**k*u-5,'maximal OOE exit formula')
    require(valuation(x+5,2)==2,'q residue at exit')
    require(valuation(x+1,2)==3,'exact odd-run length at exit')
    for branch in 'OOO'+'E'*e:
        require((x%2==1)==(branch=='O'),'actual exit parity word')
        x=step(x)
    require(x==m and iterate(r,c['steps'])==m,'independent actual T endpoint')
    require(0<m<r,'strict decrease below immutable root')
    if k>=1:
        A=16**(k+1)-27*9**k
        require(A>=13*2**(k-1),'universal coefficient induction bound')
    if require_S:
        require(r%729==20 and m%27==20,'both endpoints in targetS')
        require(valuation(r+7,3)==3,'old-c-normal root')
        v=valuation(4*r+1,3)
        theta=(2**(v-2)*((4*r+1)//3**v))%9
        require((v,theta)==(4,4),'outside every refined ancestor guard')
        if k>=1:
            y=iterate(r,4)
            require(all(iterate(r,j)%27!=20 for j in [1,2,3]),'first positive return time4')
            require(y%27==20 and y>r,'first return grows')
            require(valuation(y+7,3)==3,'first return remains old-c-normal')
        else:
            require(all(iterate(r,j)%27!=20 for j in [1,2,3,4]),'k0 firstreturn time5')

def main():
    count=0
    for k in range(101):
        e=canonical_e(k)
        require(e%18==2 and e>=max(2,k+1),'canonical padding domain')
        if k>=1:require(0<=e-(k+1)<=17,'padding bounded by17')
        for t in [0,1,2,17,1000]:
            c=certificate(*parameters(k,t));check(c,True);count+=1
    for k in [255,511,1023]:
        for t in [0,1,10**40]:
            c=certificate(*parameters(k,t));check(c,True);count+=1
    # General theorem also permits e without target-set congruence.
    general=0
    for k in range(31):
        for delta in [0,1,4]:
            e=max(2,k+1)+delta; M=2**(e+1)
            a=29*pow(27*9**k,-1,M)%M
            for shift in [0,1,19]:
                check(certificate(k,e,a+M*shift));general+=1
    try:
        certificate(1,2,1)
    except RuntimeError as exc:
        require(str(exc)=='essential EXIT guard','negative control rejected by real guard')
    else:
        raise RuntimeError('missing EXIT guard was accepted')
    example=certificate(*parameters(1,0))
    require(example['root']==115931 and example['target']==110045,'fixed arithmetic example')
    require(iterate(example['root'],4)==195635,'fixed firstreturn growth')
    example0=certificate(*parameters(0,0))
    print(json.dumps({'status':'passed','crt_family_replays':count,
      'general_guard_replays':general,
      'first_growing_return_example':dict(example,first_return=195635),
      'k0_example':example0,
      'all_root_ancestor_state':{'v3_4r_plus_1':4,'theta':4},
      'covered_initial_depths':'every q=3k+2 for k>=0, subject to displayed CRT/EXIT guards',
      'scope':'new guarded residual infinite families; no universal exit or termination claim'},indent=2))

if __name__=='__main__':main()
