#import "report.typ": research-report
#show: research-report.with(
  title: "Normalized Fourth-Power Decomposition Is NP‑Complete",
  date: "September 16, 2026",
  status: "Research manuscript — awaiting human expert assessment",
)
#set math.equation(numbering: "(1)")

#heading(numbering: none)[Abstract]
We study exact membership in the cone of sums of real symmetric fourth powers,
restricted to rational tensors whose entries with even index multiplicities
are all one. We give a deterministic polynomial-time reduction from complete
sign-correlation matrix membership. The construction replaces each source
coordinate by a pair and explicitly specifies every target moment. Normalization
forces every real decomposition atom to have equal coordinate magnitudes,
which yields rational sign-mixture certificates and a direct recovery map
from every valid target certificate. The resulting normalized membership
problem is NP-complete. The claim concerns this restricted cone, rather than
positive semidefinite tensor membership or approximate decomposition.

= Introduction

Exact fourth-power decomposition asks whether a symmetric tensor is a sum
of fourth tensor powers of real vectors. This question arises in convex
tensor formulations of high-order partitioning. Ke and Honorio [1] study
such a cone with a normalization that fixes every entry having only even
index multiplicities to one. Their Section 4 and Appendix C discuss the
remaining complexity question for this normalized domain.

The normalization matters. Hillar and Lim [2, Theorem 11.2] already state
hardness of unrestricted Grammian tensors, equivalently sums of fourth
powers of linear forms. That statement does not supply hardness with the
prescribed entries fixed. We establish the restricted result through a
complete moment construction: each source sign is represented by a product
of two target signs. All additional moments receive explicit values, so
the reduction requires neither a completion oracle nor a supplied decomposition.

*Theorem 1 (normalized membership).* Let the input be a fully symmetric
rational tensor of order four and variable dimension $d$, with
$T_(i i i i) = T_(i i j j) = 1$ for all $i,j$. Deciding whether it is a sum
of fourth powers of real vectors is NP-complete. There is a deterministic
Karp reduction from complete sign-correlation matrix membership in dimension
$n$ to this problem in dimension $2n$, with output length
$O(n^4 (L + log(n+1)))$ when each source entry has at most $L$ encoded bits.
The rule includes polynomial-time recovery of a source certificate from
every valid rational sign-mixture certificate of its output.

The NP-hardness premise is the known full Boolean correlation-polytope
membership theorem, attributed to Pitowsky [3] explicitly for complete
matrices by Krause et al. [4]. We use its affine equivalence with complete
sign correlations [5, Section 4.5.2]. The original Pitowsky reduction was not
inspected in this work; our new tensor construction and its proof are
self-contained once that stated source theorem is assumed.

= Normalization and certificates

For a positive integer $d$, write
$cal(V)_(d,4) = {sum_(k=1)^r u_k^(⊗4) : r >= 0, u_k in RR^d}$.
Let $cal(N)_d$ be its normalized slice, defined by
$T_(i i i i)=T_(i i j j)=1$ for every pair of coordinates.
Full symmetry means invariance under every permutation of the four indices.
An input lists the $binom(d+3,4)$ sorted index tuples; no unspecified entries
are allowed. All rational numerators and denominators use finite encodings.

*Lemma 2 (sign atoms).* On the entire normalized domain,
$ cal(N)_d = op("conv") {z^(⊗4) : z in {-1,1}^d}. $ <sign-cone>

*Proof.* Suppose $T=sum_k u_k^(⊗4)$ satisfies the normalization. For any
coordinates $i,j$, the prescribed moments give
$ sum_k (u_(k i)^2-u_(k j)^2)^2
  = T_(i i i i) + T_(j j j j) - 2 T_(i i j j) = 0. $ <rigidity>
Each summand is nonnegative, so each vanishes. Every nonzero vector $u_k$
has a common positive coordinate magnitude $r_k$ and can be written
$u_k=r_k z_k$ with $z_k in {-1,1}^d$. Set $lambda_k=r_k^4$.
The diagonal condition gives $sum_k lambda_k=1$. Conversely, a convex
combination of sign fourth powers is a real fourth-power sum by taking
$u_k=lambda_k^(1/4) z_k$. Zero atoms can be omitted. $square$

*Lemma 3 (rational certificates).* Every rational tensor in $cal(N)_d$
has a polynomial-size rational sign-mixture certificate.

*Proof.* Set $D=binom(d+3,4)+1$, counting the moment equations and the
weight-sum equation. Feasibility in @sign-cone is a linear system in
nonnegative weights with integer coefficient columns in ${-1,1}^D$.
A feasible system has a basic feasible solution with at most $D$ nonzero
weights. Select independent rows on those columns to obtain an invertible
square system.

If each rational right-hand side has at most $L$ bits, the product of its
denominators has $O(D L)$ bits. After clearing denominators, Cramer's rule
and the determinant bound $D^(D/2)$ give
$O(D L + D log D)$
bits per weight. Thus the weights and sign vectors together have
$O(D^2 (L+log D) + D d)$
bits. This proves existence of a short certificate, not a polynomial-time
method for finding it. Exact rational arithmetic verifies the weighted
moments in polynomial time. $square$

