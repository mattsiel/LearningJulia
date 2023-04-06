using DataFrames
using CSV

# new file created
touch("people.csv")
 
# file handling in write mode
efg = open("people.csv", "w")
 
# Creating a new dataframe
mn = DataFrame(Name = ["AKANKSHA", "TANYA", "PREETIKA", "VRINDA", "JAHNVI"],
               Age = [42, 44, 22, 81, 93],
               Salary = [540000, 650000, 900000, 770000, 850000],
         RESIDENCE=["DELHI", "DELHI", "UP", "HARYANA", "UP"]
               )
                
# writing to the newly created file
CSV.write("people.csv", mn)

# Format
# CSV.File(filename;drop=["colulm1", "column2"....., column n])
 
# dropping "RESIDENCE" column from our file (people.csv")
CSV.File("people.csv"; drop=["RESIDENCE"])

# Format for select command
# CSV.File(file; select=[column1, column2])
 
# Select the columns 'Name and Salary'
CSV.File("people.csv"; select=["Name", "Salary"])
 
# Selecting columns number wise
# selecting column 1 and 3
CSV.File("people.csv"; select=(i, nm) -> i in (1, 3))
 
# selecting column 1, 2, 3
CSV.File("people.csv"; select=(i, nm) -> i in (1, 2, 3))

# file = CSV.read("myfile.csv", DataFrames)