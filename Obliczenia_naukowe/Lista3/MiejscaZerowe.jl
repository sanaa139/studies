# Sandra Szwed (261719)
# Obliczenia naukowe, Lista 3, zadanie 1, 2 i 3

module MiejscaZerowe
export mbisekcji, mstycznych, msiecznych

# Funkcja rozwiązująca równanie f(x) = 0 metodą bisekcji.

#=
Dane:
             f – funkcja f(x) zadana jako anonimowa funkcja (ang. anonymous function),
           a,b – końce przedziału początkowego,
 delta,epsilon – dokładności obliczeń,

Wyniki:
  (r,v,it,err) – czwórka, gdzie
             r – przybliżenie pierwiastka równania f(x) = 0,
             v – wartość f(r),
            it – liczba wykonanych iteracji,
           err – sygnalizacja błędu
                 0 - brak błędu
                 1 - funkcja nie zmienia znaku w przedziale [a,b]
=#

function mbisekcji(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64)
    u = f(a)
    v = f(b)

    e = b - a

    it = 0

    if(sign(u) == sign(v)) 
        return (0,0,it,1)
    end

    while true
        it += 1
        e = e/2
        c = a + e
        w = f(c)
        if(abs(e) < delta || abs(w) < epsilon)
            return (c,w,it,0)
        end

        if(sign(w) != sign(u))
            b = c
            v = w
        else
            a = c
            u = w
        end
    end
end


# Funkcja rozwiązująca równanie f(x) = 0 metodą Newtona.

#=
Dane:
         f, pf – funkcją f(x) oraz pochodną f'(x) zadane jako anonimowe funkcje,
            x0 – przybliżenie początkowe,
 delta,epsilon – dokładności obliczeń,
         maxit – maksymalna dopuszczalna liczba iteracji,

Wyniki:
  (r,v,it,err) – czwórka, gdzie
             r – przybliżenie pierwiastka równania f(x) = 0,
             v – wartość f(r),
            it – liczba wykonanych iteracji,
           err – sygnalizacja błędu
                 0 - metoda zbieżna
                 1 - nie osiągnięto wymaganej dokładności w maxit iteracji,
                 2 - pochodna bliska zeru
=#

function mstycznych(f,pf,x0::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    it = 0
    v = f(x0)
    if(abs(v) < epsilon)
        return (x0, v, it, 0)
    end

    while true
        it += 1
        x1 = x0 - v/pf(x0)
        v = f(x1)

        if(abs(x1 - x0) < delta || abs(v) < epsilon)
            return (x1, v, it, 0)
        end
        x0 = x1
    end
    return (x0, v, maxit, 1)
end

# Funkcja rozwiązująca równanie f(x) = 0 metodą siecznych.

#=
Dane:
             f – funkcja f(x) zadana jako anonimowa funkcja,
         x0,x1 – przybliżenia początkowe,
 delta,epsilon – dokładności obliczeń,
         maxit – maksymalna dopuszczalna liczba iteracji,
Wyniki:
  (r,v,it,err) – czwórka, gdzie
             r – przybliżenie pierwiastka równania f(x) = 0,
             v – wartość f(r),
            it – liczba wykonanych iteracji,
           err – sygnalizacja błędu
                 0 - metoda zbieżna
                 1 - nie osiągnięto wymaganej dokładności w maxit iteracji
=#

function msiecznych(f, x0::Float64, x1::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    fa = f(x0)
    fb = f(x1)

    for it in 1:maxit
        if(abs(fa) < abs(fb))
            x0, x1 = x1, x0
            fa, fb = fb, fa
        end
        s = (x1 - x0)/(fb - fa)
        x0 = x1
        fa = fb
        x1 = x1 - fa * s
        fb = f(x1)
        if(abs(x1 - x0) < delta || abs(fb) < epsilon)
            return (x1, fb, it, 0)
        end
    end
    return (x1, fb, maxit, 1)
end

end