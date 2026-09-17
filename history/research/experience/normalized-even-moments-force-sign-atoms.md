# Normalized even moments force sign atoms

Tags: tensor, fourth-power-decomposition, moments, normalization, exact-oracle.

## Claim and applicability

Suppose a fully symmetric order-four tensor T is a finite sum of real fourth
powers and T_iiii=T_iijj=1 for every i,j. Every nonzero vector in every such
decomposition has equal absolute coordinate magnitudes. Consequently, the
normalized cone slice is exactly conv{z^{tensor 4}:z in {-1,1}^d}.
This does not hold merely from PSD membership, or without the stipulated
normalization. It gives no rank-minimal decomposition or efficient membership
algorithm in variable dimension.

## Evidence and status

General lemma: sum_a(u_ai^2-u_aj^2)^2=0 forces each square to vanish.
Diagonal entries make the resulting sign-atom weights sum to one. The converse
uses real fourth roots of nonnegative weights. Rational inputs have short
rational sign-mixture certificates by a basic feasible solution argument.
See the [proof](../../campaigns/normalized-fourth-power-decomposition/work/proof.md)
and originating [round 001](../../campaigns/normalized-fourth-power-decomposition/rounds/001/round.md).
The [independent follow-up](../../campaigns/normalized-fourth-power-decomposition/reviews/paired-sign/followup.md)
advanced the general argument. Human assessment remains outstanding.
Extracted on 2026-09-16 after campaign closeout; this was pending during the
campaign because its write scope excluded the shared collection.

## Consequence for search

For this exact normalized domain, use sign-vertex rational linear feasibility
as an exact small-instance oracle instead of nonlinear real factor search.
Prove recovery for every valid sign-mixture certificate. Do not transfer this
oracle to the larger PSD cone or assume that specifying pair moments fills
all fourth moments; a separate complete construction is needed for the latter.

## Use history

The originating campaign used the identity before this entry existed. It
enabled the exact target oracle and universal recovery proof, with evidence
linked above. No subsequent campaign use or comparative improvement has yet
been measured.
