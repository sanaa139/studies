# Sandra Szwed (261719)
# Obliczenia naukowe, Lista 1, zadanie 2

#type - typy: Float16, Float32, Float64
function isKahanRight(type)
    return type(3) * (type(4) / type(3) - type(1)) - type(1)
end

println("---MACHEPS---")
println("Macheps for Float16:")
println("Macheps calculated using Kahan's expression: ", isKahanRight(Float16), "\neps(): ", eps(Float16))
println("\nMacheps for Float32:")
println("Macheps calculated using Kahan's expression: : ", isKahanRight(Float32), "\neps(): ", eps(Float32))
println("\nMacheps for Float64:")
println("Macheps calculated using Kahan's expression: : ", isKahanRight(Float64), "\neps(): ", eps(Float64))