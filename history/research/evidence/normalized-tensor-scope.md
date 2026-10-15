# Bounded screening exercise

Declared before execution on 2026-09-16. Test one paired-sign construction
from sign-correlation membership to normalized symmetric fourth-power
decomposition. This is Gate 6 screening, not an allocated campaign round.

For each n=1,2,3, enumerate every symmetric matrix R with diagonal one and
off-diagonal entries in {-1,0,1}: 31 source instances. Build a tensor in 2n
coordinates. Even-multiplicity entries are one. Entries with odd support
exactly {2i,2i+1,2j,2j+1}, i != j, are R[i,j]. All others are zero.

Use Z3 rational linear feasibility over explicitly enumerated sign vertices
as independent source and target membership oracles. Check target witnesses
by direct rational summation, then decode each sign vector z to
s[i]=z[2i]*z[2i+1] and validate its mixture against R. Also enumerate every
source sign vector for n<=3 and average over all independent paired masks
and one global sign flip, checking all sorted fourth-index tuples exactly.

Completion: report every YES/NO decision comparison and count of checked
coordinates and extracted witnesses. Any mismatch rejects this construction.
Finite agreement supports a proof attempt, not hardness or novelty. No
wall-clock cutoff, randomized solver heuristic or floating-point feasibility
decision is part of this experiment.

Implementation repair: the first invocation failed at witness filtering with
`Z3Exception: Symbolic expressions cannot be cast to concrete Boolean values`.
It produced no mathematical result. Filtering now occurs after conversion to
Python Fraction. This is a checker repair, not a new scope or round.
