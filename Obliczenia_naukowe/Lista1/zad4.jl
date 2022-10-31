# Sandra Szwed (261719)
# Obliczenia naukowe, Lista 1, zadanie 4

# funkcja do przykładu a
function a()
    while true
        number = rand() + 1 #number to losowana liczba
        if(number * (1/number) != 1)
            println("Wylosowana liczba podłożona pod warunek:", number * (1/number))
            return number
        end
    end
end

# funkcja do przykładu b
function b()
    number = 1.0 #number to najmniejsza liczba spelniajaca warunek zadania
    while (number * (1/number)) == 1
        number = nextfloat(number)
    end
    return number
end

println("Wylosowana liczba: ", a())
println("Najmniejsza liczba: ", b())