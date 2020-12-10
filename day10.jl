builtin_joltage( adapters ) = maximum(adapters) + 3

function load( filename )
    open(filename) do f
        return parse.(Int, readlines(f))
    end
end

function part1( puzzle )
    test = vcat(0, puzzle..., builtin_joltage( puzzle ) )
    sort!(test)
    differences = []
    adapter = 0
    for x in  enumerate(test)
         possibles = 0 .< test .- adapter .<= 3
         if any(possibles)
             new_adapter = test[findfirst(possibles)]
             push!(differences, new_adapter - adapter )
             adapter = new_adapter
         else
             return count(==(1), differences), count(==(3), differences)
         end
    end
end

function part2( puzzle )

    function count_path( current_adapter, adapters)
        
        possibles = 0 .< adapters .- current_adapter .<= 3
        
        if any(possibles)
            for adapter in adapters[possibles]
                count_path( adapter, adapters)
            end
        else
            count += 1
        end
    end

    adapters = vcat(0, puzzle...)
    sort!(adapters)
    count = 0
    count_path( 0, adapters)

    return count

end


function count_arrangements(puzzle)

    adapt = vcat(0, puzzle...)

    n = length(adapt)

    edges = 0
    for i in 1:n 
        for j in  1:i
            edges += count( 0 < adapt[i] - adapt[j] <= 3)
        end
    end
  
    return edges
  
end

puzzle = load("input10.txt")
println(prod(part1(puzzle)))

test1 = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]
println(count_arrangements(test1))
puzzle = load("input_example.txt")
println(count_arrangements(puzzle))
