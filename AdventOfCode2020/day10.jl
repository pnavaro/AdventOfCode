builtin_joltage(adapters) = maximum(adapters) + 3

function load(filename)
    return open(filename) do f
        return parse.(Int, readlines(f))
    end
end

function part1(puzzle)
    adapt = vcat(0, puzzle..., builtin_joltage(puzzle))
    sort!(adapt)
    differences = []
    adapter = 0
    for x in adapt
        possibles = 0 .< adapt .- adapter .<= 3
        if any(possibles)
            new_adapter = adapt[findfirst(possibles)]
            push!(differences, new_adapter - adapter)
            adapter = new_adapter
        else
            return count(==(1), differences), count(==(3), differences)
        end
    end
    return
end

function part2(puzzle) # brute force is too exepensive

    function count_path(current_adapter, adapters)

        possibles = 0 .< adapters .- current_adapter .<= 3

        return if any(possibles)
            for adapter in adapters[possibles]
                count_path(adapter, adapters)
            end
        else
            count += 1
        end
    end

    adapters = vcat(0, puzzle...)
    sort!(adapters)
    count = 0
    count_path(0, adapters)

    return count

end

# I found the solution with the help of this reference
# https://www.geeksforgeeks.org/count-possible-paths-source-destination-exactly-k-edges/

function count_arrangements(puzzle)

    adapt = vcat(0, puzzle..., builtin_joltage(puzzle))

    n = length(adapt)

    graph = zeros(Bool, n, n)
    for i in 1:n, j in 1:n
        graph[i, j] = (0 < adapt[j] - adapt[i] <= 3)
    end

    count = zeros(Int, n, n, n)

    e = 1
    while e <= n && adapt[e] < builtin_joltage(adapt)

        for i in 1:n, j in 1:n

            if (e == 1 && i == j)
                count[i, j, e] = 1
            end
            if (e == 2 && graph[i, j])
                count[i, j, e] = 1
            end

            if e > 2
                for k in 1:n
                    if graph[i, k]
                        count[i, j, e] += count[k, j, e - 1]
                    end
                end
            end
        end
        e = e + 1

    end

    return sum(count[1, n, :])

end

puzzle = load("input10.txt")
println(prod(part1(puzzle)))
puzzle = load("input10.txt")
println(count_arrangements(puzzle))