= The complete paired-sign rule

The source language consists of rational symmetric matrices with diagonal
one that belong to
$ cal(C)_n = op("conv") {s s^T : s in {-1,1}^n}. $
A source certificate is a rational convex mixture of sign vectors realizing
all entries of the matrix. A target certificate is a rational convex mixture
of sign fourth powers realizing all tensor entries. Neither certificate
must have minimum support; repeated atoms and zero weights are allowed.
Lemma 3 makes this target convention equivalent to unrestricted real
fourth-power membership on the normalized domain.

Use target coordinates $a_1,b_1,dots,a_n,b_n$. For each multiset $I$ of
four coordinate indices, let $O(I)$ denote the indices of odd multiplicity.
Given the complete source matrix $R$, construct the complete tensor
$ T_I = cases(
  1 & "if " O(I)=emptyset,
  R_(i j) & "if " O(I)={a_i,b_i,a_j,b_j} quad i != j,
  0 & "otherwise".
) $ <construction>
This formula is symmetric and has the required normalization on every
source input. It evaluates each output coordinate using only the input
matrix. @pair-figure explains the designated nonconstant moments.

#figure(
  image("figures/paired-sign.svg", width: 100%),
  caption: [Paired-sign construction for distinct indices $i,j$.
  For the completeness proof, the source sign distribution is first averaged
  with its negative; the masks $a_i$ are independent uniform signs and
  $b_i=a_i s_i$. The indicated fourth moment equals the source second moment.
  Recovery multiplies the two coordinates in each pair. Boxes mark coordinate
  pairs, not graph edges. Other moments are specified by @construction.],
) <pair-figure>

The backward map acts termwise on any valid target certificate
${(lambda_k,z_k)}$:
$ s_(k i) = z_(k,a_i) z_(k,b_i). $ <recovery>
It retains the original weights. Both maps are deterministic and operate
without a solver. The probability distributions used below establish
existence and are not part of either executable algorithm.

= Correctness

*Lemma 4 (completeness).* If $R in cal(C)_n$, then the tensor in
@construction belongs to $cal(N)_(2n)$.

*Proof.* Choose a finite sign distribution $S$ realizing $R$. Average it
with its negative. Its first moments become zero, while its second moments
remain $R$. Independently choose uniform signs $A_1,dots,A_n$ and set
$B_i=A_i S_i$.

Consider an arbitrary fourth-degree coordinate product and cancel all even
powers. With no surviving coordinates, its expectation is one. Otherwise,
any block with odd mask degree makes its expectation zero, because that mask
is independent and centered. The only surviving blocks therefore contain
both $A_i$ and $B_i$. One such block contributes $bb(E)[S_i]=0$.
Two distinct blocks contribute $bb(E)[S_i S_j]=R_(i j)$.
Degree four permits no other case. The resulting complete fourth moments
are exactly @construction. Lemma 2 completes the proof. $square$

The conceptual distribution in this argument may have exponentially many
atoms. The instance map never enumerates it, and Lemma 3 supplies a
polynomial-size certificate for the resulting rational tensor.

*Lemma 5 (soundness and universal recovery).* Every valid target
sign-mixture certificate of @construction is mapped by @recovery to a
valid source certificate.

*Proof.* Products of two signs are signs. For distinct $i,j$, validity
of the supplied target certificate gives
$ sum_k lambda_k s_(k i) s_(k j)
  = sum_k lambda_k z_(k,a_i) z_(k,b_i) z_(k,a_j) z_(k,b_j)
  = T_(a_i b_i a_j b_j) = R_(i j). $ <recover-moments>
Diagonal moments are one because $sum_k lambda_k=1$ and $s_(k i)^2=1$.
These identities impose no preferred support or choice of signs on the
certificate. They also cover the one-dimensional source, where there are
no off-diagonal moments. $square$

If a target is feasible in real vectors, Lemmas 2 and 3 give a certificate
to which Lemma 5 applies. Together with Lemma 4, this proves
$ R in cal(C)_n quad arrow.l.r quad T in cal(N)_(2n). $
This is a many-one equivalence between complete instances.

= Encoding, totality and hardness

The forward algorithm enumerates $binom(2n+3,4)$ sorted tuples and evaluates
@construction. Each entry is zero, one or a copied source rational. Parsing,
fraction normalization and symmetry checking take polynomial bit time;
the output has $O(n^4(L+log(n+1)))$ bits. A conservative schoolbook bound
is $O(n^2(L+1)^3+n^4(L+log(n+1)+1)^2)$ bit operations.
For a supplied certificate of encoded length $W$ with $k$ terms, recovery
uses $O(k n)$ sign products and copies its weight strings. Its output size
is $O(W+k n)$, and its running time is polynomial in the total source and
certificate encoding lengths.

Malformed source strings are outside the source language. The total forward
map sends them to the dimension-two normalized tensor whose sorted entries
are $(1,2,1,0,1)$. Its entry of index multiplicity three and one is two,
which exceeds the absolute moment bound of one for sign mixtures; Lemma 2
therefore makes it a NO instance. The recovery guarantee assumes a valid
certificate of the actual output. Behavior outside that premise is unspecified.

