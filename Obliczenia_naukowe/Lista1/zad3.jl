# Sandra Szwed (261719)
# Obliczenia naukowe, Lista 1, zadanie 3

#delta - wykonywany krok. from - gdzie sie zaczyna przedzial
function f(delta, from
    number = from #number przechowuje liczbę, którą otrzymaliśmy wykonując dany krok
    for i = 1:8
        number += delta
        println(bitstring(x))
    end
end

println("Dla przedziału [1,2] dla delty 2.0^(-52):")
f(2.0^(-52), 1.0)

println("Dla przedziału [1/2,1] dla delty 2.0^(-52)")
f(2.0^(-52), 1.0/2.0)
println("Dla przedziału [1/2,1] dla delty 2.0^(-53)")
f(2.0^(-53), 1.0/2.0)

println("Dla przedziału [2,4] dla delty 2.0^(-52)")
f(2.0^(-52), 2.0)
println("Dla przedziału [2,4] dla delty 2.0^(-51)")
f(2.0^(-51), 2.0)
println("Dla przedziału [2,4] dla delty 2.0^(-53)")
f(2.0^(-53), 2.0)