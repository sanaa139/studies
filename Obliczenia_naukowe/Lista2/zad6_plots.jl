# Sandra Szwed (261719)
# Obliczenia naukowe, Lista 2, zadanie 6 wykresy

using Printf
using Plots

input_data = [[-2,1], [-2,2], [-2,1.99999999999999], [-1,1], [-1,-1], [-1,0.75], [-1,0.25]]

function calculate_next_x(x_n, c)
    return x_n^2 + c
end        

function quadratic_formula(c)
    xs = LinRange(-2,2,100)
    ys = []
    for x in xs
        push!(ys, calculate_next_x(x, c))
    end
    return [xs, ys]
end

function generate_line()
    xs = LinRange(-2,2,100)
    ys = LinRange(-2,2,100)
    return [xs, ys]
end

function graphic_iteration(x_0, c, n)
    xs = []
    push!(xs, Float64(x_0))
    ys = []
    push!(ys, Float64(0))
    x = x_0
    y = 0
    for i in 1:n
        y = calculate_next_x(x, c)
        push!(xs, x)
        push!(ys, y)

        x = y
        push!(xs, x)
        push!(ys, y)
    end
    return [xs, ys]
end

function generate_plot(c, x_0, n)
    line = generate_line()
    quadratic = quadratic_formula(c)
    goal = graphic_iteration(x_0, c, n)
    
    p = plot(line[1], line[2], legend = false)
    plot!(p, quadratic[1], quadratic[2])
    plot!(p, goal[1], goal[2])
end

for (c, x_0) in input_data
    generate_plot(c, x_0, 40)
    savefig(@sprintf("c=%s_x_0=%s.png", c, x_0))
end