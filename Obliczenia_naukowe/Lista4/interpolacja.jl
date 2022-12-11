# Sandra Szwed (261719)
# Obliczenia naukowe, Lista 4, zadanie 1-4
module interpolacja
export ilorazyRoznicowe, warNewton, rysujNnfx

using Plots

# Dane:
#       x – wektor długości n + 1 zawierający węzły x0, . . . , xn
#           x[1]=x0,..., x[n+1]=xn
#       f – wektor długości n + 1 zawierający wartości interpolowanej
#           funkcji w węzłach f(x0), . . . , f(xn)
# Wyniki:
#       fx – wektor długości n + 1 zawierający obliczone ilorazy różnicowe
#           fx[1]=f[x0],
#           fx[2]=f[x0, x1],..., fx[n]=f[x0, . . . , xn−1], fx[n+1]=f[x0, . . . , xn].

function ilorazyRoznicowe(x::Vector{Float64}, f::Vector{Float64})
    n = length(x)
    fx = zeros(n)
    for i in 1:n
        fx[i] = f[i]
    end
    for j in 2:n
        for i in n:-1:j
            fx[i] = (fx[i] - fx[i-1])/(x[i]-x[i-j+1])
        end
    end
    return fx
end

# Dane:
#       x – wektor długości n + 1 zawierający węzły x0, . . . , xn
#           x[1]=x0,..., x[n+1]=xn
#       fx – wektor długości n + 1 zawierający ilorazy różnicowe
#           fx[1]=f[x0],
#           fx[2]=f[x0, x1],..., fx[n]=f[x0, . . . , xn−1], fx[n+1]=f[x0, . . . , xn]
#       t – punkt, w którym należy obliczyć wartość wielomianu
# Wyniki:
#       nt – wartość wielomianu w punkcie t.

function warNewton(x::Vector{Float64}, fx::Vector{Float64}, t::Float64)
    n = length(x)
    nt = fx[n]
    for i = (n-1):-1:1
        nt = nt * (t - x[i]) + fx[i]
    end

    return nt
end

# Dane:
#       f – funkcja f(x) zadana jako anonimowa funkcja,
#       a,b – przedział interpolacji
#       n – stopień wielomianu interpolacyjnego
# Wyniki:
#       – funkcja rysuje wielomian interpolacyjny i interpolowaną
#           funkcję w przedziale [a, b].

function rysujNnfx(f,a::Float64,b::Float64,n::Int)
    # Wyznaczamy n+1 równoodległych węzłów
    x = Vector{Float64}(collect(LinRange(a,b,n+1)))
    # Wyznaczamy wartości funkcji na wcześniej wyznaczonych węzłach
    y = Vector{Float64}([])
    for i = 1:n+1
        append!(y, f(x[i]))
    end
    # Wyznaczamy ilorazy różnicowe
    fx = ilorazyRoznicowe(x,y)

    # Wyznaczamy 300 równoodległych punktów na osi OX w przedziale [a,b]
    plotXS = Vector{Float64}(collect(LinRange(a,b,300)))
    # Wyznaczamy wartości funkcji w punktach plotXS
    plotYS = Vector{Float64}([])
    for i in plotXS
        append!(plotYS, f(i))
    end

    # Wyznaczamy wartości wielomianu w punktach plotXS (te same punkty ma też funkcja) używając funkcji warNewton
    # która zwraca nam wartość wielomianu w postaci Newtona w danym punkcie używając uogólnionego
    # algorytmu Hornera
    plotPolyYS = Vector{Float64}([])
    for i in plotXS
        append!(plotPolyYS, warNewton(x, fx, i))
    end

    # Rysujemy wielomian 
    p = plot(plotXS, plotPolyYS, label = "Wielomian")
    # Rysujemy funkcję
    plot!(plotXS, plotYS, label = "Funkcja")
    return p
    
end

end