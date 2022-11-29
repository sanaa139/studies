# Sandra Szwed (261719)
# Obliczenia naukowe, Lista 3, zadanie 4

include("MiejscaZerowe.jl")

f(x) = sin(x) - (x/2)^2
delta = 0.5 * 10^(-5)
epsilon = 0.5 * 10^(-5)
pf(x) = cos(x) - x/2

maxit = 30

println("---Metoda bisekcji---")
a = 1.5
b = 2.0
(r, v, it, err) = MiejscaZerowe.mbisekcji(f, a, b, delta, epsilon)
println("r: $(r), v: $(v), it: $(it), err: $(err)")

println("---Metoda Newtona---")
x0 = 1.5
(r,v,it,err) = MiejscaZerowe.mstycznych(f, pf, x0, delta, epsilon, maxit)
println("r: $(r), v: $(v), it: $(it), err: $(err)")

println("---Metoda siecznych---")
x0 = 1.0
x1 = 2.0
(r,v,it,err) = MiejscaZerowe.msiecznych(f, x0, x1, delta, epsilon, maxit)
println("r: $(r), v: $(v), it: $(it), err: $(err)")