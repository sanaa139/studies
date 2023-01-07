# Sandra Szwed (261719)
# Obliczenia naukowe, Lista 5, zadanie 1
module blocksys

import SparseArrays
using LinearAlgebra

export readMatrix

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

function GaussianEliminationWithPartialPivoting(A::SparseArrays.SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
    for k in 1:n-1
        largest_element = 0
        index_of_largest_element = -1
        for i = k:min(k+l, n)
            if abs(A[i,k]) > largest_element
                largest_element = abs(A[i,k])
                index_of_largest_element = i
            end
        end
        
        if index_of_largest_element != k
            for i in k:min(k+2*l,n)
                elem = A[k, i]
                A[k, i] = A[index_of_largest_element,i]
                A[index_of_largest_element,i] = elem
            end
            elem_b = b[k]
            b[k] = b[index_of_largest_element]
            b[index_of_largest_element] = elem_b
        end

        diag = A[k, k]
        for i in (k+1):min(k+l, n)
            fctr = A[i, k] / diag
            for j in k:min(k+l+1, n)
                A[i, j] -= fctr * A[k, j]
            end
            b[i] -= fctr * b[k]
        end
    end
    X = backwardSubstitutionForGaussWithPivoting(A, b, n, l)
    return X
end

end