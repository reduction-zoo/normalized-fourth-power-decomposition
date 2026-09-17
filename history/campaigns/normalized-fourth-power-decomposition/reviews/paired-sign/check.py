"""Independent process-level checks; never import candidate code."""
from fractions import Fraction as F
from itertools import combinations_with_replacement, product
from math import prod
from pathlib import Path
import json
import subprocess
import sys
import z3

candidate = Path(__file__).resolve().parents[2] / 'work' / 'algorithm.py'
def run(value, extract=False):
    p = subprocess.run([sys.executable, str(candidate)] + (['--extract'] if extract else []),
                       input=json.dumps(value), text=True, capture_output=True, check=True)
    return json.loads(p.stdout)

def solve(target):
    d = target['dimension']
    vertices = list(product((-1, 1), repeat=d))
    weights = [z3.Real(f'w{i}') for i in range(len(vertices))]
    solver = z3.Solver()
    solver.add(*[w >= 0 for w in weights], z3.Sum(weights) == 1)
    indices = list(combinations_with_replacement(range(d), 4))
    for idx, value in zip(indices, target['entries'], strict=True):
        solver.add(z3.Sum([w * prod(v[i] for i in idx) for w,v in zip(weights,vertices)]) == z3.RealVal(value))
    result = solver.check()
    assert result in (z3.sat, z3.unsat)
    if result == z3.unsat:
        return None
    terms = []
    for w,v in zip(weights,vertices):
        weight = F(str(solver.model().eval(w)))
        if weight:
            terms.extend([{'weight': str(weight/3), 'signs': list(v)},
                          {'weight': str(2*weight/3), 'signs': [-x for x in v]}])
    terms.append({'weight':'0','signs':[1]*d})
    for idx,value in zip(indices,target['entries']):
        assert sum(F(t['weight'])*prod(t['signs'][i] for i in idx) for t in terms) == F(value)
    return {'terms':terms}

signs = [(1,1,1,1),(1,-1,1,-1),(1,1,-1,-1)]
r = [[sum(w*s[i]*s[j] for w,s in zip((F(1,7),F(2,7),F(4,7)),signs)) for j in range(4)] for i in range(4)]
no = [[F(1 if i==j else (-1 if i<3 and j<3 else 0)) for j in range(4)] for i in range(4)]
for label,matrix,expected in [('four-dimensional rational mixture',r,True),('embedded impossible triangle',no,False)]:
    source={'matrix':[[str(x) for x in row] for row in matrix]}
    target=run(source)
    witness=solve(target)
    assert (witness is not None)==expected
    if witness is not None:
        recovered=run({'source':source,'target_solution':witness},True)
        for i in range(4):
            for j in range(4):
                assert sum(F(t['weight'])*t['signs'][i]*t['signs'][j] for t in recovered['terms'])==matrix[i][j]
    print(json.dumps({'case':label,'decision':expected,'target_entries':len(target['entries']),'terms':len(witness['terms']) if witness else 0}))
# Independent coefficient equality for a biased source atom after antipodal averaging.
s=(1,-1,1,-1,1)
source={'matrix':[[str(x*y) for y in s] for x in s]}
target=run(source)
points=[tuple(q for a,b in zip(mask,(mask[i]*flip*s[i] for i in range(5))) for q in (a,b)) for mask in product((-1,1),repeat=5) for flip in (-1,1)]
for idx,value in zip(combinations_with_replacement(range(10),4),target['entries'],strict=True):
    assert F(sum(prod(p[i] for i in idx) for p in points),len(points))==F(value)
print(json.dumps({'case':'five-dimensional mask identity','entries':len(target['entries']),'support':len(points)}))
for text in ['['*100000+'0'+']'*100000, '{"matrix":[["1/000"]]}', '{"matrix":[["1e0"]]}', '\\ud800']:
    p=subprocess.run([sys.executable,str(candidate)],input=text,text=True,capture_output=True,check=True)
    assert json.loads(p.stdout)=={'dimension':2,'entries':['1','2','1','0','1']}
print(json.dumps({'case':'malformed inputs','count':4}))
