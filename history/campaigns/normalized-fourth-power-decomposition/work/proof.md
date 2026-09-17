# A paired-sign reduction to normalized fourth-power decomposition

General proof advanced by the independent [follow-up review](../reviews/paired-sign/followup.md).
The bounded literature assessment is in literature.md; human expert assessment remains pending.
The fixed languages and certificate conventions are in contract.md and question.md.

## Normalized cone equals a finite moment polytope

Let T=sum_a u_a^{tensor 4} be fully symmetric and satisfy T_iiii=T_iijj=1.
For any i,j,

$$\sum_a(u_{ai}^2-u_{aj}^2)^2=T_{iiii}+T_{jjjj}-2T_{iijj}=0.$$

Each nonnegative summand vanishes. Every nonzero u_a therefore equals r_a z_a
for r_a>0 and z_a in {-1,1}^d. Set lambda_a=r_a^4. The diagonal condition
implies sum_a lambda_a=1. Consequently T is a convex combination of z_a^{tensor 4}.
Conversely any such combination is a sum of real fourth powers, by taking
u_a=lambda_a^{1/4} z_a. This is a statement about the entire normalized domain,
not only tensors produced by the reduction. A zero vector contributes nothing.

For rational T this finite rational polytope has rational certificates of
polynomial size. Let D=binomial(d+3,4)+1 count the moment equations and the
weight-sum equation. A feasible nonnegative solution has a basic feasible
solution on at most D sign vertices. Select independent rows for those columns.
The resulting square coefficient matrix has entries in {-1,1}; its determinant
has absolute value at most D^(D/2). Clear all right-hand-side denominators with
their product Q, whose bit length is O(DL) when each input rational has at most
L bits. Cramer's rule bounds the numerator and denominator of each weight by
O(DL+D log D) bits. The complete certificate thus has
O(D^2(L+log D)+Dd) bits. This is a conservative bound; no algorithm for finding
that certificate in polynomial time is claimed. It proves the stated witness
convention is complete and the normalized decision language belongs to NP.

## Deterministic instance construction

Let R be a well-formed source instance in dimension n. Use target coordinates
(a_0,b_0,...,a_{n-1},b_{n-1}), dimension 2n. For each index multiset I of size
four, let O(I) be the coordinate indices appearing with odd multiplicity.
Define

$$T_I=\begin{cases}
1,&O(I)=\varnothing,\\
R_{ij},&O(I)=\{a_i,b_i,a_j,b_j\},\ i\ne j,\\
0,&\text{otherwise}.
\end{cases}$$

This specifies every entry, ensures full symmetry and the required normalization
on both YES and NO source inputs, and uses no witness, oracle or random choice.
The implementation stores only sorted tuples in lexicographic order.

## Completeness

If R belongs to C_n, choose any finite sign distribution S with E[S_i S_j]=R_ij.
Replace it by the equal mixture of S and -S, so E[S_i]=0 while its pair moments
are unchanged. Independently choose uniform signs A_0,...,A_{n-1}, and put
B_i=A_i S_i. These random variables specify an existence proof for a finite
convex mixture; they are not steps in the instance algorithm.

For a degree-four coordinate product, cancel even powers. If its odd support
is empty, its value is one. Otherwise independence and zero means of the A_i
kill the expectation unless each surviving block contains both A_i and B_i.
One surviving block has expectation E[S_i]=0. Two surviving blocks have
expectation E[S_i S_j]=R_ij. No other number of blocks is possible at degree four.
Thus the fourth moments of (A_0,B_0,...,A_{n-1},B_{n-1}) equal T exactly.
The normalized-cone identity establishes T in V_(2n,4).
The conceptual distribution may have exponential support; Caratheodory and the
preceding rational bound give a short certificate. The Karp map never enumerates
this distribution.

## Soundness and recovery from every valid certificate

Suppose T is in the target language. By the normalized-cone identity it has a
sign-power convex decomposition. Given any valid rational target certificate
{(lambda_a,z_a)}, define s_ai=z_a,2i * z_a,2i+1 and retain its weight lambda_a.
Then s_ai is a sign and, for distinct i,j,

