# Sandra Szwed (261719)
# Obliczenia naukowe, Lista 2, zadanie 3

using LinearAlgebra

function hilb(n::Int)
    # Function generates the Hilbert matrix  A of size n,
    #  A (i, j) = 1 / (i + j - 1)
    # Inputs:
    #	n: size of matrix A, n>=1
    #
    #
    # Usage: hilb(10)
    #
    # Pawel Zielinski
    if n < 1
        error("size n should be >= 1")
    end
    return [1 / (i + j - 1) for i in 1:n, j in 1:n]
end

function matcond(n::Int, c::Float64)
# Function generates a random square matrix A of size n with
# a given condition number c.
# Inputs:
#	n: size of matrix A, n>1
#	c: condition of matrix A, c>= 1.0
#
# Usage: matcond(10, 100.0)
#
# Pawel Zielinski
    if n < 2
        error("size n should be > 1")
    end
    if c< 1.0
        error("condition number  c of a matrix  should be >= 1.0")
    end
    (U,S,V)=svd(rand(n,n))
    return U*diagm(0 =>[LinRange(1.0,c,n);])*V'
end

function gauss(A, x)
    b = A*x
    return A\b
end

function inversion(A, x)
    b = A*x
    return inv(A)*b
end

function approximationError(apporxX, x)
    return norm(apporxX - x) / norm(x)
end


println("---Macierz Hilberta---")
for n in 1:20
    println("Dla n = ", n, ":")
    A = hilb(n) # A to macierz hilberta
    x = ones(Float64, n)
    println("Błąd względny metody Gaussa: ", approximationError(gauss(A, x),x), 
        " Bąd względy metody inwersji: ", approximationError(inversion(A, x), x),
        " Wskaźnik uwarunkowania: ", cond(A), " Rząd macierzy: ", rank(A), "\n")
end

println("\n\n---Losowa macierz stopnia n z zadanym wskaźnikiem uwarunkowania c---")
for n in [5,10,20]
    for c in [1.0,10.0,10.0^3,10.0^7,10.0^12,10.0^16]
        println("Dla n = ", n, " oraz c = ", c, ":")
        println("a) eliminacja Gaussa: ")
        A = matcond(n,c) # A to macierz R_N
        x = ones(Float64, n)
        println("Błąd względny metody Gaussa: ", approximationError(gauss(A, x),x), 
        " Bąd względy metody inwersji: ", approximationError(inversion(A, x), x),
        " Wskaźnik uwarunkowania: ", cond(A), " Rząd macierzy: ", rank(A), "\n")
    end
end