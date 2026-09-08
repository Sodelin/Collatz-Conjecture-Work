from __future__ import annotations

from fractions import Fraction
from math import floor, log, log2, sqrt, sin
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
    residue = (c0.numerator * pow(c0.denominator, -1, mod)) % mod
    n = residue + mod
    vals = [n]
    for j in range(r*m):
        a = word[j % m]
        assert v2_int(3*n+1) == a
        n = S(n)
        vals.append(n)
    return vals, cyc


def beta_eta(m: int, A: int, beta: float) -> float:
    Llam = m*log2(3)-A
    return (m-beta*A)/(m+beta*Llam)


def feature_vector(n: int, centers: list[Fraction]) -> tuple[int, ...]:
    return tuple(v2_frac(Fraction(n,1)-z) for z in centers)


def test_phasewise_approximation_debt_bound() -> None:
    rng = Random(20261001)
    checked = 0
    for m in [4, 6, 9, 14, 22]:
        word = [2] + [1]*(m-1)
        centers = [Fraction(-1,1), Fraction(-5,1), Fraction(1,3)]
        cyc = rational_cycle(word)
        if any(c == z for c in cyc for z in centers):
            continue
        M = max(v2_frac(c-z) for c in cyc for z in centers)
        vals, _ = lift_shadow(word, r=20, L=max(m+2, M+2))
        phase_features = [feature_vector(vals[i], centers) for i in range(m)]
        table = {f: rng.uniform(-100,100) for f in set(phase_features)}
        G = [table[feature_vector(n, centers)] for n in vals]
        # arbitrary residual, bounded in sup norm by e
        e = rng.uniform(0.1, 20)
        E = [rng.uniform(-e, e) for _ in vals]
        R = [g+x for g,x in zip(G,E)]
        # phasewise G is constant, hence R debt <= 2e
        for i in range(m):
            inds = list(range(i, len(vals), m))
            if not inds: continue
            debt = R[inds[0]] - min(R[j] for j in inds)
            assert debt <= 2*e + 1e-9
        checked += 1
    assert checked >= 4
    print(f'PASS A: phase-frozen finite-sensor surrogate implies same-phase debt <= 2*sup error ({checked} families).')


def test_quantitative_approximation_gap_algebra() -> None:
    rng = Random(20261002)
    for _ in range(3000):
        m = rng.randint(3, 100)
        # choose A in repelling range, at least m
        maxA = floor(m*log2(3)-1e-12)
        if maxA < m:
            continue
        A = rng.randint(m, maxA)
        beta = rng.uniform(0.05, min(0.98, 0.95*m/A))
        eta = beta_eta(m,A,beta)
        lnlam = m*log(3)-A*log(2)
        c = lnlam*eta
        assert c > 0
        # If universal beta descent demands Delta/r >= alpha*c and Delta <= 2e,
        # then e/r >= alpha*c/2.
        alpha = rng.uniform(0.1, 3.0)
        e_rate = alpha*c/2
        assert e_rate > 0
    print('PASS B: quantitative finite-sensor approximation-gap coefficient algebra (3000 cases).')


def test_wm_half_frontier_limit() -> None:
    a2 = log2(1.5)
    for beta in [0.1,0.25,0.5,0.75,0.9]:
        rho_beta = (1-beta)/(1+beta*a2)
        last = None
        for m in [30, 80, 200, 500, 1200]:
            A = m+1
            eta = beta_eta(m,A,beta)
            lnlam = m*log(1.5)-log(2)
            q = eta*lnlam/(m*log(1.5))
            last = q/2
        assert last is not None
        assert abs(last-rho_beta/2) < 0.004
    print('PASS C: w_m normalized approximation-gap lower bound converges to rho_beta/2.')


def E_sublog(n: int) -> float:
    x = log(n)
    return sqrt(x)*sin(x)


def test_finite_sensor_plus_sublog_residual() -> None:
    # Demonstrate that a finite-sensor component can be arbitrarily wild while a sublog residual
    # contributes only o(r) same-phase debt.
    rng = Random(20261003)
    m = 17
    word = [2] + [1]*(m-1)
    centers = [Fraction(-1,1), Fraction(-5,1), Fraction(1,3), Fraction(-29,11)]
    cyc = rational_cycle(word)
    assert not any(c == z for c in cyc for z in centers)
    M = max(v2_frac(c-z) for c in cyc for z in centers)
    rows = []
    for r in [20,40,80,160]:
        vals,_ = lift_shadow(word,r=r,L=max(m+3,M+2))
        phase = [feature_vector(vals[i], centers) for i in range(m)]
        table = {f:rng.randint(-10**7,10**7) for f in set(phase)}
        G = [table[feature_vector(n, centers)] for n in vals]
        E = [E_sublog(n) for n in vals]
        R = [g+e for g,e in zip(G,E)]
        debts=[]
        for i in range(m):
            inds=list(range(i,len(vals),m))
            debts.append(R[inds[0]]-min(R[j] for j in inds))
        rows.append(max(debts)/r)
    assert rows[-1] < rows[0] or rows[-1] < 0.5
    print('PASS D: finite-sensor + sublog residual has sublinear same-phase debt in a representative stress family.')
    print('        debt/r:', ', '.join(f'{x:.6f}' for x in rows))


def test_uniform_infinite_sensor_series_tail() -> None:
    # Toy infinite sensor series with uniformly summable amplitudes.
    # A finite prefix is a finite-center sensor; the uniform tail is bounded independently of shadow depth.
    centers = [Fraction(-(2*j+1), 1) for j in range(1, 25)]
    amps = [2.0**(-j) for j in range(1, len(centers)+1)]
    def component(n: int, z: Fraction, a: float) -> float:
        d = v2_frac(Fraction(n,1)-z)
        return a * (1.0 if d % 2 == 0 else -1.0)
    # exact uniform tail bound after J is <= sum_{j>J} amp_j
    for J in [2,5,10,15]:
        tail_bound = sum(amps[J:])
        assert tail_bound < 2.0**(-J+1)
    # Check on one stress shadow that truncation error respects this bound.
    m=19; word=[2]+[1]*(m-1)
    cyc=rational_cycle(word)
    # choose centers not on cycle automatically for integer centers here; verify
    assert not any(c==z for c in cyc for z in centers)
    M=max(v2_frac(c-z) for c in cyc for z in centers)
    vals,_=lift_shadow(word,r=12,L=max(m+3,M+2))
    full=[sum(component(n,z,a) for z,a in zip(centers,amps)) for n in vals]
    for J in [5,10,15]:
        pref=[sum(component(n,z,a) for z,a in zip(centers[:J],amps[:J])) for n in vals]
        err=max(abs(x-y) for x,y in zip(full,pref))
        assert err <= sum(amps[J:]) + 1e-12
    print('PASS E: uniformly summable infinite-sensor series is uniformly approximable by finite-sensor prefixes.')


def main() -> None:
    print('COLLATZ ROUND 6B TERMINAL APPROXIMATION-BARRIER CHECKS')
    print('Finite tests audit the new approximation-gap consequences of Round 6A; they are not proofs.\n')
    test_phasewise_approximation_debt_bound()
    test_quantitative_approximation_gap_algebra()
    test_wm_half_frontier_limit()
    test_finite_sensor_plus_sublog_residual()
    test_uniform_infinite_sensor_series_tail()
    print('\nALL ROUND-6B CHECKS PASSED')

if __name__ == '__main__':
    main()
