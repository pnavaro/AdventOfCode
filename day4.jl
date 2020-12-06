
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

    valid_fields = collect(filter(k->(k!="cid"), keys(p)))
   
    if length(valid_fields) == 7
        for fields in valid_fields
            byr = parse(Int, p["byr"])
            iyr = parse(Int, p["iyr"])
            hgt = parse(Int, p["hgt"], base=16)
            hcl = parse(Int, p["hcl"][2:end], base=16)
            ecl = p["ecl"]
            pid = parse(Int, p["pid"])
        end
    else
        return false
    end

end

passports = read_passports( "input4.txt")
println(sum(valid1.(passports)))
