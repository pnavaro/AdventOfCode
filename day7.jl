import Base.Iterators:partition

function load_data(filename)

    open(filename) do f
        bags = Dict{AbstractString,Vector{AbstractString}}()
        for line in readlines(f)
            line = strip(replace(line, [',','.'] => ""))
            line = strip(replace(line, "bags" => ""))
            line = strip(replace(line, "bag" => ""))
            line = strip(replace(line, "no other" => ""))
            color, contain = split(strip(line),"contain")
            loads = String[]
            for x in partition(split(contain), 3)
                n , c1, c2 = x
                for i in 1:parse(Int, n)
                    push!(loads,string(c1," ",c2))
                end
            end
            println(color, loads)
            @show typeof(strip(color))
            bags[strip(color)] = loads
        end
        return bags
    end

end

function hold_shiny_gold( color, bags )

    if "shiny bag" in bags[color]
       return true
    elseif length(bags[color]) > 0
       return any([hold_shiny_gold( c, bags ) for c in unique(bags[color])])
    else
       false
    end

end

bags = load_data("input_example.txt")
println(bags)
println(count([hold_shiny_gold(c, bags) for c in keys(bags)]))
