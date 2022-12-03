filename = joinpath(@__DIR__, "input02.txt")


function strategy1( p1, p2 )

    score = first(p2) - 'W'
    if ((p2 == "X" && p1 == "A")|(p2 == "Y" && p1 == "B")|(p2 == "Z" && p1 == "C"))
        return score + 3
    else
        return score + 6 * ((p2 == "X" && p1 == "C")|(p2 == "Z" && p1 == "B")|(p2 == "Y" && p1 == "A"))
    end

end

function ex1(filename)

    score = 0
    open(filename) do f
         for line in eachline(f)
             p1, p2 = split(line)
             score += strategy1(p1, p2)
         end
    end
    return score

end

function strategy2( p1, p2 )

    offset = first(p1) - 'A'
    shift = mod(first(p2) - 'X' + 2, 3)
    play = 'X' + mod(offset+shift,3)

    return strategy1(p1, string(play))

end

function ex2(filename)

    score = 0
    open(filename) do f
         for line in eachline(f)
             p1, p2 = split(line)
             score += strategy2(p1, p2)
         end
    end
    return score

end

println(ex1(filename))
println(ex2(filename))
