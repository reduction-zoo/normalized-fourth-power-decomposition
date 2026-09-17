# Executable contract

Source: JSON object with sole key `matrix`, a nonempty square symmetric array
of rational strings and diagonal ones. A rational string consists of an optional
minus sign, decimal numerator, and optional `/` followed by a positive decimal
denominator. Leading zeros and unreduced fractions are allowed. No floats,
booleans or nonfinite values. Malformed source strings map to a fixed legal NO
target, including invalid JSON. Source language is membership in the convex
hull of sign outer products.

Target: `{"dimension": d, "entries": [...]}`, d a positive integer. Entries
are rational strings, in Python combinations_with_replacement(range(d),4)
order. Symmetry is implicit. Every tuple with only even multiplicities has
entry one. Membership means a sum of real fourth powers, with unrestricted
number of summands as in question.md.

Both witnesses use `{"terms": [{"weight": "p/q", "signs": [...]}]}`.
Weights are nonnegative rational strings summing to one; signs are integer
-1 or +1, of source or target dimension. The weighted second/fourth moments
must equal every input entry. Zero weights, repeated terms and global sign
flips are allowed. There is no requirement of minimal support or optimality.
There exist polynomial-size certificates; arbitrary valid longer certificates
are accepted with runtime polynomial in their actual encoded length.

`python3 algorithm.py` reads one source JSON value from stdin, writes the target
JSON and exits. `python3 algorithm.py --extract` reads `{"source": source,
"target_solution": witness}` and returns a source witness. Recovery's theorem
assumes a valid witness of the actual constructed target. Behavior outside that
premise is unspecified; the extractor does not validate target certificates.
No hidden process state or solver calls.

For the exact target oracle, normalization implies each real summand u has
equal absolute coordinates: sum_a(u_ai^2-u_aj^2)^2=0. Its fourth power is a
nonnegative multiple of a sign fourth power; the diagonal makes the weights
sum to one. Conversely any sign mixture is a real fourth-power decomposition.
Thus enumerating sign vertices and solving rational linear feasibility is
exact, not an SOS relaxation. Global sign reversal permits fixing the first
coordinate to one for both oracles. Returned weights are checked with Fraction.
