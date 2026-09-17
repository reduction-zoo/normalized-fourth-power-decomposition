# Literature position of the normalized lifting

Checked on 2026-09-16. This note addresses the actual candidate theorem, not
the broader tensor-rank or PSD-detection problems. The independent
[audit](../history/campaigns/normalized-fourth-power-decomposition/reviews/paired-sign/review.md) records its searches and targeted checks.

## Closest fourth-power claim

Hillar and Lim, *Most Tensor Problems Are NP-Hard*, Journal of the ACM 60(6),
Article 45 (2013), Section 11, equation (35) and Theorem 11.2, explicitly states
hardness of Grammian tensors and sums of fourth powers of linear forms.
[Journal-text copy](https://www.cs.cornell.edu/courses/cs6241/2020sp/readings/hillar-2013-nphard.pdf);
[arXiv](https://arxiv.org/pdf/0911.1393), Section 11, pp. 29–30 in the inspected
38-page prepublication PDF. Their cone representation is the unrestricted one
used here. We do not claim to introduce that unrestricted hardness statement.

The displayed construction sets S_ijkl=A_ij when i=k and j=l and zero otherwise.
For the all-one 2-by-2 matrix A, this gives S_1212=1 but S_1122=0. It therefore
does not produce a fully symmetric tensor, whereas every fourth-power sum is
fully symmetric. The displayed reduction also leaves the campaign's prescribed
even-multiplicity entries unfixed. This identifies missing premises in the
displayed implication; it does not prove that the published theorem is false
or that no repair exists. Symmetrization alone would need its own decomposition
equivalence argument. We use neither this tensor map nor a duality-based oracle
reduction as the source of the present Karp theorem.

Ke and Honorio, *Exact Partitioning of High-order Models with a Novel Convex
Tensor Cone Relaxation*, JMLR 23(284), 2022, define the power-sum cone on p. 3
and the even-multiplicity normalization on p. 5. Section 4 and Appendix C
discuss the remaining hardness issue under this normalization.
[Primary paper](https://jmlr.org/papers/volume23/22-0232/22-0232.pdf).
Our theorem concerns exactly normalized membership at order four. Their
statistical optimization program also contains a balance constraint: no
hardness theorem for that entire program is obtained here. The PSD relaxation
and approximate fitting are likewise separate problems.

## Full source matrices, not partial marginal specifications

The source is conv{ss^T:s in {-1,1}^n}, with every matrix entry supplied.
Its affine equivalence with conv{xx^T:x in {0,1}^n} uses an extra reference
coordinate. On vertices take s_0=1 and s_i=2x_i-1; from an arbitrary sign
vertex recover x_i=(1+s_0*s_i)/2. Taking convex combinations gives the
entrywise rational maps stated in question.md. No unknown moment is filled
by an oracle or by an existence assumption.

Krause, Scherer, Schwinn and Werner, *Membership testing for Bernoulli and
tail-dependence matrices*, 2017 preprint, Proposition 1.1 and Remark 1.2,
p. 4, define the complete Boolean matrix polytope. Section 2.2, p. 12,
attributes NP-completeness to Pitowsky Sections 3.1 and 3.3.
[Primary preprint](https://optimization-online.org/wp-content/uploads/2017/08/6168.pdf).
Caprara et al., *Hardness of some optimization problems over correlation
polyhedra*, arXiv:2605.02896v1, Section 4.1, states the same full-matrix
hardness dependency; Section 4.5.2 gives the reference-coordinate affine map.
[Primary preprint](https://arxiv.org/html/2605.02896v1).
No unrelated rank claim from that paper is used.

Pitowsky, *Correlation polytopes: Their geometry and complexity*, Mathematical
Programming 50, 395–414 (1991), is the original cited result.
[Publisher](https://link.springer.com/article/10.1007/BF01594946).
Its abstract was accessible, but its original proof was not inspected. The
hardness premise rests on the explicit later primary-paper attribution to the
full matrix problem. This limitation remains visible in the proof and paper.
Hardness of a projection onto an arbitrary partial graph would not on its own
prove the needed full-data Karp hardness.

## Equivalent formulations and remaining coverage

The review also inspected complete decomposability in Qi et al., *Regularly
Decomposable Tensors and Classical Spin States* (2017), Section 2, equation
(2.1), and Section 4.3, Proposition 4.2
([paper](https://ira.lib.polyu.edu.hk/bitstream/10397/67387/1/BQZ17_cms.pdf)),
and Qi, Cui and Xu, *Structured Symmetric Tensors*, Sections 2–7
([preprint](https://arxiv.org/html/2511.06966v1)).
Their inspected definitions and cone results do not supply this complete
paired-sign lifting. No previous explicit normalized classification was
located within the searches recorded in the question and independent audit.
Unindexed work, inaccessible originals and possible repairs of earlier claims
remain outside coverage. Novelty is plausible within this coverage, not a
guarantee of priority. Significance is moderate: the new restriction and explicit
complete moment fill strengthen a named membership classification.
