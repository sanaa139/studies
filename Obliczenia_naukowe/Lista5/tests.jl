# Sandra Szwed (261719)
# Obliczenia naukowe, Lista 5

include("blocksys.jl")
include("matrixgen.jl")
using .matrixgen
using .blocksys
using LinearAlgebra
using Plots
using Printf

amount = "300000"
println(amount)
A, n, l = blocksys.readMatrix("./dane/A_"*amount*".txt")
b = blocksys.readVector("./dane/b_"*amount*".txt")
x = ones(n)
#b = blocksys.calculateB(A, x, n, l)
X = blocksys.GaussianElimination(A,b,n,l)
#X = blocksys.GaussianEliminationWithPartialPivoting(A,b,n,l)
blocksys.printSolution(X, "./wyniki_z_plikow_zwykly_Gauss/"*amount*".txt", n, true)