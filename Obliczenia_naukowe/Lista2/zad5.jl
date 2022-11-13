# Sandra Szwed (261719)
# Obliczenia naukowe, Lista 2, zadanie 5

function population_growth_model(p0, r, numOfIter, isModified, type)
    num1 = type(p0)
    num2 = type(num1 + r * num1 * (1 - num1))
    println("n = ", 0, ": ", num1)
    
    println("n = ", 1, ": ", num2)
    for i in 2:numOfIter
        num1 = type(num2)
        num2 = type(num1 + r * num1 * (1 - num1))
        if(isModified == true && i == 10)
            num2 = type(trunc(num2; digits = 3))
        end
        println("n = ", i, ": ", num2)
    end
end

println("---40 iteracji (w Float32) ---")
println(population_growth_model(0.01, 3, 40, false, Float32))
println("---40 iteracji po modyfikacji---")
println(population_growth_model(0.01, 3, 40, true, Float32))
println("---40 iteracji w Float64---")
println(population_growth_model(0.01, 3, 40, false, Float64))