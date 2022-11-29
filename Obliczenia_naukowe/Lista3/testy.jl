# Sandra Szwed (261719)
# Obliczenia naukowe, Lista 3

include("MiejscaZerowe.jl")

f(x) = exp.(x) - 5
pf(x) = exp.(x)
delta = 10^(-5)
epsilon = 10^(-5)
maxit = 1000

println("---Bisekcja---")
a = 1.0
b = 2.0
(r, v, it, err) = MiejscaZerowe.mbisekcji(f, a, b, delta, epsilon)
println("r: $(r), v: $(v), it: $(it), err: $(err)")

println("---Metoda Newtona---")
a = 1.0
(r, v, it, err) = MiejscaZerowe.mstycznych(f, pf, a, delta, epsilon, maxit)
println("r: $(r), v: $(v), it: $(it), err: $(err)")

println("---Metoda siecznych---")
a = -0.5
b = 2.0
(r, v, it, err) = MiejscaZerowe.msiecznych(f, a, b, delta, epsilon, maxit)
println("r: $(r), v: $(v), it: $(it), err: $(err)")