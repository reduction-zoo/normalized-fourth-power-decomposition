# Verification of the paired-sign rule

The current `algorithm.py` has passed both process-level suites. No oracle
imports candidate code. Checks use exact rational arithmetic and Z3, not
floating-point fits. General correctness is argued separately in proof.md.

- `python3 work/check.py --candidate work/algorithm.py`: eight prepared
  instances, five YES and three NO, ten recovery calls using solver-returned
  and globally flipped target certificates.
  [Output](../history/campaigns/normalized-fourth-power-decomposition/rounds/001/prepared.jsonl).
- `python3 work/verify.py --candidate work/algorithm.py`: 33 additional
  decision comparisons, 16 YES and 17 NO, 16 recovery calls with split-weight
  globally flipped certificates, and nine malformed NO inputs.
  [Output](../history/campaigns/normalized-fourth-power-decomposition/rounds/001/verify.jsonl).
- A separate 1,500-level nested-array malformed input exited successfully
  and was rejected by the source parser: [check](../history/campaigns/normalized-fourth-power-decomposition/rounds/001/nested-json-check.json).

The additional source oracle uses the exact tetrahedron inequalities for n=3
and the interval [-1,1] for n=2; it does not reuse the prepared source LP.
Its target LP enumerates all signs, whereas the prepared LP fixes the first
sign to one. Both target oracles follow the normalized cone identity, which
requires independent mathematical review. These finite checks are not
independent authorship or proof certificates for arbitrary dimension.

The round also retains `prepared-repeat.jsonl` and
`verify-expanded-malformed.jsonl`: routine repeat checks during inspection of
parser recursion. A temporary additional caught exception was removed because
the diagnostic supplied no failure; the final candidate is the same one used
by the original passing suites. No new mathematical candidate or repair is
claimed for these repeats. The expanded run includes the nested malformed case.

Remaining: independent audit of the general rule, exact source hardness
dependency, novelty and significance; then a paper if review advances.
