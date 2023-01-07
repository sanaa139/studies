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

function printSolution(X::SparseArrays.SparseVector{Float64, Int64}, file::String, was_b_from_the_file::Bool)
    open(file, "w") do f
        if was_b_from_the_file == false
            x1 = ones(n)
            error = norm(x - x1) / norm(x)
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

function GaussianEliminationWithPartialPivoting(A::SparseArrays.SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
    A_COPY = copy(A)
    b_copy = copy(b)

    for k in 1:n-1
        largest_element = 0
        index_of_largest_element = -1
        for i = k:min(k+l, n)
            if abs(A_COPY[i,k]) > largest_element
                largest_element = abs(A_COPY[i,k])
                index_of_largest_element = i
            end
        end
        
        if index_of_largest_element != k
            for i in k:min(k+2*l,n)
                elem = A_COPY[k, i]
                A_COPY[k, i] = A_COPY[index_of_largest_element,i]
                A_COPY[index_of_largest_element,i] = elem
            end
            elem_b = b_copy[k]
            b_copy[index_of_largest_element] = b_copy[k]
            b_copy[k] = elem_b
        end

        for i in (k+1):min(k+l+1, n)
            fctr = A_COPY[i, k] / A_COPY[k, k]
            for j in k:min(i+l, n)
                A_COPY[i, j] = A_COPY[i, j] - fctr * A_COPY[k, j]
            end
            b_copy[i] = b_copy[i] - fctr * b_copy[k]
        end
    end
    X = backwardSubstitution(A_COPY, b_copy, n, l)
    return X
end

end