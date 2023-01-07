# Sandra Szwed (261719)
# Obliczenia naukowe, Lista 5

include("blocksys.jl")
include("matrixgen.jl")
using .matrixgen
using .blocksys
using LinearAlgebra
using Plots
using Printf

xs = [16,10000,50000,100000,300000,500000]
ys = [0.000035, 0.160056, 3.349852 , 25.125375, 284.599003, 953.204438]

function generate_plot(xs, ys)
    p = plot(xs, ys, legend = false)
    xlabel!("Rozmiar macierzy A")
    ylabel!("Czas w sekundach")
end

#=generate_plot(xs,ys)
savefig(@sprintf("gauss_czas.png"))=#

A, n, l = blocksys.readMatrix("./dane/A_16.txt")
b = blocksys.readVector("./dane/b_16.txt")
X = blocksys.GaussianEliminationWithPartialPivoting(A,b,n,l)
blocksys.printSolution(X, "./wyniki_z_plikow_Gauss_z_wyborem/16.txt", true)

#=A, n, l = blocksys.readMatrix("./dane/A_16.txt")
b = blocksys.readVector("./dane/b_16.txt")
X = blocksys.GaussianElimination(A,b,n,l)
blocksys.printSolution(X, "./wyniki_z_plikow_zwykly_Gauss/16.txt", true)

A, n, l = blocksys.readMatrix("./dane/A_10000.txt")
b = readVector("./dane/b_100000.txt")
X = blocksys.GaussianElimination(A,b,n,l)
printSolution(X, "./wyniki_z_plikow_zwykly_Gauss/10000.txt", true)

A, n, l = blocksys.readMatrix("./dane/A_50000.txt")
b = readVector("./dane/b_50000.txt")
X = blocksys.GaussianElimination(A,b,n,l)
printSolution(X, "./wyniki_z_plikow_zwykly_Gauss/50000.txt", true)

A, n, l = blocksys.readMatrix("./dane/A_10000.txt")
b = readVector("./dane/b_100000.txt")
X = blocksys.GaussianElimination(A,b,n,l)
printSolution(X, "./wyniki_z_plikow_zwykly_Gauss/100000.txt", true)

A, n, l = blocksys.readMatrix("./dane/A_300000.txt")
b = readVector("./dane/b_300000.txt")
X = blocksys.GaussianElimination(A,b,n,l)
printSolution(X, "./wyniki_z_plikow_zwykly_Gauss/300000.txt", true)

A, n, l = blocksys.readMatrix("./dane/A_500000.txt")
b = readVector("./dane/b_500000.txt")
X = blocksys.GaussianElimination(A,b,n,l)
printSolution(X, "./wyniki_z_plikow_zwykly_Gauss/500000.txt", true)=#