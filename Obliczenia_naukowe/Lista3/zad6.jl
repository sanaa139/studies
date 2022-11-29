# Sandra Szwed (261719)
# Obliczenia naukowe, Lista 3, zadanie 6

include("MiejscaZerowe.jl")

f1(x) = exp.(1-x) - 1
pf1(x) = -exp.(1-x)
f2(x) = x*exp.(-x)
pf2(x) = (-exp.(-x))*(x-1)
delta = 10^(-5)
epsilon = 10^(-5)

maxit = 30

println("---f1(x)---")

println("---Metoda bisekcji---")
a = [0.0, -0.5, -0.1, -3.0, 0.99]
b = [2.0, 2.5, 1.2, 2.0, 1.1]

for (a1, b1) in zip(a, b)
    println("[", a1, ",", b1, "]")
    (r, v, it, err) = MiejscaZerowe.mbisekcji(f1, a1, b1, delta, epsilon)
    println("   r: $(r), v: $(v), it: $(it), err: $(err)")
end

println("---Metoda Newtona---")
a = [3.2, 0.98, -0.1, 0.0, -2.5]
maxit = 30

for a1 in a
    println(a1)
    (r, v, it, err) = MiejscaZerowe.mstycznych(f1, pf1, a1, delta, epsilon, maxit)
    println("   r: $(r), v: $(v), it: $(it), err: $(err)")
end

println("---Metoda siecznych---")
a = [0.5, -1.0, 0.90, 0.5, -2.0]
b = [2.5, -2.0, 1.04, 1.5, 2.0]
maxit = 30
for (a1, b1) in zip(a, b)
    println("[", a1, ",", b1, "]")
    (r, v, it, err) = MiejscaZerowe.msiecznych(f1, a1, b1, delta, epsilon, maxit)
    println("   r: $(r), v: $(v), it: $(it), err: $(err)")
end


println("\n---f2(x)---")
println("---Metoda bisekcji---")
a = [-1.0, -0.5, -2.0, 0.2, -1.5]
b = [1.0, 0.5, 1.0, -0.1, 1.0]

for (a1, b1) in zip(a, b)
    println("[", a1, ",", b1, "]")
    (r, v, it, err) = MiejscaZerowe.mbisekcji(f2, a1, b1, delta, epsilon)
    println("   r: $(r), v: $(v), it: $(it), err: $(err)")
end

println("---Metoda Newtona---")
a = [-1, 2.5, -0.5, 0.01, 3.2]
maxit = 30

for a1 in a
    println(a1)
    (r, v, it, err) = MiejscaZerowe.mstycznych(f2, pf2, a1, delta, epsilon, maxit)
    println("   r: $(r), v: $(v), it: $(it), err: $(err)")
end

println("---Metoda siecznych---")
a = [-0.5, 1.0, 0.90, 0.5, -2.0]
b = [0.5, -2.0, -0.75, -0.3, 2.0]
maxit = 30
for (a1, b1) in zip(a, b)
    println("[", a1, ",", b1, "]")
    (r, v, it, err) = MiejscaZerowe.msiecznych(f2, a1, b1, delta, epsilon, maxit)
    println("   r: $(r), v: $(v), it: $(it), err: $(err)")
end
