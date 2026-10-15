# Normalized symmetric tensor lead

Screened on 2026-09-16. No campaign has been admitted and no research rounds
have been charged. The latest user allocation is 20 additional rounds; its
topic was initially awaiting clarification because the latest campaign already
completed. The standing multi-topic goal permits continued screening; the new
normalized fourth-power question has subsequently been admitted as recorded below.

## Primary evidence

Ke and Honorio, *Exact Partitioning of High-order Models with a Novel Convex
Tensor Cone Relaxation*, JMLR 23(284), 2022,
[paper](https://jmlr.org/papers/volume23/22-0232/22-0232.pdf).
Section 2, printed page 3, defines full symmetry, the PSD tensor cone and the
cone of sums of even powers. Section 4 and Appendix C, printed page 22,
discuss unresolved membership complexity, including the restriction that every
entry whose indices have even multiplicities equals one.

This is a lead, not verified current openness. Generic tensor rank hardness
does not resolve these exact cone and normalization conditions. Conversely,
the paper's use of “NP-hard” cannot establish an ordinary Karp reduction in
the required YES direction without inspecting the underlying construction.
PSD membership is universal; existence of a negative polynomial value is a
different decision language. Rational witness length and universal recovery
remain unspecified, so Gate 1 is on hold; later gates are not assessed.
Difficulty and importance have not been assessed.

## Mathematical diagnostic

For order four, fixing every even-multiplicity tensor entry to one fixes the
even part of its polynomial to

$$\sum_i x_i^4+6\sum_{i<j}x_i^2x_j^2
=3\|x\|_2^4-2\sum_i x_i^4.$$

It is not the radial polynomial $\|x\|_2^4$. A proposed radial quartic
CLIQUE construction therefore does not satisfy the target normalization.
No solver experiment or complete reduction was executed.

A separate direct observation may help check known implications for the
power-sum cone. If $S=\sum_a u_a^{\otimes4}$ has $S_{iiii}=S_{iijj}=1$,
then

$$\sum_a(u_{ai}^2-u_{aj}^2)^2=1+1-2=0.$$

Each nonzero summand consequently has equal coordinate magnitudes. Writing
$u_a=r_as_a$ with $s_a\in\{-1,1\}^n$ gives
$S=\sum_a r_a^4s_a^{\otimes4}$ and $\sum_a r_a^4=1$.
Conversely, any such convex combination has the required normalization.
Thus this normalized slice is the convex hull of fourth sign moments.
This observation is unreviewed; it does not by itself transfer hardness from
pairwise correlation membership: unspecified fourth moments cannot simply
be filled by a reduction without an extension argument.

## Search coverage and next check

Queries included `"Carathéodory symmetric tensor" complexity membership`,
`"tensor" "correlation polytope" membership complexity`,
`"Carathéodory symmetric tensor cone" "hardness"`,
`"symmetric tensor" "even" "entries" "NP-hard" normalized`, and
`"completely decomposable" "tensor" "NP-hard" membership`.
Search results did not supply a verified later solution. That absence is not
evidence of openness. The next bounded screening task is to inspect primary
results on complete fourth sign-moment membership and their reduction direction,
before choosing between this cone target and normalized non-PSD detection.

The experience index search for tensor, quartic, normalization and moment
terms returned no matching entry. No shared experience entry was created:
the diagnostic has not yet changed an admitted construction or stopping rule.

## Subsequent paired-sign investigation

The paired-sign construction resolves the missing fourth-moment completion:
see the [fixed question](../open-problems/normalized-fourth-power-decomposition.md),
[declared finite scope](normalized-tensor-scope.md), and
[exact results](normalized-tensor-check.json). Source membership is now the
sign-correlation polytope; target membership is the normalized power-sum cone,
not the PSD cone. The later card supersedes the initial Gate 1 hold without
claiming a reviewed result. Additional queries included fourth-moment/cut-polytope
membership, sum-of-fourth-powers membership hardness, and complete decomposability.
