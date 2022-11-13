# Sandra Szwed (261719)
# Obliczenia naukowe, Lista 2, zadanie 4

using Polynomials.PolyCompat
using Polynomials

p=[1, -210.0, 20615.0,-1256850.0,
      53327946.0,-1672280820.0, 40171771630.0, -756111184500.0,          
      11310276995381.0, -135585182899530.0,
      1307535010540395.0, -10142299865511450.0,
      63030812099294896.0, -311333643161390640.0,
      1206647803780373360.0, -3599979517947607200.0,
      8037811822645051776.0, -12870931245150988800.0,
      13803759753640704000.0, -8752948036761600000.0,
      2432902008176640000.0]

reversedCoefficients = reverse(p) # odwracamy wspolczynniki bo są podane w złej kolejności
polynomialFromCoefficients = Polynomials.Polynomial(reversedCoefficients)
roots = collect(1.0:20.0)
polynomialFromRoots = poly(roots)
calculatedRoots = Polynomials.roots(polynomialFromCoefficients)

for i in 1:20
    z_k = calculatedRoots[i]
    println(i, ": z_k : ", z_k, "|P(z_k)|: ", abs(polynomialFromCoefficients(z_k)), " |p(z_k)|: ", abs(polynomialFromRoots(z_k)),
    " |z_k - k|: ", abs(z_k - i))
end


p2=[1, -210.0 - (2.0)^(-23), 20615.0,-1256850.0,
      53327946.0,-1672280820.0, 40171771630.0, -756111184500.0,          
      11310276995381.0, -135585182899530.0,
      1307535010540395.0, -10142299865511450.0,
      63030812099294896.0, -311333643161390640.0,
      1206647803780373360.0, -3599979517947607200.0,
      8037811822645051776.0, -12870931245150988800.0,
      13803759753640704000.0, -8752948036761600000.0,
      2432902008176640000.0]

reversedCoefficients2 = reverse(p2) # odwracamy wspolczynniki bo są podane w złej kolejności
polynomialFromCoefficients2 = Polynomials.Polynomial(reversedCoefficients2)
roots2 = collect(1.0:20.0)
polynomialFromRoots2 = poly(roots2)
calculatedRoots2 = Polynomials.roots(polynomialFromCoefficients2)

println("\n ---Po modyfikacji: ---")
for i in 1:20
    z_k = calculatedRoots2[i]
    println(i, ": z_k : ", z_k, " |P(z_k)|: ", abs(polynomialFromCoefficients2(z_k)), " |p(z_k)|: ", abs(polynomialFromRoots2(z_k)),
    " |z_k - k|: ", abs(z_k - i))
end
    
