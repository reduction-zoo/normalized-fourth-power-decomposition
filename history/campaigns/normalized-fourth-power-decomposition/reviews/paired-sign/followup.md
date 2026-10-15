# Focused follow-up review

Decision: **advance**. Date: 2026-09-16.

I reviewed the amended work/contract.md, work/proof.md, and new work/literature.md against the three findings in [review.md](review.md). I also reread algorithm.py and the construction, normalization, certificate, and recovery proof. The mathematical maps and executable implementation are unchanged. I reuse the original independent checks and do not rerun unaffected suites.

## Findings resolved

1. The literature note now explicitly records Hillar–Lim's Grammian/fourth-power hardness claim and its exact Section 11 and Theorem 11.2 locations. It distinguishes the campaign's fully symmetric normalized input restriction from that unrestricted claim and describes the displayed coordinate mismatch without declaring the published theorem false. The proof points to this comparison. This resolves the missing closest baseline.
2. The contract now states that recovery assumes a valid certificate of the actual target and that behavior outside this premise is unspecified. This matches the unchanged implementation and fixed question. The previously exhibited invalid-sign input no longer contradicts a promised behavior.
3. The proof and literature note identify full Boolean second-moment membership, cite Krause–Scherer–Schwinn–Werner and Caprara et al. at the relevant locations, and retain the original Pitowsky proof-access gap. The reference-coordinate affine equivalence is given on vertices and extends to convex combinations. No inference from arbitrary partial-correlation hardness is used.

## Separate judgments

Correctness: supported. The general YES/NO proof, polynomial rational certificate bound, deterministic forward map, and recovery from every valid target certificate remain valid for the fixed endpoints. The source NP-hardness premise is the explicitly cited full-matrix theorem reported by later primary research papers. This review has not independently reconstructed the original hardness reduction. The new documentation accurately distinguishes that dependency from the independently audited tensor lifting.

Novelty: sufficiently supported for advancement to expert review within the recorded search coverage. The claim is now the explicit normalized complete fourth-moment lifting and consequent restricted membership classification. It does not assert priority for unrestricted fourth-power hardness. The inspected older tensor constructions and cone duality results do not supply this normalized map. No matching earlier normalized classification was located; inaccessible originals, unindexed work, and potential repairs to older claims remain explicit limitations. This is a bounded literature judgment, not proof of priority.

Significance: moderate and supported by the fixed question. The reduction gives a complete deterministic tensor instance with the prescribed normalization, rational NP certificates, and universal witness recovery. That is a concrete contribution beyond generic unrestricted or PSD-cone hardness, while not establishing approximation hardness or hardness of the balance-constrained statistical program.

No review blocker remains. Proceed to the manuscript, compilation, and visual inspection required by the campaign. Preserve the literature caveats and distinguish the normalized result from unrestricted prior claims in the paper. This advance decision establishes eligibility for expert review, not publication acceptance or a substitute for human mathematical assessment.
