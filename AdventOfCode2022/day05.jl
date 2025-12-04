input = joinpath(@__DIR__, "input05.txt")


function read_data(filename)

    open(filename) do f

       return readlines(f)

    end

end

moves = []
for line in read_data(input)

    if startswith(line, "move")
        col, src, dst = parse.(Int, split(line)[2:2:end])
        push!(moves, (col, src, dst))
    elseif startswith(line, "[")
        println(line)
    end

end

print(moves)
