import Base.Iterators: product

function read_puzzle(filename)

    return open(filename) do f
        return parse.(Int, readlines(f))
    end

end

function ex1(puzzle)
    for item in product(puzzle, puzzle)
        if length(unique(item)) == 2
            sum(item) == 2020  && return prod(item)
        end
    end
    return
end

function ex2(puzzle)
    for item in product(puzzle, puzzle, puzzle)
        if length(unique(item)) == 3
            sum(item) == 2020 && return prod(item)
        end
    end
    return
end

puzzle = read_puzzle("input01.txt")
println(ex1(puzzle))
println(ex2(puzzle))
