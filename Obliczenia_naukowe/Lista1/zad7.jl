# Sandra Szwed (261719)
# Obliczenia naukowe, Lista 1, zadanie 7

#funkcja f(x)
function f(x)
    return sin(x) + cos(3 * x)
end

#funkcja obliczajaca przyblizona pochodna
function przyblizona_pochodna(x0, h)
    return (f(x0 + h) - f(x0))/h
end

#functionX - wynik pochodnej
#functionY - wynik przyblizonej pochodnej
function blad(functionX, functionY)
    return abs(functionX - functionY)
end

#funkcja obliczajaca pochodna
function pochodna(x0)
    return cos(x0) - 3 * sin(3 * x0)
end

for i in 0:54
    println("Dla 2^", i * (-1), " przyblizona pochodna: ", przyblizona_pochodna(1.0, 2.0^(-i)))
end

println()
for i in 0:54
    println("Dla 2^", i * (-1), " blad: ", blad(pochodna(1.0), przyblizona_pochodna(1.0, 2.0^(-i))))
end

println()
for i in 0:54
    println("Dla 2^", i * (-1), " 1+h: ", 1 + 2.0^(-i))
end