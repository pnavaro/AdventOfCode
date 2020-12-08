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
            bags[strip(color)] = loads
        end
        return bags
    end

end

function hold_shiny_gold( color, bags )

    if "shiny gold" in bags[color]
       return true
    elseif length(bags[color]) > 0
       return any([hold_shiny_gold( c, bags ) for c in unique(bags[color])])
    else
	   return false
    end

end

function contained_bags( color, bags, n)

    if length(bags[color]) == 0
        return n
    else
        s = length(bags[color])
        for c in bags[color]
           s += contained_bags(c, bags, n)
        end
        return s
    end


end

bags = load_data("input7.txt")
println(count([hold_shiny_gold(c, bags) for c in keys(bags)]))
println(contained_bags( "shiny gold", bags, 0))
