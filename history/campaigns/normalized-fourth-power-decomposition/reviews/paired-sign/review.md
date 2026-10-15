# Independent review: paired-sign lifting

Decision: **revise**. Date: 2026-09-16.

The construction, normalized-cone characterization, and universal recovery argument are correct. The independent checks passed. The required revisions concern the closest literature baseline and an executable-contract overstatement. The exact full-correlation hardness dependency also needs a precise attribution and an explicit coverage limitation. No mathematical redesign or new research round is requested.

## Correctness

I read the fixed question, contract, complete algorithm, proof, preparation, and verification reports. I did not import candidate code, change the candidate, or spawn another agent. The candidate does not rely on a shared experience entry.

The identity in proof.md, “Normalized cone equals a finite moment polytope,” is valid on the entire stated normalized domain. It is a finite sum of nonnegative real squares, so each term vanishes. Fixing one coordinate shows that every nonzero summand has one common positive absolute magnitude; zero summands can be removed. Diagonal normalization gives total mixture weight one. Conversely, real fourth roots realize each nonnegative weight. This proves equivalence to the sign-mixture certificate convention without a rank promise. It also covers dimension one.

The forward map fills every symmetric coordinate. For a fourth-degree monomial, the odd support has size zero, two, or four. Independent mask signs cancel every block with odd mask degree. The two-element surviving support must be one complete pair and has zero expectation after antipodal source symmetrization. The four-element surviving support must consist of two complete pairs and gives exactly the requested source second moment. The symmetrization preserves all source second moments, including nonzero off-diagonal ones. The exponential distribution is an existence proof, not the executed reduction.

Soundness uses only the designated four-coordinate moments of an arbitrary valid certificate. Pairwise coordinate products are signs, and their second moments reproduce the source. The extractor retains all original rational weight strings and computes exactly these sign products. Repeated terms, zero weights, global sign changes, arbitrary nonminimal support, and n=1 introduce no exception. There is no witness construction or optimization oracle hidden in either executable map.

The certificate bound is sound: a minimum-support feasible representation has linearly independent columns; selecting independent rows yields an invertible square integer matrix with entries ±1. Hadamard plus denominator clearing bounds Cramer numerators and denominators polynomially in the full tensor encoding. The stated bound is conservative but sufficient for NP membership. This is existence of a short certificate, not a polynomial certificate-finding algorithm. Parsing, rational normalization, O(n^4) entry enumeration and copying meet the polynomial bit bound when L denotes the encoded rational length. Recovery is polynomial in the actual supplied witness length, even for long certificates.

The fixed malformed-input tensor is normalized and NO. Its 0001 coordinate exceeds the absolute bound for sign mixtures. The parser checks the stipulated square, symmetry, diagonal, and rational conditions. The installed Python 3.14 execution also rejected a 100,000-level malformed nested array without crashing. Finite tests do not prove parser behavior on every platform, and this review makes no compatibility claim.

### Targeted independent evidence

Run from repository root:

```
python3 campaigns/normalized-fourth-power-decomposition/reviews/paired-sign/check.py
```

The own-check program and saved output are [check.py](check.py) and [check.jsonl](check.jsonl). It executes candidate construction and recovery as fresh processes, independently solves the complete returned target with an exact rational sign-vertex LP, and directly checks target and recovered source moments with Fraction arithmetic.

- A dimension-four source mixture with weights 1/7, 2/7, 4/7 produced a satisfiable 330-entry target. The independently solved certificate was split and antipodally flipped, then augmented with a zero-weight term: all 97 recovered terms passed source moment checks.
- A dimension-four source containing an impossible all-negative triangle produced an unsatisfiable 330-entry target. The source NO decision follows independently from the triangle product identity.
- A biased dimension-five source atom, antipodally symmetrized and averaged over all masks, matched all 715 returned fourth coordinates exactly across 64 support points.
- Four malformed inputs, including deep nesting and zero denominators, returned the fixed NO tensor.

These supplement the existing 41 source comparisons; I did not rerun the original suites. The universal argument, rather than these finite cases, establishes arbitrary-dimension correctness.

## Required revisions

1. **Closest claimed baseline omitted.** work/proof.md:119–130 discusses the contribution and sends literature coverage to question.md, but neither explains Hillar–Lim's explicit Grammian hardness statement. Add a current-work literature note and cite it from the proof. Preserve the normalized fixed question. Explain the exact extra restriction and complete-moment construction, rather than positioning all fourth-power membership hardness as previously unclaimed. See the primary-source audit below. This is necessary for an honest novelty and significance assessment.

2. **Recovery contract promises more than implementation.** work/contract.md says: “Invalid recovery input is an error, not a NO instance.” At work/algorithm.py:55–58, extraction assumes a valid certificate and performs products without validating that premise. For source `{"matrix":[["1"]]}` and target solution `{"terms":[{"weight":"1","signs":[2,2]}]}`, the program exits zero and returns sign `[4]`. This is not a failure of the valid-certificate theorem. The smallest appropriate repair is to clarify that behavior outside the valid-certificate premise is unspecified; the fixed question does not demand full invalid-certificate validation. If invalid-input rejection is intentionally retained as an executable promise, implement and check it instead.

