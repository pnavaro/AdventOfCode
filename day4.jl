
const required_fields = [
    "byr",  # Birth Year
    "ecl",  # Eye Color
    "eyr",  # Expiration Year
    "hcl",  # Hair Color
    "hgt",  # Height
    "iyr",  # Issue Year
    "pid"   # Passport ID
]


function new_passport(fields)

    p = Dict{String,Any}()
    for field in vcat(split.(fields)...)
       key, value = split(field,":")
       p[key] = value
    end
    return p

end

function read_passports(filename)

   passports = []
   open(filename) do f
     
       newdict = true
       fields  = []
       for line in eachline(f)

           if isempty(line)
               push!(passports, new_passport(fields))
               fields = []
           else
               push!(fields, line)
           end
       end

       # end of the file, last passport
       push!(passports, new_passport(fields))

   end

   return passports


end

function valid1( p ) 

    valid_fields = collect(filter(k->(k!="cid"), keys(p)))
   
    if length(valid_fields) == 7
        return all( sort(valid_fields) .== required_fields)
    else
        return false
    end

end

const eye_colors = ["amb","blu","brn","gry","grn","hzl","oth"]

function valid2( p ) # not finish...

    if valid1(p) 

        1920 <= parse(Int, p["byr"]) <= 2002 || (return false)
        2010 <= parse(Int, p["iyr"]) <= 2020 || (return false)
        2020 <= parse(Int, p["eyr"]) <= 2030 || (return false)
        hgt = p["hgt"]
        if endswith(hgt, "cm") 
            150 <= parse(Int,hgt[1:end-2]) <= 193 || (return false)
        elseif endswith(hgt, "in") 
            59 <= parse(Int,hgt[1:end-2]) <= 76 || (return false)
        else
            return false
        end
        startswith(p["hcl"], "#") || (return false)
        tryparse(Int, p["hcl"][2:end], base=16) == nothing && (return false)
        p["ecl"] in eye_colors || (return false)
        length(p["pid"]) == 9 || (return false)
        tryparse(Int, p["pid"]) == nothing && (return false)

        return true

    else
        return false
    end

end

passports = read_passports( "input4.txt")
println(count(valid1.(passports)))
println(count(valid2.(passports)))
