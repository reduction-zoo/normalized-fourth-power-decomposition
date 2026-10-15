import Challenge
open NormalizedFourthPowerDecomposition
example : sourceWitness ⟨2,[[1,0],[0,1]]⟩ [(1/2,[true,true]),(1/2,[true,false])] = true := by native_decide
example : targetWitness ⟨1,[1]⟩ [(1,[false])] = true := by native_decide
example : legalTarget ⟨1,[2]⟩ = false := by native_decide
example : targetWitness ⟨1,[1]⟩ [(2,[true])] = false := by native_decide