3. **State the exact source-hardness dependency.** work/proof.md:119–122 calls hardness “standard.” Explicitly identify full Boolean second-moment membership (all diagonal and off-diagonal entries supplied), and distinguish it from arbitrary partial correlation feasibility. Cite the precise later primary sources and record that the original Pitowsky reduction was not inspected. Do not pretend that an arbitrary graph projection alone supplies a Karp reduction to complete data. This review found explicit full-matrix claims in later primary literature, but did not independently reconstruct Pitowsky's reduction.

## Primary literature audit

Searches and access checks were performed on 2026-09-16. The following are evidence, not an assertion that all literature has been exhausted.

**Hillar and Lim, Most Tensor Problems Are NP-Hard (2013).** Section 11, equation (35), Theorem 11.2, journal p. 45:31, explicitly includes Grammian tensors and sums of fourth powers. This is the same unrestricted cone representation. The displayed matrix construction has S1212=A12 but S1122=0: for the completely positive all-one 2-by-2 matrix it is not fully symmetric and cannot be a fourth-power sum. Thus the displayed equivalence omits necessary moment equations. Independently of that issue, its entries do not satisfy the campaign normalization. This audit does not declare the theorem false or establish absence of a repair; it establishes that the displayed argument does not subsume the present restricted lifting. [Primary paper](https://www.cs.cornell.edu/courses/cs6241/2020sp/readings/hillar-2013-nphard.pdf).

**Ke and Honorio (2022).** Section 2, p. 3 defines the cone, and Section 3.1, p. 5 supplies the even-multiplicity normalization. Section 4, p. 8 and Appendix C, p. 22 discuss unresolved membership hardness and the limitations of the older construction. Section 7, p. 15 repeats the membership question. The campaign's cone and normalization match these definitions at order four. The paper's full optimization program additionally has a balance constraint, which the present reduction does not impose. The contribution must therefore be stated as a normalized membership result, not a hardness theorem for every aspect of their statistical program. [Primary paper](https://jmlr.org/papers/volume23/22-0232/22-0232.pdf).

**Pitowsky (1991).** The publisher abstract states correlation-polytope membership NP-completeness, but does not specify full versus partial coordinates. Full text was inaccessible; a historical author-hosted PDF link failed. The original proof remains an explicit coverage gap. [Publisher](https://link.springer.com/article/10.1007/BF01594946).

**Krause, Scherer, Schwinn and Werner, Membership testing (2017).** Proposition 1.1 and Remark 1.2, p. 4 define the full matrix polytope conv{pp^T:p in {0,1}^d}, and Section 2.2, p. 12 explicitly attributes its NP-completeness to Pitowsky Sections 3.1 and 3.3. This is specific support for the endpoint required here, rather than generic marginal feasibility. It is a later primary research paper reporting the earlier theorem, not a substitute for inspecting the original reduction. [Primary preprint](https://optimization-online.org/wp-content/uploads/2017/08/6168.pdf).

**Caprara et al. (2026).** Section 4.1 explicitly treats full COR(n) membership as NP-hard. Section 4.5.2, equations (24)–(25), gives the reference-coordinate affine equivalence to complete sign matrices. I checked the equivalence directly on vertices: choose reference sign one and s_i=2x_i-1; conversely x_i=(1+s_0s_i)/2. Convex extension gives the stated maps, so this step is a Karp map and recovers Boolean witnesses. It does not fill unspecified partial moments. Unrelated rank claims in that paper are not used here. [Primary preprint](https://arxiv.org/html/2605.02896v1).

**Equivalent tensor formulations.** Qi et al., Regularly Decomposable Tensors and Classical Spin States (2017), Section 2, equation (2.1), uses complete decomposability for the same unrestricted power-sum cone; Section 4.3, Proposition 4.2 discusses duality. Its regular normalization is a different sphere-related condition and supplies no paired-sign membership lifting. [Primary paper](https://ira.lib.polyu.edu.hk/bitstream/10397/67387/1/BQZ17_cms.pdf). Qi, Cui and Xu, Structured Symmetric Tensors, inspected Sections 2–7, discusses CD cones, duality, interiors, and products, with no located complexity theorem or normalized paired-sign lifting. [Primary preprint](https://arxiv.org/html/2511.06966v1).

Queries included full/partial correlation membership, fourth-moment correlation polytopes, completely decomposable tensor complexity, sum-of-fourth-powers NP-hardness, Grammian hardness, and Hillar–Lim error/normalization combinations. No prior explicit complete paired-sign lift or this normalized NP-completeness classification was located. General moment, cut, and marginal polytopes are related formulations, but projecting away high moments does not itself deterministically fill a complete tensor. Dual-cone hardness and optimization-oracle equivalences likewise do not automatically establish this Karp theorem. Unindexed work, inaccessible sources, and potential repairs to earlier published claims remain outside coverage.

## Novelty and significance judgments

Novelty: plausible for the exact normalized complete-moment lifting, with the explicit limits above. The omitted Grammian statement prevents advancing the current presentation. It should be incorporated, not treated as evidence of automatic failure or automatic novelty.

Significance: moderate and consistent with the fixed question. The complete fill of fourth moments, universal recovery and rational NP certificates provide a concrete strengthening beyond a generic unrestricted-cone or PSD hardness statement. The normalization makes the input a finite sign-moment polytope while still retaining full second-moment hardness. No claim about approximation, balanced-program complexity, or publication acceptance is supported.

After the three focused revisions, reuse all unaffected proof and executable evidence. A follow-up review should assess the amended literature position and recovery contract; it need not repeat the successful construction tests.
