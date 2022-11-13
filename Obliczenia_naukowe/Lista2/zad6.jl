# Sandra Szwed (261719)
# Obliczenia naukowe, Lista 2, zadanie 6

function f(c, n, x0)
    if(n == 0) 
        println(x0)
        return x0
    else
        x = f(c, n-1, x0)
        println(x^2 + c)
        return (x^2 + c)
    end
end

println("---Dla c = -2 i x0 = 1:---")
f(-2.0, 40, 1.0)
println("---Dla c = -2 i x0 = 2:---")
f(-2.0, 40, 2.0)
println("---Dla c = -2 i x0 =  1.99999999999999:---")
f(-2.0, 40,  1.99999999999999)
println("---Dla c = -1 i x0 = 1:---")
f(-1.0, 40, 1.0)
println("---Dla c = -1 i x0 = -1:---")
f(-1.0, 40, -1.0)
println("---Dla c = -1 i x0 = 0.75:---")
f(-1.0, 40, 0.75)
println("---Dla c = -1 i x0 = 0.25:---")
f(-1.0, 40, 0.25)
