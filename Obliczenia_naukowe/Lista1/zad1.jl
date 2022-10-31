# Sandra Szwed (261719)
# Obliczenia naukowe, Lista 1, zadanie 1

#type - typy: Float16, Float32, Float64
function findMacheps(type)
    macheps = type(1.0)
    while type(1.0) + type(macheps / 2) > type(1.0)
        macheps = type(macheps / 2)
    end
    return macheps
end

println("---MACHEPS---")
println("Macheps for Float16:")
println("My macheps: ", findMacheps(Float16), "\neps(): ", eps(Float16))
println("\nMacheps for Float32:")
println("My macheps: ", findMacheps(Float32), "\neps(): ", eps(Float32))
println("\nMacheps for Float64:")
println("My macheps: ", findMacheps(Float64), "\neps(): ", eps(Float64))

#type - typy: Float16, Float32, Float64
function findEta(type)
    eta = type(1.0)
    while type(eta / 2) > type(0.0)
        eta = type(eta / 2)
    end
    return eta
end

#type - typy: Float16, Float32, Float64
#jest zle bo nie mozna uzywac prevfloat tutaj!
function findMax(type)
    max = prevfloat(type(1.0))
    while !isinf(2*max)
        max = max * 2
    end
    return max
end

    
println("\n---ETA---")
println("Eta for Float16:")
println("My eta: ", findEta(Float16), "\nnextFloat(): ", nextfloat(Float16(0.0)))
println("\nEta for Float32:")
println("My eta: ", findEta(Float32), "\nnextFloat(): ", nextfloat(Float32(0.0)))
println("\nEta for Float64:")
println("My eta: ", findEta(Float64), "\nnextFloat(): ", nextfloat(Float64(0.0)))

println("\n ---floatmin---")
println("floatmin dla Float32: ", floatmin(Float32))
println("floatmin dla Float64: ", floatmin(Float64))

println("\n ---max---")
println("max dla Float16: ", findMax(Float16))
println("max dla Float32: ", findMax(Float32))
println("max dla Float64: ", findMax(Float64))

println("\n ---floatmax---")
println("floatmax dla Float16: ", floatmax(Float16))
println("floatmax dla Float32: ", floatmax(Float32))
println("floatmax dla Float64: ", floatmax(Float64))

println("\n ---minsub---")
println("minsub dla Float16: ", Float16(2.0^(-24)))
println("minsub dla Float32: ", Float32(2.0^(-149)))
println("minsub dla Float64: ", Float64(2.0^(-1074)))

println("\n ---minnor---")
println("minnor dla Float16: ", Float16(2.0^(-14)))
println("minnor dla Float32: ", Float32(2.0^(-126)))
println("minnor dla Float64: ", Float64(2.0^(-1022)))
