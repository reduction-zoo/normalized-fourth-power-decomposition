---
status: ready-for-expert-review
openness: supported-within-search-coverage
difficulty: moderate
importance: moderate
tags: [tensor, convex-cones, moment-problems, NP-hardness, Karp-reduction]
last-literature-check: 2026-09-16
---

# Sign-correlation membership to normalized fourth-power decomposition

The [campaign](../../campaigns/normalized-fourth-power-decomposition/state.md)
completed in one of 20 allocated rounds, with a complete rule, general proof,
independent advance and inspected Typst paper. Human expert assessment remains
outstanding. The screening evidence below is retained as historical context;
do not restart the campaign from that snapshot.

The final [literature audit](../../campaigns/normalized-fourth-power-decomposition/work/literature.md)
also addresses Hillar–Lim's explicit unrestricted Grammian hardness claim and
the full-versus-partial source-moment distinction. This supersedes the narrower
initial coverage below without changing the fixed normalized question.

## Fixed question

Construct a deterministic polynomial-time Karp reduction from membership in
the sign-correlation polytope
$C_n=\operatorname{conv}\{ss^T:s\in\{-1,1\}^n\}$ to membership in

$$V_{d,4}=\left\{\sum_{a=1}^r u_a^{\otimes4}:
r\geq0,\ u_a\in\mathbb R^d\right\},$$

restricted to fully symmetric rational tensors T with T[i,i,i,i]=1 and
T[i,i,j,j]=1 for every i,j. Dimension is variable; order is fixed at four.
Source inputs are rational symmetric n-by-n matrices R, n>=1, with diagonal
one. Entries need not already satisfy correlation inequalities. Target inputs
list all sorted four-index entries; symmetry determines every ordered entry.
Malformed encodings are outside each language. The total map sends malformed
source inputs to a fixed normalized NO tensor.

Prove YES/NO equivalence, output size O(n^4 (L+log n)) bits for entry bit bound L,
and a polynomial worst-case bit-operation bound. Implement forward construction
and recovery in fresh processes. A source witness is a rational convex mixture
of sign vectors realizing R. A target witness is a rational convex mixture of
fourth sign powers realizing T. Prove this target certificate convention
equivalent to the unrestricted real power-sum definition on the entire
normalized target domain, and prove polynomial certificate bounds. Recovery
must accept every valid certificate under that convention, not just certificates
constructed in the forward proof. No promise of a supplied decomposition and
no bound on rank is part of the decision question.

Acceptance requires this complete rule, a general proof, independent tests and
review, novelty assessment, and a compiled and inspected Typst paper. Proving
PSD/non-PSD hardness instead is a different question. A counterexample to a
candidate is evidence, not a qualifying positive result.

## Primary literature and exact gap

