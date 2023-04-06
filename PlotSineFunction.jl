using DataFrames
using Plots

# DataFrames functions and analysis
df = DataFrame(A=1:3, B=5:7, fixed=1)

show(df, allrows=true)

# Plots functions and analysis
x = range(0, 10, length=100)
y = sin.(x)
plot(x, y)

x = range(0, 10, length=100)
y1 = sin.(x)
y2 = cos.(x)
p = plot(x, [y1 y2])

y3 = @. sin(x)^2 - 1/2
plot!(p, x, y3)

default(legend = false)
x = y = range(-5, 5, length = 40)
zs = zeros(0, 40)
n = 100

savefig("PDFs/sineFunction.pdf")   # saves the plot from p as a .pdf vector graphic
savefig("Images/sineFunction.png")   # saves the plot from p as a .pdf vector graphic