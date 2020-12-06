import Base.Iterators:product

function read_puzzle()

    open("day1/input.txt") do f
         return parse.(Int, readlines(f))
    end

end

function ex1( puzzle )
    for item in product(puzzle,puzzle)
        if length(unique(item)) == 2
            sum(item) == 2020  && return prod(item)
        end
    end
end

function ex2( puzzle )
    for item in product(puzzle, puzzle, puzzle)
        if length(unique(item)) == 3
            sum(item) == 2020 && return prod(item)
        end
    end
end

puzzle = read_puzzle()
println(ex1(puzzle))
println(ex2(puzzle))
