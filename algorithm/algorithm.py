"""Deterministic paired-sign tensor construction and certificate recovery."""
from fractions import Fraction
from itertools import combinations_with_replacement
import json
import re
import sys


def matrix_input(value):
    if not isinstance(value, dict) or set(value) != {'matrix'}:
        raise ValueError('Expected matrix object')
    matrix = value['matrix']
    if not isinstance(matrix, list) or not matrix:
        raise ValueError('Expected nonempty matrix')
    n = len(matrix)
    rows = []
    for row in matrix:
        if not isinstance(row, list) or len(row) != n:
            raise ValueError('Expected square matrix')
        values = []
        for entry in row:
            if not isinstance(entry, str) or not re.fullmatch(r'-?[0-9]+(?:/[0-9]+)?', entry):
                raise ValueError('Expected rational string')
            if '/' in entry and int(entry.split('/')[1]) == 0:
                raise ValueError('Zero denominator')
            values.append(Fraction(entry))
        rows.append(values)
    if any(rows[i][i] != 1 for i in range(n)):
        raise ValueError('Expected unit diagonal')
    if any(rows[i][j] != rows[j][i] for i in range(n) for j in range(i)):
        raise ValueError('Expected symmetry')
    return rows


def forward(rows):
    entries = []
    for index in combinations_with_replacement(range(2 * len(rows)), 4):
        odd = [i for i in set(index) if index.count(i) % 2]
        pairs = sorted({i // 2 for i in odd})
        if not odd:
            value = 1
        elif len(odd) == 4 and len(pairs) == 2:
            value = rows[pairs[0]][pairs[1]]
        else:
            value = 0
        entries.append(str(value))
    return {'dimension': 2 * len(rows), 'entries': entries}


if __name__ == '__main__':
    sys.set_int_max_str_digits(0)
    if sys.argv[1:] == ['--extract']:
        payload = json.load(sys.stdin)
        n = len(matrix_input(payload['source']))
        result = {'terms': [{'weight': term['weight'],
                             'signs': [term['signs'][2*i] * term['signs'][2*i+1]
                                       for i in range(n)]}
                            for term in payload['target_solution']['terms']]}
    elif not sys.argv[1:]:
        try:
            rows = matrix_input(json.load(sys.stdin))
        except (ValueError, ZeroDivisionError):
            result = {'dimension': 2, 'entries': ['1', '2', '1', '0', '1']}
        else:
            result = forward(rows)
    else:
        raise ValueError('Use no arguments or --extract')
    print(json.dumps(result))
