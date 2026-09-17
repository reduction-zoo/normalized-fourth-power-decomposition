"""Exact finite screening; see normalized-tensor-scope.md."""
from fractions import Fraction
from itertools import combinations, combinations_with_replacement, product
from math import prod
import json
import z3


def mixture(dimension, indices, values):
    vertices = [(1,) + s for s in product((-1, 1), repeat=dimension - 1)]
    weights = [z3.Real(f"w{i}") for i in range(len(vertices))]
    solver = z3.Solver()
    solver.add(*[w >= 0 for w in weights], z3.Sum(weights) == 1)
    for index, value in zip(indices, values):
        solver.add(z3.Sum([w * prod(s[i] for i in index)
                          for w, s in zip(weights, vertices)]) == value)
    result = solver.check()
    if result == z3.unsat:
        return None
    assert result == z3.sat, result
    model = solver.model()
    witness = [(Fraction(str(model.eval(w))), s)
               for w, s in zip(weights, vertices)]
    witness = [(w, s) for w, s in witness if w != 0]
    assert sum(w for w, _ in witness) == 1
    assert all(w >= 0 for w, _ in witness)
    for index, value in zip(indices, values):
        assert sum(w * prod(s[i] for i in index) for w, s in witness) == value
    return witness


def tensor_value(index, matrix):
    odd = [i for i in set(index) if index.count(i) % 2]
    if not odd:
        return 1
    if len(odd) == 4:
        pairs = sorted(set(i // 2 for i in odd))
        if len(pairs) == 2:
            return matrix[pairs[0]][pairs[1]]
    return 0


def main():
    counts = dict(instances=0, yes=0, no=0, recovery_calls=0,
                  masked_vertex_cases=0, masked_coordinate_checks=0)
    for n in range(1, 4):
        pairs = list(combinations(range(n), 2))
        indices = list(combinations_with_replacement(range(2 * n), 4))
        for entries in product((-1, 0, 1), repeat=len(pairs)):
            matrix = [[int(i == j) for j in range(n)] for i in range(n)]
            for (i, j), value in zip(pairs, entries):
                matrix[i][j] = matrix[j][i] = value
            source = mixture(n, pairs, entries)
            values = [tensor_value(index, matrix) for index in indices]
            target = mixture(2 * n, indices, values)
            assert (source is None) == (target is None), matrix
            counts['instances'] += 1
            counts['no' if source is None else 'yes'] += 1
            if target is not None:
                recovered = [(w, tuple(z[2*i] * z[2*i+1] for i in range(n)))
                             for w, z in target]
                for i, j in pairs:
                    assert sum(w * s[i] * s[j] for w, s in recovered) == matrix[i][j]
                counts['recovery_calls'] += 1
        for s in product((-1, 1), repeat=n):
            matrix = [[s[i] * s[j] for j in range(n)] for i in range(n)]
            vertices = [tuple(value for i in range(n) for value in
                              (mask[i], mask[i] * flip * s[i]))
                        for mask in product((-1, 1), repeat=n) for flip in (-1, 1)]
            for index in indices:
                actual = Fraction(sum(prod(z[i] for i in index) for z in vertices),
                                  len(vertices))
                assert actual == tensor_value(index, matrix), (s, index)
                counts['masked_coordinate_checks'] += 1
            counts['masked_vertex_cases'] += 1
    print(json.dumps(dict(solver=z3.get_version_string(), **counts), indent=2))


if __name__ == '__main__':
    main()
