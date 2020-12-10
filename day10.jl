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

puzzle = load("input10.txt")
println(prod(part1(puzzle)))
    
