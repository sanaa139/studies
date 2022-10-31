# Sandra Szwed (261719)
# Obliczenia naukowe, Lista 1, zadanie 6

#funkcja obliczająca podaną w zadaniu funkcję f(x)
#x - argument funkcji
function f(x)
    return sqrt(x * x + 1) - 1
end

#funkcja obliczająca podaną w zadaniu funkcję g(x)
#x - argument funkcji
function g(x)
    return (x * x)/(sqrt((x * x) + 1) + 1)
end


println("---Funkcja f:---")

for i in 1:13
    println(f(8.0^(-1 * i)))
end

println("\n---Funkcja g:---")

for i in 1:13
    println(g(8.0^(-1 * i)))
end