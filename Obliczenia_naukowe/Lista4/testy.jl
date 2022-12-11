include("interpolacja.jl")
using .interpolacja
using Plots

f(x) = exp(x)

p = rysujNnfx(f, 0.0, 1.0, 2)
savefig("test.png")

g(x) = abs(abs(x) - 1)
p = rysujNnfx(g, -5.0, 5.0, 10)
savefig("test2.png")