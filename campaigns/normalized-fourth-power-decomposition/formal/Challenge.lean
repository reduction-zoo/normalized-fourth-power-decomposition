module

public import Mathlib.Computability.TuringMachine.Computable
public import Mathlib.Analysis.Real.Sqrt

@[expose] public section

namespace NormalizedFourthPowerDecomposition

/-- Q001's self-delimiting binary natural; length is logarithmic, not unary. -/
def encodeNat (n : Nat) : List Bool :=
  let bits := (Nat.toDigits 2 n).map (fun c => c == '1')
  List.replicate bits.length true ++ [false] ++ bits

def encodeList {α : Type} (encode : α → List Bool) (xs : List α) : List Bool :=
  encodeNat xs.length ++ xs.flatMap encode

def encodeOption {α : Type} (encode : α → List Bool) : Option α → List Bool
  | none => [false]
  | some x => true :: encode x

/-- None denotes mathematical nonexistence, never an execution error. -/
def searchOutput {I W : Type} (legal : I → Bool) (witness : I → W → Bool)
    (x : I) : Option W → Prop
  | some w => legal x = true ∧ witness x w = true
  | none => legal x = true ∧ ¬ ∃ w, witness x w = true

/-- Relational version for witnesses with quantified real or optimality conditions. -/
def relationalOutput {I W : Type} (legal : I → Bool) (witness : I → W → Prop)
    (x : I) : Option W → Prop
  | some w => legal x = true ∧ witness x w
  | none => legal x = true ∧ ¬ ∃ w, witness x w

def encodeInt (z : Int) : List Bool := [decide (z < 0)] ++ encodeNat z.natAbs
def encodeRat (q : Rat) : List Bool := encodeInt q.num ++ encodeNat q.den
def words (alphabet : Nat) : Nat → List (List Nat)
  | 0 => [[]]
  | k+1 => (List.range alphabet).flatMap (fun v => (words alphabet k).map (v :: ·))

structure Source where
  n : Nat
  matrix : List (List Rat)
  deriving Repr
def matrixEntry (x : Source) (i j : Nat) := (x.matrix[i]?.getD [])[j]?.getD 0
def legalSource (x : Source) : Bool := x.matrix.length == x.n && x.matrix.all (fun row => row.length == x.n) &&
  (List.range x.n).all (fun i => matrixEntry x i i == 1 &&
    (List.range x.n).all (fun j => matrixEntry x i j == matrixEntry x j i))
abbrev Mixture := List (Rat × List Bool)
def sign (s : List Bool) (i : Nat) : Rat := if s[i]?.getD false then 1 else -1
def convex (n : Nat) (w : Mixture) : Bool := w.all (fun (p,s) => p ≥ 0 && s.length == n) && (w.map Prod.fst).sum == 1
def sourceWitness (x : Source) (w : Mixture) : Bool := convex x.n w &&
  (List.range x.n).all (fun i => (List.range x.n).all (fun j =>
    matrixEntry x i j == (w.map (fun (p,s) => p*sign s i*sign s j)).sum))
structure Instance where
  n : Nat
  entries : List Rat
  deriving Repr
def tensorEntry (x : Instance) (indices : List Nat) : Rat := x.entries[indices.foldl (fun i j => i*x.n+j) 0]?.getD 0
def legalTarget (x : Instance) : Bool := x.entries.length == x.n^4 &&
  (words x.n 4).all (fun indices => indices.permutations.all (fun other => tensorEntry x indices == tensorEntry x other)) &&
  (List.range x.n).all (fun i => (List.range x.n).all (fun j => tensorEntry x [i,i,j,j] == 1))
def targetWitness (x : Instance) (w : Mixture) : Bool := convex x.n w &&
  (words x.n 4).all (fun indices => tensorEntry x indices ==
    (w.map (fun (p,s) => p*(indices.map (sign s)).prod)).sum)
def realDecomposable (x : Instance) : Prop := ∃ terms : List (List ℝ),
  (∀ v ∈ terms, v.length = x.n) ∧ ∀ indices ∈ words x.n 4,
    (tensorEntry x indices : ℝ) =
      (terms.map (fun v => (indices.map (fun i => v[i]?.getD 0)).prod)).sum
def validSourceOutput := searchOutput legalSource sourceWitness
def validTargetOutput := searchOutput legalTarget targetWitness
def encodeSource (x : Source) := encodeList encodeNat (List.range x.n) ++ encodeList (encodeList encodeRat) x.matrix
def encodeTarget (x : Instance) := encodeList encodeNat (List.range x.n) ++ encodeList encodeRat x.entries
def encodeWitness := encodeList (fun w : Rat × List Bool => encodeRat w.1 ++ encodeList (fun b => [b]) w.2)

/-- Both algorithms use Q001's explicit bit encoding and TM2 cost model.
Recovery receives the full pair of source instance and target output. -/
def Reduction (forward : Source → Instance)
    (recover : Source × Option Mixture → Option Mixture) : Prop :=
  Nonempty (Turing.TM2ComputableInPolyTime encodeSource encodeTarget forward) ∧
  Nonempty (Turing.TM2ComputableInPolyTime
    (fun input => encodeSource input.1 ++ (encodeOption encodeWitness) input.2)
    (encodeOption encodeWitness) recover) ∧
  (∃ bound : Polynomial Nat, ∀ x,
    (encodeTarget (forward x)).length ≤ bound.eval (encodeSource x).length) ∧
  (∃ bound : Polynomial Nat, ∀ input,
    ((encodeOption encodeWitness) (recover input)).length ≤
      bound.eval (encodeSource input.1 ++ (encodeOption encodeWitness) input.2).length) ∧
  (∀ x, legalSource x = true → legalTarget (forward x) = true) ∧
  (∀ x, legalSource x = true → ∀ y, validTargetOutput (forward x) y →
    validSourceOutput x (recover (x, y)))
  ∧ (∀ tensor, legalTarget tensor = true → ((∃ w, targetWitness tensor w = true) ↔ realDecomposable tensor))

def Goal : Prop :=
  ∃ (forward : Source → Instance)
    (recover : Source × Option Mixture → Option Mixture), Reduction forward recover

/-- Open question only; this placeholder is not a solution. -/
theorem solve : Goal := by
  sorry

end NormalizedFourthPowerDecomposition
