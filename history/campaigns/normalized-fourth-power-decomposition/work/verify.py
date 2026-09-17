"""Additional exact checks, independent of check.py and algorithm.py."""
import argparse
from fractions import Fraction
from itertools import product, combinations_with_replacement, combinations
import json
from math import prod
import subprocess
import sys
import z3


def call(path, value, extract=False, raw=False):
    command = [sys.executable, path] + (['--extract'] if extract else [])
    output = subprocess.run(command, input=value if raw else json.dumps(value),
                            text=True, capture_output=True, check=True)
    return json.loads(output.stdout)


def target_witness(target):
    d = target['dimension']
    assert type(d) is int and d > 0
    coords = list(combinations_with_replacement(range(d), 4))
    values = [Fraction(x) for x in target['entries']]
    assert len(coords) == len(values)
    for coord, value in zip(coords, values):
        if all(coord.count(i) % 2 == 0 for i in coord):
            assert value == 1
    vertices = list(product((-1, 1), repeat=d))
    w = [z3.Real(f'q{i}') for i in range(len(vertices))]
    solver = z3.Solver()
    solver.add(*[x >= 0 for x in w], sum(w) == 1)
    for coord, value in zip(coords, values):
        solver.add(sum(x * prod(s[i] for i in coord) for x, s in zip(w, vertices))
                   == z3.RealVal(str(value)))
    status = solver.check()
    if status == z3.unsat:
        return None
    assert status == z3.sat, status
    model = solver.model()
    terms = [(Fraction(str(model.eval(x))), s) for x, s in zip(w, vertices)]
    terms = [(weight, s) for weight, s in terms if weight]
    assert sum(weight for weight, s in terms) == 1
    for coord, value in zip(coords, values):
        assert sum(weight * prod(s[i] for i in coord) for weight, s in terms) == value
    return terms


def source_answer(matrix):
    n = len(matrix)
    if n == 1:
        return True
    if n == 2:
        return abs(matrix[0][1]) <= 1
    assert n == 3
    # The four tetrahedron barycentric coordinates are these expressions / 4.
    a, b, c = matrix[0][1], matrix[0][2], matrix[1][2]
    return all(1 + x*a + y*b + x*y*c >= 0 for x, y in product((-1, 1), repeat=2))


def verify_recovery(path, source, terms):
    n = len(source['matrix'])
    # Splitting each atom between z and -z preserves every fourth moment.
    witness = {'terms': [{'weight': str(w/2), 'signs': [flip*x for x in s]}
                         for w, s in terms for flip in (-1, 1)]}
    recovered = call(path, {'source': source, 'target_solution': witness}, True)
    weights = [Fraction(t['weight']) for t in recovered['terms']]
    assert all(w >= 0 for w in weights) and sum(weights) == 1
    assert all(len(t['signs']) == n and all(type(x) is int and x in (-1, 1)
               for x in t['signs']) for t in recovered['terms'])
    for i in range(n):
        for j in range(n):
            assert sum(w*t['signs'][i]*t['signs'][j]
                       for w, t in zip(weights, recovered['terms'])) == Fraction(source['matrix'][i][j])


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--candidate', required=True)
    path = parser.parse_args().candidate
    cases = []
    for n in (1, 2, 3):
        pairs = list(combinations(range(n), 2))
        for values in product((-1, 0, 1), repeat=len(pairs)):
            matrix = [[Fraction(int(i == j)) for j in range(n)] for i in range(n)]
            for (i, j), value in zip(pairs, values):
                matrix[i][j] = matrix[j][i] = Fraction(value)
            cases.append(matrix)
    for value in (Fraction(-1, 3), Fraction(-1, 2)):
        cases.append([[Fraction(1) if i == j else value for j in range(3)] for i in range(3)])
    for number, matrix in enumerate(cases):
        source = {'matrix': [[str(v) for v in row] for row in matrix]}
        target = call(path, source)
        terms = target_witness(target)
        yes = source_answer(matrix)
        assert (terms is not None) == yes, source
        if yes:
            verify_recovery(path, source, terms)
        print(json.dumps({'case': number, 'n': len(matrix), 'yes': yes,
                          'recovery_calls': int(yes)}), flush=True)
    malformed = ['['*1500+']'*1500, '{', '{}', 'null', '[]', '{"matrix":[]}',
                 '{"matrix":[["0"]]}', '{"matrix":[["1/0"]]}',
                 '{"matrix":[[1]]}', '{"matrix":[["1","0"],["1","1"]]}']
    for raw in malformed:
        target = call(path, raw, raw=True)
        assert target_witness(target) is None, raw
    print(json.dumps({'malformed_no_cases': len(malformed)}))
