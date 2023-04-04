using DataFrames
using CSV
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

savefig("PDFs/myplot.pdf")   # saves the plot from p as a .pdf vector graphic
savefig("Images/myplot.png")   # saves the plot from p as a .pdf vector graphic

# CirclePlot
@userplot CirclePlot
@recipe function f(cp::CirclePlot)
    x, y, i = cp.args
    n = length(x)
    inds = circshift(1:n, 1 - i)
    linewidth --> range(0, 10, length = n)
    seriesalpha --> range(0, 1, length = n)
    aspect_ratio --> 1
    label --> false
    x[inds], y[inds]
end

n = 150
t = range(0, 2π, length = n)
x = sin.(t)
y = cos.(t)

anim = @animate for i ∈ 1:n
    circleplot(x, y, i)
end
gif(anim, "Gifs/anim_fps15.gif", fps = 15)


default(legend = false)
x = y = range(-5, 5, length = 40)
zs = zeros(0, 40)
n = 100

swirls = @animate for i in range(0, stop = 2π, length = n)
    f(x, y) = sin(x + 10sin(i)) + cos(y)

    # create a plot with 3 subplots and a custom layout
    l = @layout [a{0.7w} b; c{0.2h}]
    p = plot(x, y, f, st = [:surface, :contourf], layout = l)

    # induce a slight oscillating camera angle sweep, in degrees (azimuth, altitude)
    plot!(p[1], camera = (10 * (1 + cos(i)), 40))

    # add a tracking line
    fixed_x = zeros(40)
    z = map(f, fixed_x, y)
    plot!(p[1], fixed_x, y, z, line = (:black, 5, 0.2))
    vline!(p[2], [0], line = (:black, 5))

    # add to and show the tracked values over time
    global zs = vcat(zs, z')
    plot!(p[3], zs, alpha = 0.2, palette = cgrad(:blues).colors)
end
gif(swirls, "Gifs/swirls.gif", fps = 30)     # saves the CURRENT_PLOT as a .png

 
# # Creating DataFrame
# ab = DataFrame(Name = ["AKANKSHA", "TANYA", "PREETIKA", "VRINDA", "JAHNVI"],
#                Age = [42, 44, 22, 81, 93],
#                Salary = [540000, 650000, 900000, 770000, 850000],
#          RESIDENCE=["DELHI", "DELHI", "UP", "HARYANA", "UP"]
#                ) 
 
# # modifying the content of myfile.csv using write method
# CSV.write("myfile.csv", ab)


# new file created
touch("newfile.csv")
 
# file handling in write mode
efg = open("newfile.csv", "w")
 
# Creating a new dataframe
mn = DataFrame(Name = ["AKANKSHA", "TANYA", "PREETIKA", "VRINDA", "JAHNVI"],
               Age = [42, 44, 22, 81, 93],
               Salary = [540000, 650000, 900000, 770000, 850000],
         RESIDENCE=["DELHI", "DELHI", "UP", "HARYANA", "UP"]
               )
                
# writing to the newly created file
CSV.write("newfile.csv", mn)

# Format
# CSV.File(filename;drop=["colulm1", "column2"....., column n])
 
# dropping "RESIDENCE" column from our file (newfile.csv")
CSV.File("newfile.csv"; drop=["RESIDENCE"])

# Format for select command
# CSV.File(file; select=[column1, column2])
 
# Select the columns 'Name and Salary'
CSV.File("newfile.csv"; select=["Name", "Salary"])
 
# Selecting columns number wise
# selecting column 1 and 3
CSV.File("newfile.csv"; select=(i, nm) -> i in (1, 3))
 
# selecting column 1, 2, 3
CSV.File("newfile.csv"; select=(i, nm) -> i in (1, 2, 3))

# file = CSV.read("myfile.csv", DataFrames)