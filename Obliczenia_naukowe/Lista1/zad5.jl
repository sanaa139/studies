# Sandra Szwed (261719)
# Obliczenia naukowe, Lista 1, zadanie 5

x = [2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957] 
y = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]
n = 5

#funkcja do przykładu a
#type - typy: Float16, Float32, Float64
function a(type)
    S = type(0.0) #S to suma
    for i in 1:n
        S = type(S + type(type(x[i]) * type(y[i])))
    end
    println(S)
end

#funkcja do przykładu b
#type - typy: Float16, Float32, Float64
function b(type)
    S = type(0.0) #S to suma
    i = 5
    while i >= 1
        S = type(S + type(x[i]) * type(y[i]))
        i = i - 1
    end
    println(S)
end

#funkcja do przykładu c
#type - typy: Float16, Float32, Float64
function c(type)
    pomnozone = Array{type}(undef, 5) #tablica zawierajaca pomnozone przez siebie kolejne liczby z tablicy x i y
    for i in 1:n
        pomnozone[i] = type(x[i]) * type(y[i])
    end

    positiveNumbers = [] #tablica zawierajaca dodatnie liczby z tablicy pomnozone
    negativeNumbers = [] #tablica zawierajaca ujemne liczby z tablicy pomnozone
    
    for i in pomnozone
        if i > 0
            push!(positiveNumbers, i)
        end
        if i < 0
            push!(negativeNumbers, i)
        end
    end

    sort(positiveNumbers,rev = true)
    sort(negativeNumbers)

    positiveSum = type(0.0) #zmienna przechowująca sumę dodatnich liczb
    negativeSum = type(0.0)  #zmienna przechowująca sumę ujemnych liczb

    for i in positiveNumbers
        positiveSum = type(positiveSum + i)
    end

    for i in negativeNumbers
        negativeSum = type(negativeSum + i)
    end

    result = type(positiveSum + negativeSum)
    println(result)
end

# funkcja do przykładu b
#type - typy: Float16, Float32, Float64 
function d(type)
    pomnozone = Array{type}(undef, 5) #tablica zawierajaca pomnozone przez siebie kolejne liczby z tablicy x i y
    for i in 1:n
        pomnozone[i] = type(x[i]) * type(y[i])
    end

    positiveNumbers = [] #tablica zawierajaca dodatnie liczby z tablicy pomnozone
    negativeNumbers = [] #tablica zawierajaca ujemne liczby z tablicy pomnozone

    for i in pomnozone
        if i > 0
            push!(positiveNumbers, i)
        end
        if i < 0
            push!(negativeNumbers, i)
        end
    end

    sort(positiveNumbers)
    sort(negativeNumbers, rev = true)

    positiveSum = type(0.0) #zmienna przechowująca sumę dodatnich liczb
    negativeSum = type(0.0)  #zmienna przechowująca sumę ujemnych liczb

    for i in positiveNumbers
        positiveSum = type(positiveSum + i)
    end

    for i in negativeNumbers
        negativeSum = type(negativeSum + i)
    end

    result = type(positiveSum + negativeSum)
    println(result)
end


println("---Podpunkt a---")
println("FLoat32: ")
a(Float32)
println("\nFLoat64: ")
a(Float64)

println("\n---Podpunkt b---")
println("FLoat32: ")
b(Float32)
println("\nFLoat64: ")
b(Float64)

println("\n---Podpunkt c---")
println("FLoat32: ")
c(Float32)
println("\nFLoat64: ")
c(Float64)

println("\n---Podpunkt d---")
println("FLoat32: ")
d(Float32)
println("\nFLoat64: ")
d(Float64)