[Ke and Honorio, JMLR 23(284), 2022](https://jmlr.org/papers/volume23/22-0232/22-0232.pdf),
Section 2 (p. 3), Section 4 and Appendix C (p. 22), define the relevant cone
and discuss unresolved membership complexity with the even-multiplicity
normalization. Their bounded Caratheodory representation defines the same cone
by conic Caratheodory. Their PSD relaxation is a different, larger cone.
The [arXiv record](https://arxiv.org/abs/1911.02161) lists its last revision
in July 2021 and the 2022 journal publication.

[Pitowsky, Mathematical Programming 50, 395–414, 1991](https://link.springer.com/article/10.1007/BF01594946)
establishes correlation-polytope membership hardness. The publisher abstract
was accessible; its full reduction was not inspected. For the source used
here, the explicit affine equivalence from Boolean correlation matrices to
sign correlations was inspected in
[Caprara et al., arXiv:2605.02896v1](https://arxiv.org/html/2605.02896v1),
Section 4.5.2, equations (24)–(25): add a reference sign coordinate, set
R[0,i]=2X[i,i]-1 and R[i,j]=4X[i,j]-2X[i,i]-2X[j,j]+1.
Conversely use (1+R[0,i]+R[0,j]+R[i,j])/4.
This is an exact rational affine equivalence, not an optimization-oracle
argument. The new proposed step is from complete second moments to complete
normalized fourth moments. The cited matrix constructions do not supply it.

## Route and executed screening

Use two target coordinates a_i,b_i per source coordinate. Set even-multiplicity
entries to one, set T[a_i,b_i,a_j,b_j]=R[i,j] for i!=j, and set all other
entries to zero. This explicitly fills the complete tensor.

For completeness, symmetrize a source sign distribution under s -> -s and
introduce independent uniform signs a_i; set b_i=a_i*s_i. Odd unmatched masks
cancel, while the surviving two-pair products are s_i*s_j. These distributions
are proof devices: the instance algorithm evaluates a deterministic formula.
For soundness, normalization gives
sum_a (u_ai^2-u_aj^2)^2=0, so every summand has equal coordinate magnitudes.
Convert it to a sign-power mixture, then recover s_i=a_i*b_i termwise.
Remaining work includes complete quantifier handling, rational certificate
bounds, standalone implementation and independent review of the new lifting.

The [predeclared scope](../evidence/normalized-tensor-scope.md),
[check](../evidence/normalized-tensor-check.py) and
[output](../evidence/normalized-tensor-check.json) record all 31 matrices with
n<=3 and off-diagonals in {-1,0,1}. Independent Z3 5.1.0 rational linear
membership models agreed on 15 YES and 16 NO cases; all 15 extracted mixtures
passed exact checks. Exhaustive mask averaging on 14 source sign vectors
matched all 1,158 tested symmetric coordinates. One Z3/Python witness-filter
repair is recorded in the scope. These are finite checks, not a general proof.

Earlier normalization and moment-completion concerns are preserved in the
[screening history](../evidence/normalized-tensor-screening.md). The experience
index search supplied no applicable entry. No shared entry has been claimed.

## Novelty coverage and assessment

Searches on 2026-09-16 included `"Caratheodory symmetric tensor cone" hardness`,
`"Carathéodory symmetric tensor" complexity membership`,
`"fourth moment" "cut polytope"`, `"fourth" "moments" "NP-complete"`,
`"sum of fourth powers" "membership" "NP-hard"`,
`"completely decomposable tensor" "complexity"`, and
`"Carathéodory" "tensor" "Pitowsky"`.
Earlier queries and limits are in the screening history. No matching lifting
or normalized-cone classification was located. This conclusion combines an
explicit published open question and inspected endpoint distinctions; it is
not proof of priority. Complete decomposability, sign moments and correlation
polytopes are the principal aliases requiring a final literature review.
The HTML endpoint for arXiv:1612.02638 failed and the cut-polytope book returned
403; these sources have not been fully inspected. Unindexed work remains outside
coverage. Do not claim all equivalent formulations have been exhausted.

Difficulty: moderate, provisionally. The finite construction works and the
normalization identity provides a focused converse; certificate and novelty
obligations remain. Importance: moderate. Success would settle a named exact
cone-membership question already connected to high-order clustering, but would
not establish hardness of its PSD relaxation or of approximate numerical fitting.

## Gates and handoff

| Gate | Result | Evidence |
|---|---|---|
| 1. Precise target | Pass | Fixed rational decision languages, witness convention, totality and bounds above |
| 2. Known results | Pass | Matrix affine equivalence supplies the source; normalized tensor lifting is additional |
| 3. Openness | Pass within stated coverage | JMLR explicit question, later source and alias checks; priority remains reviewable |
| 4. Significance | Pass | Exact normalized cone-membership classification |
| 5. Route | Pass | Paired-sign cancellation and normalization rigidity address both directions |
| 6. Initial exercise | Pass | 31 exact decision comparisons and 1,158 mask-coordinate checks |

Campaign: `campaigns/normalized-fourth-power-decomposition`.
Latest allocation: 20 rounds. Stop earlier for a complete result, failed novelty,
or no supported next hypothesis. Preparation precedes round 001. The first round
should formalize the deterministic lifting, certificate-size bound and universal
recovery as one rule; do not count the screening checks again as research rounds.
