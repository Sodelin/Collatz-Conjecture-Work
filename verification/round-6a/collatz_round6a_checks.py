from __future__ import annotations

from fractions import Fraction
from math import ceil, floor, log, log2
from random import Random


def v2_int(n: int) -> int:
    n = abs(n)
    if n == 0:
        raise ValueError('v2(0)')
    c = 0
    while n % 2 == 0:
        n //= 2
        c += 1
    return c


def v2_frac(x: Fraction) -> int:
    if x == 0:
        raise ValueError('v2(0)')
    return v2_int(x.numerator) - v2_int(x.denominator)


def S(n: int) -> int:
    assert n > 0 and n % 2 == 1
    z = 3*n + 1
    return z // (2 ** v2_int(z))


def word_constant(word: list[int]) -> tuple[int, int]:
    A = 0
    C = 0
    m = len(word)
    for j, a in enumerate(word):
        C += (3 ** (m-1-j)) * (2 ** A)
        A += a
    return A, C


def rational_cycle(word: list[int]) -> list[Fraction]:
    m = len(word)
    A, C = word_constant(word)
    assert 3**m > 2**A
    c0 = Fraction(C, 2**A - 3**m)
    vals = [c0]
    x = c0
    for i, a in enumerate(word):
        z = 3*x + 1
        assert v2_frac(z) == a
        x = z / (2**a)
        if i < m-1:
            vals.append(x)
    assert x == c0
    assert all(c < 0 for c in vals)
    return vals


def lift_shadow(word: list[int], r: int, L: int) -> tuple[list[int], list[Fraction]]:
    m = len(word)
    A, _ = word_constant(word)
    cyc = rational_cycle(word)
    c0 = cyc[0]
    M = r*A + L
    mod = 2**M
    den = c0.denominator
    assert den % 2 == 1
    residue = (c0.numerator * pow(den, -1, mod)) % mod
    n0 = residue + mod
    assert mod <= n0 < 2*mod and n0 % 2 == 1
    vals = [n0]
    n = n0
    for j in range(r*m):
        a = word[j % m]
        assert v2_int(3*n+1) == a
        n = S(n)
        vals.append(n)
    return vals, cyc


def last_min_index(values: list[float]) -> int:
    mv = min(values)
    tol = 1e-10 * max(1.0, abs(mv))
    return max(i for i, x in enumerate(values) if abs(x-mv) <= tol)


def principal_state(K: int, t: int) -> int:
    return (2**(K-t))*(3**t)-1


def prescribed_R(alpha: float, K: int, t: int, dK: int, epsK: float) -> float:
    n = principal_state(K, t)
    gamma = alpha*log(1.5) + epsK
    return alpha*log((n+1)/n) - gamma*min(t, dK)


def test_5a_prescribed_minima_and_frontier() -> None:
    alpha = 1.37
    schedules = [
        lambda K: 0,
        lambda K: min(K-1, 3),
        lambda K: floor(K**0.5),
        lambda K: floor(0.37*K),
        lambda K: floor((0.15 if K % 2 else 0.72)*K),
    ]
    for sched in schedules:
        for K in [30, 60, 100, 160]:
            d = sched(K)
            epsK = 1/(K+7)
            vals = [principal_state(K,t) for t in range(K)]
            R = [prescribed_R(alpha,K,t,d,epsK) for t in range(K)]
            V = [alpha*log(n)+r for n,r in zip(vals,R)]
            assert last_min_index(V) == d
    a2 = log2(1.5)
    for rho in [0.0,0.1,0.25,0.5,0.75,0.9]:
        for K in [250,500,1000]:
            d=floor(rho*K)
            epsK=1/(K*K)
            vals=[principal_state(K,t) for t in range(K)]
            R=[prescribed_R(alpha,K,t,d,epsK) for t in range(K)]
            debt=R[0]-min(R)
            N=vals[d]
            H=K-1-d
            nr=debt/(alpha*K*log(1.5))
            tf=H/log2(N)
            target=(1-rho)/(1+rho*a2)
            if K==1000:
                assert abs(nr-rho) < 0.01
                assert abs(tf-target) < 0.01
    print('PASS A: 5A single-state prescribed minima and sharp frontier reconstructed.')


def test_rational_period_lift_and_same_phase() -> None:
    rng=Random(20260831)
    checked=0
    for _ in range(500):
        m=rng.randint(2,12)
        word=[1]*m
        inds=list(range(m))
        rng.shuffle(inds)
        for i in inds[:rng.randint(0,max(0,min(3,m-1)))]:
            word[i]=2
            A,_=word_constant(word)
            if not (3**m>2**A):
                word[i]=1
        A,_=word_constant(word)
        if not (3**m>2**A):
            continue
        r=rng.randint(3,18)
        L=rng.randint(1,6)
        vals,cyc=lift_shadow(word,r,L)
        lam=Fraction(3**m,2**A)
        for i in range(m):
            inds2=list(range(i,len(vals),m))
            for p in range(len(inds2)-1):
                j,k=inds2[p],inds2[p+1]
                assert Fraction(vals[k],1)-cyc[i] == lam*(Fraction(vals[j],1)-cyc[i])
                assert Fraction(vals[k], vals[j]) > lam
        checked += 1
    assert checked>350
    print(f'PASS B: rational-period lift and same-phase scaling ({checked} random repelling words).')


