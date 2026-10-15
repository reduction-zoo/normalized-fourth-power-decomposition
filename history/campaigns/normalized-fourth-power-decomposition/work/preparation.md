# Testing foundation

Prepared on 2026-09-16 under research-prepare. The exact source and target
oracles enumerate sign vertices and use Z3 5.1.0 rational linear feasibility.
The target oracle's equivalence to unrestricted real decomposition follows
from the normalization identity in contract.md. This is not an approximate
nonlinear optimization or SOS oracle. SAT models are checked by direct Fraction
arithmetic; only UNSAT means NO, and unknown raises an error.

`python3 work/check.py --self-test` (from the campaign root) passed:
[raw output](evidence/preparation/self-test.json). Eight source cases include
both answers, rational boundaries and an entry outside [-1,1]. Two hand-built
target cases include all-one sign moments and an impossible moment of two.
Three malformed/incorrect target or witness fixtures were rejected. The
triangle boundary uses a uniform mixture of the three sign cuts with one
coordinate separated; the NO case violates R12+R13+R23>=-1.

The subprocess harness compares both oracle decisions and validates recovered
moments, including a global flip of each target witness. Process errors and
assertion failures remain visible. Candidate testing has not occurred during
preparation. Oracles are exponential and only for declared small instances.
No solver timeout, background job, numerical tolerance or candidate import.