$$\sum_a\lambda_a s_{ai}s_{aj}
=\sum_a\lambda_a z_{a,2i}z_{a,2i+1}z_{a,2j}z_{a,2j+1}
=T_{2i,2i+1,2j,2j+1}=R_{ij}.$$

Diagonal moments are one, since the weights sum to one and s_ai^2=1.
The recovered mixture is therefore a valid source certificate. This argument
allows duplicate signs, zero weights, arbitrary support and global sign flips.
It imposes no optimality or canonical-form premise. The executable extractor
performs exactly these products and preserves the weight strings. It does not
compute a source solution using a solver. For n=1 the diagonal argument alone
applies, so there is no missing off-diagonal case.

Combining both directions gives R in C_n iff f(R) is in V_(2n,4).
This is one instance mapped to one instance, not an oracle reduction.

## Totality and complexity

Invalid source syntax, nonsquare or asymmetric matrices, and non-unit diagonal
are rejected from the source language. The forward map sends these to the
dimension-two tensor with sorted entries (1,2,1,0,1). It is normalized, but its
0001 entry is two, whereas every sign-power mixture has that entry in [-1,1].
It is consequently a fixed NO target. This extends the map to malformed strings
without a promise. Recovery has no valid target certificate on this branch.

For a valid source with n^2 entries of at most L bits each, exact parsing and
normalization use polynomial bit time. Enumerating binomial(2n+3,4) tuples costs
O(n^4) constant-size tuple operations, plus O(log n) bit index handling. Output
size is O(n^4(L+log n)). A conservative schoolbook arithmetic bound is
O(n^2(L+1)^3+n^4(L+log(n+1)+1)^2) bit operations; fractions are only parsed,
normalized, compared and copied, never compounded across output coordinates.
The maps require no numerical precision parameter. Python's decimal integer
digit limit is disabled so it does not impose an undocumented finite bit bound.

If a target witness has k explicitly listed terms and total encoded length W,
recovery uses O(kn) sign products, copies the weights, and parses the source.
Its running time is polynomial in the source and witness bit lengths, and its
output has O(W+kn) bits. For a polynomial-size target certificate this gives
a polynomial-size source certificate. No minimum-support source format is
required. Source membership also has polynomial-size rational certificates by
the same finite-polytope argument with second moments.

## Hardness, significance and limits

The source is affinely equivalent to full Boolean correlation-polytope membership:
all diagonal and off-diagonal second moments are supplied. Use one reference
sign coordinate as detailed in the fixed question. Krause et al. (2017),
Proposition 1.1 and Section 2.2, explicitly attribute NP-completeness for this
full matrix language to Pitowsky (1991), Sections 3.1 and 3.3. Caprara et al.
(2026), Section 4.5.2, supplies the explicit full-matrix affine equivalence.
We rely on this published full-matrix hardness attribution; the original
Pitowsky reduction was not inspected. Arbitrary partial-correlation feasibility
does not suffice for this step. The precise source claims and access limitation
are recorded in [the literature audit](literature.md). This hardness implies NP-hardness of the normalized target
through this deterministic lifting; the certificate argument gives NP-completeness.
The source affine equivalence is known and is not claimed as a contribution.
Hillar and Lim (2013), Theorem 11.2, explicitly states hardness for the
unrestricted Grammian (fourth-power) cone. The present result must be compared
with that claim, not presented as the first unrestricted hardness statement.
Their displayed matrix construction neither fixes the required entries to one
nor supplies all the full-symmetry moment constraints; the precise comparison
is in the literature audit. The proposed contribution is the explicit complete
fourth-moment lifting and its consequence for the normalized power-sum cone
posed by Ke and Honorio.

This theorem does not give hardness of the larger PSD tensor cone, numerical
approximation, or the full statistical recovery program with its additional
constraints. Primary references and coverage limits remain in question.md;
priority and significance require independent assessment. Finite checks do not
prove any of the preceding universal statements.
