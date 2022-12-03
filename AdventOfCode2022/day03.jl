
priority(c) = islowercase(c) ?  c - 'a' + 1 : c - 'A' + 27

function ex1(filename)

    data = Char[]

    open(filename) do f
        for line in  eachline(f)
            mid = length(line) ÷ 2
            push!(data, intersect(line[begin:mid], line[mid+1:end])...)
        end
    end

    return sum(priority.(data))

end

function ex2(filename)

    data = Char[]

    open(filename) do f
        for lines in  Iterators.partition(readlines(f), 3)
            push!(data, intersect(lines...)...)
        end
    end

    return sum(priority.(data))

end

filename = joinpath(@__DIR__, "input03.txt")

println(ex1(filename))
println(ex2(filename))
