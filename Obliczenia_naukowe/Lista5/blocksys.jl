# Sandra Szwed (261719)
# Obliczenia naukowe, Lista 5, zadanie 1
module blocksys

import SparseArrays
using LinearAlgebra

export readMatrix

#=
Funkcja czytająca macierz A z pliku.

Dane:
    file - plik z macierzą A

Wyniki:
    A - macierz A
=#

function readMatrix(file::String)
    data = readlines(file)
    n, l = split(data[1], " ")
    n = parse(Int64, n)
    l = parse(Int64, l)
    rowsIndices = Vector{Float64}()
    columnsIndices = Vector{Float64}()
    values = Vector{Float64}()

    k = 2 
    while k <= size(data)[1]
        i, j, value = split(data[k], " ")
        i = parse(Int64, i)
        j = parse(Int64, j)
        value = parse(Float64, value)
        append!(rowsIndices, i)
        append!(columnsIndices, j)
        append!(values, value)
        k = k + 1
    end
    A = SparseArrays.sparse(rowsIndices, columnsIndices, values)
    return A, n, l
end


#=
Funkcja czytająca wektor prawych stron z pliku.

Dane:
    file - plik z wektorem prawych stron

Wyniki:
    b - wektor prawych stron
=#
function readVector(file::String)
    data = readlines(file)
    n = data[1]
    n = parse(Int64, n)

    b = zeros(n)
    for i in 2:size(data)[1]
        b[i - 1] = parse(Float64, data[i])
    end
    return b
end

#=
Funkcja obliczająca wektor prawych stron.

Dane:
    A - macierz A,
    x - wektor rozwiązań,
    n - wielkość macierzy A,
    l - wielkość bloków macierzy A

Wyniki:
    b - wektor prawych stron
=#
function calculateB(A::SparseArrays.SparseMatrixCSC{Float64, Int64}, x::Vector{Float64}, n::Int64, l::Int64)
    m = 1
    b = zeros(n)
    for k in 1:(l+1)
        for i in m:min(m+2*l,n)
            b[k] += A[k, i] * x[i]
        end
    end

    for k in l+2:n
        m += 1
        for i in m:min(m+2*l,n)
            b[k] += A[k, i] * x[i]
        end
    end
    return b
end


#=
Funkcja drukująca do pliku rozwiązanie oraz błąd względny jeśli wektor prawych stron był obliczany.

Dane:
    X - wektor rozwiązań,
    file - plik do którego zostanie zapisane rozwiązanie,
    n - wielkość macierzy A,
    was_b_from_the_file - tak jeśli b było czytanie z pliku, nie jeśli b było obliczane
=#
function printSolution(X::SparseArrays.SparseVector{Float64, Int64}, file::String, n::Int64, was_b_from_the_file::Bool)
    open(file, "w") do f
        if was_b_from_the_file == false
            x1 = ones(n)
            error = norm(X - x1) / norm(X)
            write(f, string(error))
            write(f, "\n")
        end
        foreach(a->write(f, string(a), "\n"), X)
    end
end


#=
Funkcja obliczająca rozwiązanie dla eliminacji Gaussa bez wyboru elementu głównego.

Dane:
    A - macierz A,
    b - wektor prawych stron,
    n - wielkość macierzy A,
    l - wielkość bloków macierzy A

Wyniki:
    X - wektor rozwiązań
=#
function backwardSubstitution(A::SparseArrays.SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
    X = SparseArrays.spzeros(n)
    X[n] = b[n] / A[n,n]

    for i in n-1:-1:n-l+1
        sum = b[i]
        for j in i+1:n
            sum = sum - A[i, j] * X[j]
        end
        X[i] = sum / A[i, i]
    end
    
    for i in n-l:-1:1
        sum = b[i]
        for j in (i+1):(i+l)
            sum = sum - A[i, j] * X[j]
        end
        X[i] = sum / A[i, i]
    end
    return X
end

#=
Eliminacja Gaussa bez wyboru elementu głównego

Dane:
    A - macierz A,
    b - wektor prawych stron,
    n - wielkość macierzy A,
    l - wielkość bloków macierzy A

Wyniki:
    X - wektor rozwiązań
=#

function GaussianElimination(A::SparseArrays.SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
    for k in 1:(n-1)
        diag = A[k, k]
        for i in (k+1):min(k+l, n)
            fctr = A[i, k] / diag
            for j in k:min(k+l+1, n)
                A[i, j] -= fctr * A[k, j]
            end
            b[i] -= fctr * b[k]
        end
    end
    X = backwardSubstitution(A, b, n, l)
    return X
end

#=
Funkcja obliczająca rozwiązanie dla eliminacji Gaussa z częściowym wyborem elementu głównego.

Dane:
    A - macierz A,
    b - wektor prawych stron,
    n - wielkość macierzy A,
    l - wielkość bloków macierzy A

Wyniki:
    X - wektor rozwiązań
=#

function backwardSubstitutionForGaussWithPivoting(A::SparseArrays.SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
    X = SparseArrays.spzeros(n)
    X[n] = b[n] / A[n,n]

    for i in n-1:-1:n-l+1
        sum = b[i]
        for j in i+1:n
            sum = sum - A[i, j] * X[j]
        end
        X[i] = sum / A[i, i]
    end
    
    for i in n-l:-1:1
        sum = b[i]
        for j in (i+1):min(i+2*l,n)
            sum = sum - A[i, j] * X[j]
        end
        X[i] = sum / A[i, i]
    end
    return X
end

#=
Eliminacja Gaussa z częściowym wyborem elementu głównego

Dane:
    A - macierz A,
    b - wektor prawych stron,
    n - wielkość macierzy A,
    l - wielkość bloków macierzy A

Wyniki:
    X - wektor rozwiązań
=#
function GaussianEliminationWithPartialPivoting(A::SparseArrays.SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
    for k in 1:n-1
        largest_element = -1
        index_of_l_e = -1
        for i = k:min(k+l, n)
            temp = abs(A[i,k])
            if temp > largest_element
                largest_element = temp
                index_of_l_e = i
            end
        end
        
        if index_of_l_e != k
            for i in k:min(k+2*l+1,n)
                A[k, i], A[index_of_l_e,i] = A[index_of_l_e,i], A[k, i]
            end
            b[k], b[index_of_l_e] = b[index_of_l_e], b[k]
        end

        diag = A[k, k]
        for i in (k+1):min(k+l, n)
            fctr = A[i, k] / diag
            for j in k:min(k+2*l, n)
                A[i, j] -= fctr * A[k, j]
            end
            b[i] -= fctr * b[k]
        end
    end
    X = backwardSubstitutionForGaussWithPivoting(A, b, n, l)
    return X
end

end