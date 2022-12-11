# Sandra Szwed (261719)
# Obliczenia naukowe, Lista 4, zadanie 5

include("interpolacja.jl")
using .interpolacja
using Plots
using Printf

f(x) = exp(x)

for n in [5,10,15]
    p = rysujNnfx(f, 0.0, 1.0, n)
    savefig(@sprintf("zad5_podpunktA_n=%s.png", n))
end

g(x) = x^(2.0)*sin(x)

for n in [5,10,15]
    p = rysujNnfx(g, -1.0, 1.0, n)
    savefig(@sprintf("zad5_podpunktB_n=%s.png", n))
end

