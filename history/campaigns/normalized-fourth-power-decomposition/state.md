# Normalized fourth-power decomposition

Status: ready_for_expert_review. Allocated rounds: 20. Started/completed: 1.
Unused allocation: 19. Discovery stopped early after a complete rule; do not
spend remaining rounds on repeated validation or restart this campaign.

## Result

A deterministic Karp reduction maps complete sign-correlation membership in
n dimensions to normalized symmetric fourth-power decomposition in 2n dimensions.
The rule includes recovery from every valid rational sign-mixture certificate.
The normalized target is NP-complete under the explicitly cited full-matrix
hardness premise. This does not classify the larger PSD cone or approximate
fitting. Mathematical significance is moderate; originality is supported only
within the documented literature coverage, and human assessment remains pending.

- [Fixed question](question.md); [algorithm](work/algorithm.py) and
  [general proof](work/proof.md).
- [English five-page paper](work/manuscript.pdf), [Typst source](work/manuscript.typ)
  and [vector construction figure](work/figures/paired-sign.svg).
- [Preparation](work/preparation.md) and [verification](work/verification.md):
  41 process-level decision comparisons and 26 recovery calls passed.
- [Independent review](reviews/paired-sign/review.md),
  [advance follow-up](reviews/paired-sign/followup.md), and
  [manuscript consistency addendum](reviews/paired-sign/manuscript-addendum.md).
  Independent checks add a four-dimensional YES/NO pair, a 97-term recovery,
  and a five-dimensional 715-coordinate mask identity.
- [Literature audit](work/literature.md): distinguishes earlier unrestricted
  Grammian hardness, full versus partial correlation data, and the extra
  normalized restriction. The original Pitowsky proof was inaccessible;
  later primary papers explicitly attribute hardness for the full matrix language.

The final PDF compiled with Typst 0.15.1. All five pages were visually inspected;
editorial corrections and affected-page reinspection are recorded in round 001.
No executable change remains unverified, and no mathematical change followed
independent advancement. Human correctness and priority assessment remains open.

## Round and experience accounting

| Round | Mechanism | Result |
|---|---|---|
| [001](rounds/001/round.md) | Paired-sign complete moment lifting | Complete rule, general proof, passing checks, independent advance and inspected manuscript |

Shared experience after the 2026-09-16 post-campaign synchronization: 1 file
created, 0 updated, 0 pending:
[normalization rigidity](../../research/experience/normalized-even-moments-force-sign-atoms.md).
The exact finding and its reviewed evidence were recorded in round 001 and
were pending until the campaign ended and broader screening resumed.
Screening evidence remains at `research/evidence/normalized-tensor-*`; it was
not counted again as campaign rounds.

## Next action

Return to new-topic screening under the standing multi-topic goal. The board
and experience were synchronized after campaign closeout. No production-library integration or publication has
been performed or authorized by this campaign. The copied question preserves
board-relative links; use its original card at
`research/open-problems/normalized-fourth-power-decomposition.md` for those links.
