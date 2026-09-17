"""Independent exact vertex-enumeration oracles and process-level checks."""
import argparse
from fractions import Fraction as F
from itertools import combinations_with_replacement as tuples, product
import json
from math import comb, prod
from pathlib import Path
import re
import subprocess
import sys
import z3


def rational(value):
    assert isinstance(value, str) and re.fullmatch(r'-?[0-9]+(?:/[0-9]+)?', value)
    if '/' in value:
        assert int(value.split('/')[1]) > 0
    return F(value)


def target_data(target):
    assert set(target) == {'dimension', 'entries'}
    d = target['dimension']
    assert type(d) is int and d > 0
    values = list(map(rational, target['entries']))
    assert len(values) == comb(d + 3, 4)
    indices = list(tuples(range(d), 4))
    for index, value in zip(indices, values):
        if all(index.count(i) % 2 == 0 for i in index):
            assert value == 1
    return d, indices, values


def validate(d, indices, values, witness):
    assert set(witness) == {'terms'} and isinstance(witness['terms'], list)
    terms = []
    for term in witness['terms']:
        assert set(term) == {'weight', 'signs'}
        w, s = rational(term['weight']), term['signs']
        assert w >= 0 and len(s) == d
        assert all(type(v) is int and v in (-1, 1) for v in s)
        terms.append((w, s))
    assert sum(w for w, s in terms) == 1
    for index, value in zip(indices, values):
        assert sum(w * prod(s[i] for i in index) for w, s in terms) == value


def solve(d, indices, values):
    signs = [(1,) + s for s in product((-1, 1), repeat=d - 1)]
    weights = [z3.Real(f'p{i}') for i in range(len(signs))]
    solver = z3.Solver()
    solver.add(z3.Sum(weights) == 1, *[p >= 0 for p in weights])
    for index, value in zip(indices, values):
        solver.add(z3.Sum([p * prod(s[i] for i in index)
                          for p, s in zip(weights, signs)]) == z3.RealVal(str(value)))
    result = solver.check()
    if result == z3.unsat:
        return None
    assert result == z3.sat, result
    model = solver.model()
    terms = [{'weight': str(model.eval(p)), 'signs': list(s)}
             for p, s in zip(weights, signs) if F(str(model.eval(p))) != 0]
    witness = {'terms': terms}
    validate(d, indices, values, witness)
    return witness


def source_data(source):
    matrix = source['matrix']
    n = len(matrix)
    assert n > 0 and all(len(row) == n for row in matrix)
    matrix = [list(map(rational, row)) for row in matrix]
    assert all(matrix[i][i] == 1 for i in range(n))
    assert all(matrix[i][j] == matrix[j][i] for i in range(n) for j in range(n))
    indices = list(tuples(range(n), 2))
    return n, indices, [matrix[i][j] for i, j in indices]


def invoke(candidate, value, extract=False):
    result = subprocess.run([sys.executable, str(candidate)] + (['--extract'] if extract else []),
                            input=json.dumps(value), text=True, capture_output=True, check=True)
    return json.loads(result.stdout)


def run_case(candidate, case):
    source = source_data(case['source'])
    yes = solve(*source) is not None
    assert yes == case['yes'], case['name']
    target = invoke(candidate, case['source'])
    data = target_data(target)
    witness = solve(*data)
    assert (witness is not None) == yes, (case, target)
    calls = 0
    if witness is not None:
        flipped = {'terms': [{'weight': t['weight'], 'signs': [-v for v in t['signs']]}
                             for t in witness['terms']]}
        for solution in (witness, flipped):
            validate(*data, solution)
            recovered = invoke(candidate, {'source': case['source'], 'target_solution': solution}, True)
            validate(*source, recovered)
            calls += 1
    print(json.dumps({'case': case['name'], 'yes': yes, 'target_dimension': data[0],
                      'recovery_calls': calls}), flush=True)


def rejected(function, *args):
    try:
        function(*args)
    except AssertionError:
        return
    raise AssertionError('Invalid fixture was accepted')


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--self-test', action='store_true')
    parser.add_argument('--candidate', type=Path)
    args = parser.parse_args()
    cases = json.loads(Path(__file__).with_name('cases.json').read_text())
    if args.self_test:
        for case in cases:
            assert (solve(*source_data(case['source'])) is not None) == case['yes']
        yes = {'dimension': 2, 'entries': ['1'] * 5}
        no = {'dimension': 2, 'entries': ['1', '2', '1', '0', '1']}
        assert solve(*target_data(yes)) is not None
        assert solve(*target_data(no)) is None
        rejected(target_data, {'dimension': 2, 'entries': ['0'] * 5})
        rejected(validate, *target_data(yes), {'terms': [{'weight': '1', 'signs': [1, -1]}]})
        rejected(validate, *source_data(cases[2]['source']), {'terms': [{'weight': '1', 'signs': [1, 1]}]})
        print(json.dumps({'self_test': 'pass', 'source_cases': len(cases), 'target_cases': 2,
                          'invalid_fixtures_rejected': 3, 'solver': z3.get_version_string()}))
    else:
        assert args.candidate is not None
        for case in cases:
            run_case(args.candidate.resolve(), case)
