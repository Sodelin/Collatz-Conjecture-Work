# Round 6A public review note

## Quantitative rational-period β-debt necessity for corrected-log Collatz rankings

**Status:** unreviewed mathematical claim; no proof or disproof of the Collatz conjecture; no certified novelty claim.

This note isolates the central Round 6A theorem so that an independent mathematician or proof-assistant user can check the argument without first reading the full research archive.

Let

$$
S(n)=\frac{3n+1}{2^{\nu_2(3n+1)}}
$$

be the accelerated odd-to-odd Collatz map on positive odd integers.

Fix a repelling rational periodic valuation word of length $m$, total valuation $A$, and real return multiplier

$$
\lambda=\frac{3^m}{2^A}>1.
$$

Let

$$
V(n)=\alpha\log n+R(n),\qquad \alpha>0.
$$

Assume that for some fixed

$$
0<\beta<\frac mA,
$$

every sufficiently large positive odd $n$ has some accelerated stopping time

$$
1\le \tau\le \lfloor\beta\log_2 n\rfloor
$$

such that

$$
V(S^\tau n)\le V(n).
$$

For a depth-$r$ positive integer shadow realizing $r$ repetitions of the periodic word, write the displayed states as $n_0,n_1,\ldots,n_{rm}$. Define the phasewise downward correction debt by

$$
\Delta_{r,i}=R(n_i)-\min_k R(n_{i+km}),
\qquad
\Delta_r=\max_{0\le i<m}\Delta_{r,i}.
$$

Let $j_r$ be the **last** index attaining the global minimum of $V$ on the displayed shadow and write

$$
j_r=i_r+k_rm,\qquad 0\le i_r<m.
$$

Put

$$
L_\lambda=\log_2\lambda=m\log_2 3-A.
$$

### Theorem 6A.1

Under the assumptions above,

$$
\boxed{
\liminf_{r\to\infty}\frac{k_r}{r}
\ge
\eta_\beta(m,A)
:=
\frac{m-\beta A}{m+\beta L_\lambda}
>0.
}
$$

Consequently,

$$
\boxed{
\liminf_{r\to\infty}\frac{\Delta_r}{r}
\ge
\alpha\,\eta_\beta(m,A)\log\lambda.
}
$$

### Proof

Because $j_r$ is the last global minimizer of the potential on the displayed shadow, every displayed state after $j_r$ has strictly larger potential. Therefore no descent from

$$
N_r:=n_{j_r}
$$

occurs during the remaining displayed suffix of length

$$
H_r=rm-j_r.
$$

The assumed universal descent property must therefore extend beyond that suffix:

$$
\lfloor\beta\log_2 N_r\rfloor>H_r.
$$

Hence

$$
\beta\log_2N_r\ge H_r+1.
$$

For the phase $i_r$, the first displayed occurrence has

$$
\log_2 n_{i_r}=rA+O(1).
$$

Exact same-phase scaling about the rational periodic point multiplies displacement by $\lambda$ on each period return, so

$$
\log_2N_r=rA+k_rL_\lambda+O(1).
$$

Also

$$
H_r=rm-i_r-k_rm=m(r-k_r)+O(1).
$$

Substitution gives

$$
\beta\bigl(rA+k_rL_\lambda+O(1)\bigr)
\ge
m(r-k_r)+O(1).
$$

Divide by $r$ and rearrange:

$$
\frac{k_r}{r}\bigl(m+\beta L_\lambda\bigr)
\ge
m-\beta A+o(1).
$$

Taking the lower limit proves the first inequality.

The previously reconstructed same-phase debt inequality for a repelling rational periodic shadow gives, whenever $k_r>0$,

$$
\Delta_r>\alpha k_r\log\lambda.
$$

The first part shows that $k_r$ is asymptotically at least a positive fraction of $r$. Divide the debt inequality by $r$ and take the lower limit to obtain

$$
\liminf_{r\to\infty}\frac{\Delta_r}{r}
\ge
\alpha\eta_\beta(m,A)\log\lambda.
$$

This proves the claimed necessity result, conditional only on the rational-period positive-shadow realization and exact same-phase scaling lemmas.

## Distributed high-period consequence

For the explicit valuation words

$$
w_m=(2,1^{m-1}),
$$

one has

$$
A=m+1,
\qquad
\lambda_m=\frac{3^m}{2^{m+1}},
\qquad
\frac{m}{A}=\frac{m}{m+1}\to1.
$$

For fixed $0<\beta<1$, define

$$
a_2=\log_2(3/2),
\qquad
\rho_\beta=\frac{1-\beta}{1+\beta a_2},
$$

and

$$
\eta_{\beta,m}
=
\frac{m(1-\beta)-\beta}
{m(1+\beta a_2)-\beta}.
$$

The normalized necessary phase-debt rate is

$$
Q_{\beta,m}
=
\eta_{\beta,m}
\frac{\log\lambda_m}{m\log(3/2)}.
$$

Elementary limits give

$$
\boxed{Q_{\beta,m}\to\rho_\beta\qquad(m\to\infty).}
$$

The same coefficient $\rho_\beta$ had arisen independently as the inverse sharp debt-versus-tail frontier on the principal $-1$ skeleton. Round 6A therefore proposes a quantitative bridge between local sharpness and an infinite family of rational periodic stress sites.

## What this does and does not claim

- It is a **necessary-condition theorem for a class of corrected-log ranking functions**.
- It does **not** prove that all Collatz trajectories converge.
- It does **not** disprove the possibility of rankings outside the stated hypotheses.
- The algebra has undergone internal reconstruction and executable stress tests, but no independent human specialist has yet certified the proof.
- No Lean formalization currently exists.
- The exact formulation was not found in the targeted literature search, but that is **not** a novelty certification. The result may be a folklore or immediate corollary of classical rational-cycle / 2-adic shadow machinery.

## Highest-priority independent checks

1. Prove that the positive integer lift realizes the repeated valuation word **exactly**, including the endpoint valuation.
2. Verify exact same-phase scaling around the associated rational periodic point.
3. Check the bit-length asymptotic $\log_2N_r=rA+k_r\log_2\lambda+O(1)$.
4. Check the floor endpoint and last-global-minimum argument.
5. Reconstruct the same-phase debt inequality independently.
6. Search for prior formulations in rational-cycle, 2-adic Collatz, amortized-ranking, and program-termination literature.

The corresponding executable checker and claim ledger are stored beside this note in the repository.
