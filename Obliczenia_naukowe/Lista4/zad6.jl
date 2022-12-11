# Sandra Szwed (261719)
# Obliczenia naukowe, Lista 4, zadanie 6

include("interpolacja.jl")
using .interpolacja
using Plots
using Printf

f(x) = abs(x)

for n in [5,10,15]
    p = rysujNnfx(f, -1.0, 1.0, n)
    savefig(@sprintf("zad6_podpunktA_n=%s.png", n))
end

g(x) = 1/(1+x^(2.0))

for n in [5,10,15]
    p = rysujNnfx(g, -5.0, 5.0, n)
    savefig(@sprintf("zad6_podpunktB_n=%s.png", n))
end
