# Round 001 — Paired-sign lifting and universal recovery

## Plan (declared before candidate implementation)

Hypothesis: the screened deterministic paired-sign tensor map is a complete
Karp rule from sign-correlation membership to normalized fourth-power
decomposition. Prove normalization rigidity and all moment cases, implement
both process modes, and derive explicit polynomial certificate and bit bounds.
Use the prepared eight cases, then a separately implemented verification suite
over all 31 ternary-correlation matrices of dimensions 1–3, plus two rational
boundary cases and malformed-input cases. Test multiple legal target mixtures,
including flipped and split-weight representations. No larger instance family
is authorized within this round's experimental scope.

This is one construction mechanism. Screening counts are not campaign counts.
The first discriminating check is the complete forward/solve/recover loop on
the prepared YES and NO cases. Stop this mechanism on a mathematical mismatch;
repair ordinary implementation errors here without charging another round.
Even if these checks pass, a general proof, novelty assessment and independent
review remain necessary.

Experience retrieval: the existing index search for moment, tensor and
normalization supplied no applicable entry. The screened mask-cancellation and
normalization identities motivate this attempt; they are not shared lessons or
independently reviewed results. Prospects: medium, uncalibrated, because the
remaining proof obligations are localized but novelty is provisional.

## Evidence and diagnosis

The single paired-sign candidate now has both executables and a general proof.
The eight prepared cases passed with ten recovery calls. The independent
verification program passed 33 cases (16 YES, 17 NO) and 16 split-weight recovery
calls. Nine malformed inputs and a separate deeply nested malformed input
mapped to a legal NO tensor. Raw outputs are linked in
[verification.md](../../work/verification.md). Two routine suite repeats during
parser inspection did not add a mathematical candidate or reveal a defect.

Observation: no counterexample within the declared finite domain. The proof's
converse rests on an exact sum-of-squares identity, not solver outcomes. The
complete moment formula addresses the previously missing completion step.
General correctness and novelty remain independently unreviewed.

Experience extraction: one qualifying finding is pending at
`research/experience/normalized-even-moments-force-sign-atoms.md` because the
campaign contract permits writes only here. Proposed statement: for a sum of
real fourth powers with every T_iiii=T_iijj=1, each nonzero atom has equal
coordinate magnitudes; hence membership equals finite sign-moment membership.
Premises and proof are in [proof.md](../../work/proof.md), first section.
It enables exact rational LP test oracles and sign-certificate recovery, but
does not apply to the larger PSD cone or unnormalized tensors. Confidence:
general argument supplied, independent review pending. No shared file was saved.

Next action: independent review of correctness, source hardness, novelty and
significance. Prospects remain medium, uncalibrated: executable and general
arguments exist, but literature coverage and expert assessment can reject them.
Round 001 is complete; one mechanism was investigated. No extra rounds are
charged for review or unchanged-candidate writing. Runtime/token totals are
unavailable as per-round measurements.

### Independent review and focused revisions

The [initial review](../../reviews/paired-sign/review.md) requested revise:
the construction and independent tests passed, but the literature positioning
omitted Hillar–Lim's explicit Grammian claim, the source-hardness attribution
needed full-versus-partial precision, and the contract promised invalid-witness
rejection absent from the extractor. The contract now states its valid-witness
premise without claiming rejection outside it. The proof and new
[literature note](../../work/literature.md) identify the exact normalized result,
older claim, and uninspected original Pitowsky proof. These are presentation and
contract repairs; the rule and acceptance target are unchanged. Focused re-review
is pending, reusing all unaffected executable evidence. No new round was started.

### Closeout

The [follow-up](../../reviews/paired-sign/followup.md) advanced the repaired
presentation. The [manuscript addendum](../../reviews/paired-sign/manuscript-addendum.md)
maintained advance and confirmed consistency of the paper and its figure with
the reviewed rule. Both reused the unchanged executable evidence.

An English five-page [Typst paper](../../work/manuscript.typ) and
[PDF](../../work/manuscript.pdf) now contain the complete rule and reproduction
appendix. The main researcher applied how-to-technical-writing directly,
compiled with Typst 0.15.1, and inspected all five rendered pages under
`work/evidence/manuscript/`. An initial unknown-variable error for adjacent
math letters was corrected before successful compilation. Visual inspection
then corrected unintended displayed inline formulas, a cases-row break,
a repeated figure-reference prefix and title hyphenation. These were editorial
repairs; no mathematical construction changed. The final title-only change
was recompiled and its affected first page inspected. No clipped formulas,
unreadable figure labels or missing reference targets remained.

The pending normalization-rigidity experience now has independent general-proof
support via the follow-up review. It is still not a saved shared entry: campaign
write scope remains the reason. Final counts are 0 created shared entries,
0 updated, 1 pending destination. No other unsaved qualifying finding was
identified in this one-round campaign. The campaign stops discovery early with
a complete agent-reviewed result, preserving the unused allocation. Its status
does not assert human verification or publication acceptance.