For completeness of the hardness chain, a full Boolean moment matrix $X$
maps to a full sign moment matrix with one reference coordinate by
$ R_(0 0)=1, quad R_(0 i)=2X_(i i)-1,
  quad R_(i j)=4X_(i j)-2X_(i i)-2X_(j j)+1. $ <affine>
On vertices this is $s_0=1$, $s_i=2x_i-1$; from an arbitrary sign
vertex recover $x_i=(1+s_0 s_i)/2$. Convex extension gives an exact rational
affine equivalence [5]. Full Boolean moment membership is NP-hard [3,4],
so @affine followed by @construction proves hardness. Lemma 3 proves
membership in NP and completes Theorem 1. No partial-correlation completion
claim is used in this composition.

= Relation to prior tensor hardness

Hillar and Lim [2, Section 11] identify Grammian tensors with positive
combinations of fourth powers and state their unrestricted hardness.
Their displayed matrix construction sets $S_(i j k l)=A_(i j)$ when
$i=k$ and $j=l$, and zero otherwise. For the all-one two-dimensional
matrix this yields $S_(1 2 1 2)=1$ and $S_(1 1 2 2)=0$.
Thus the displayed implication does not supply full symmetry or the
prescribed normalization. This observation does not declare their theorem
false or rule out a different proof. Our result supplies a direct complete
moment map under the stronger fixed-entry restriction.

Ke and Honorio's normalized cone [1] matches the input domain here at order
four. Their additional balance constraint and their larger PSD relaxation
are not imposed by our rule. The result consequently resolves normalized
cone membership without asserting hardness of their entire statistical
optimization program. Complete decomposability is another name for the
unrestricted power-sum cone; the literature audit also checked this formulation.

#heading(numbering: none)[References]

[1] C. Ke and J. Honorio. Exact Partitioning of High-order Models with a Novel
Convex Tensor Cone Relaxation. _Journal of Machine Learning Research_ 23(284),
1–28, 2022. #link("https://jmlr.org/papers/v23/22-0232.html")[Primary paper.]

[2] C. J. Hillar and L.-H. Lim. Most Tensor Problems Are NP-Hard.
_Journal of the ACM_ 60(6), Article 45, 2013.
#link("https://doi.org/10.1145/2512329")[doi:10.1145/2512329.]

[3] I. Pitowsky. Correlation polytopes: Their geometry and complexity.
_Mathematical Programming_ 50, 395–414, 1991.
#link("https://doi.org/10.1007/BF01594946")[doi:10.1007/BF01594946.]

[4] D. Krause, M. Scherer, J. Schwinn and R. Werner. Membership testing for
Bernoulli and tail-dependence matrices. Preprint, August 16, 2017.
#link("https://optimization-online.org/wp-content/uploads/2017/08/6168.pdf")[Primary preprint.]

[5] A. Caprara, F. Furini, C. Gentile, L. Liberti and A. Lodi. Hardness of
some optimization problems over correlation polyhedra. arXiv:2605.02896v1,
2026. #link("https://arxiv.org/html/2605.02896v1")[Primary preprint.]

#pagebreak()
#set heading(numbering: "A.")
#counter(heading).update(0)
= Verification and reproducibility

The implementation and finite checks accompany this manuscript in the campaign
directory. Python 3.14 and Z3 5.1.0 were used for testing; the candidate itself
uses only Python's standard library. From that directory, run:

```sh
python3 work/check.py --self-test
python3 work/check.py --candidate work/algorithm.py
python3 work/verify.py --candidate work/algorithm.py
python3 reviews/paired-sign/check.py
typst compile work/manuscript.typ work/manuscript.pdf
```

The candidate reads a JSON matrix from standard input and returns the complete
normalized tensor. Its `--extract` mode reads the source plus a target
certificate and returns a source certificate. `work/contract.md` defines the
rational strings, sorted tensor indices and mixture format. Neither mode calls
the testing oracles.

The prepared suite and separate verification program passed 41 instance
comparisons and 26 recovery calls. Source dimensions were at most three;
the verification source oracle uses exact interval and tetrahedron criteria.
Target oracles enumerate sign vertices and solve rational linear feasibility,
then check returned moments with exact fractions. Additional independent checks
covered a four-dimensional YES/NO pair, recovery from a 97-term split and
sign-flipped certificate, and 715 coordinates of a five-dimensional mask
example. These experiments test actual subprocess outputs. They are finite
corroboration, not substitutes for the general proof.

The independent review advanced after focused literature and contract revisions.
Novelty was assessed against the normalized statement and inspected primary
sources on September 16, 2026. The original Pitowsky proof was inaccessible;
its full-matrix hardness attribution is explicit in [4] and [5]. Unindexed
work and possible repairs of older tensor arguments remain outside the search
coverage. `work/literature.md` and `reviews/paired-sign/` retain that assessment
and its limitations. Human expert assessment of correctness, significance and
priority remains outstanding.