def test_5b_arbitrary_depth_tax() -> None:
    rng=Random(20260901)
    for m in [3,5,8,13,21,34]:
        word=[2]+[1]*(m-1)
        cyc=rational_cycle(word)
        depths=[v2_frac(c+1) for c in cyc]
        assert depths == [1,m]+list(range(m-1,1,-1))
        L=max(depths)+2
        table={d:rng.randint(-10**8,10**8) for d in depths}
        vals,_=lift_shadow(word,r=40,L=L)
        V=[log(n)+table[v2_int(n+1)] for n in vals]
        jstar=last_min_index(V)
        assert jstar < m
        for j in range(jstar+1,len(vals)):
            assert V[j] > V[jstar] - 1e-6
    print('PASS C: 5B arbitrary F(v2(n+1)) phase-freezing obstruction reconstructed.')


def beta_eta(m: int, A: int, beta: float) -> float:
    Llam = m*log2(3)-A
    return (m-beta*A)/(m+beta*Llam)


def test_rational_beta_debt_algebra() -> None:
    rng=Random(20260902)
    for _ in range(2000):
        m=rng.randint(2,80)
        A=rng.randint(m, max(m, floor(m*log2(3)-1e-9)))
        if not (3**m>2**A):
            continue
        rho=m/A
        beta=rng.uniform(0.05, min(0.95*rho,0.98))
        eta=beta_eta(m,A,beta)
        assert 0 < eta < 1
        Llam=m*log2(3)-A
        lhs=beta*(A+eta*Llam)
        rhs=m*(1-eta)
        assert abs(lhs-rhs) < 1e-10
    print('PASS D: rational-period beta-horizon debt coefficient algebra (2000 cases).')


def test_distributed_wm_limit() -> None:
    a2=log2(1.5)
    for beta in [0.1,0.25,0.5,0.75,0.9]:
        rho_beta=(1-beta)/(1+beta*a2)
        last=None
        for m in [20,50,100,250,500,1000]:
            A=m+1
            eta=beta_eta(m,A,beta)
            lnlam=m*log(1.5)-log(2)
            q=eta*lnlam/(m*log(1.5))
            last=q
        assert last is not None and abs(last-rho_beta)<0.005
    print('PASS E: w_m distributed critical debt rate converges to the 5A inverse frontier.')


def test_finite_center_freezing() -> None:
    centers=[Fraction(-1,1),Fraction(-5,1),Fraction(-7,1),Fraction(-29,11),Fraction(1,3)]
    rng=Random(20260903)
    tested=0
    for m in range(3,22):
        word=[2]+[1]*(m-1)
        cyc=rational_cycle(word)
        if any(c==z for c in cyc for z in centers):
            continue
        M=max(v2_frac(c-z) for c in cyc for z in centers)
        vals,_=lift_shadow(word,r=20,L=max(2,M+2))
        phase=[tuple(v2_frac(c-z) for z in centers) for c in cyc]
        for j,n in enumerate(vals):
            f=tuple(v2_frac(Fraction(n,1)-z) for z in centers)
            assert f==phase[j%m]
        table={f:rng.randint(-10**9,10**9) for f in set(phase)}
        V=[log(n)+table[tuple(v2_frac(Fraction(n,1)-z) for z in centers)] for n in vals]
        assert last_min_index(V)<m
        tested+=1
    assert tested>=12
    print(f'PASS F: finite-center feature freezing ({tested} disjoint w_m families).')


def test_local_one_sided_boundedness_is_insufficient() -> None:
    for K in [10,30,100,300]:
        vals=[principal_state(K,t) for t in range(K)]
        def R(n: int) -> float:
            x=n+1
            if x & (x-1) == 0:
                return float(v2_int(x))
            return 0.0
        rv=[R(n) for n in vals]
        assert min(rv)>=0
        assert rv[0]==K and all(v==0 for v in rv[1:])
        debt=rv[0]-min(rv)
        assert debt==K
    for K in [10,30,100]:
        vals=[principal_state(K,t) for t in range(K)]
        def U(n: int) -> float:
            x=n+1
            if x % 3 == 0 and (x//(3**v3_int(x))) & ((x//(3**v3_int(x)))-1) == 0:
                u=v2_int(x); v=v3_int(x)
                if x == (2**u)*(3**v) and v>=1:
                    return float(-(u+v))
            return 0.0
        uv=[U(n) for n in vals]
        assert max(uv)<=0
        assert uv[0]==0 and min(uv)<=-K
    print('PASS G: explicit counterexamples show one-sided local boundedness cannot replace two-sided/local debt control.')


def v3_int(n: int) -> int:
    n=abs(n)
    if n==0: raise ValueError('v3(0)')
    c=0
    while n%3==0:
        n//=3; c+=1
    return c


if __name__=='__main__':
    print('COLLATZ ROUND 6A VERIFICATION CHECKS')
    print('Purpose: independently stress 5A/5B and test the new distributed ghost-stress synthesis.\n')
    test_5a_prescribed_minima_and_frontier()
    test_rational_period_lift_and_same_phase()
    test_5b_arbitrary_depth_tax()
    test_rational_beta_debt_algebra()
    test_distributed_wm_limit()
    test_finite_center_freezing()
    test_local_one_sided_boundedness_is_insufficient()
    print('\nALL ROUND-6A CHECKS PASSED')
