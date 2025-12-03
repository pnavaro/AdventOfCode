banks = [
"987654321111111",
"811111111111119",
"234234234234278",
"818181911112111"
]

function joltage1(bank)

    s = parse.(Int, split(bank, ""))
    i = maximum(s)
    ii = findfirst(==(i), s)
    if ii == length(s)
        i, j = maximum(s[begin:end-1]), i
    else
        j = maximum(s[ii+1:end])
    end

    return 10i+j

end


function joltage2(bank)

    res = Int[]
    s = parse.(Int, split(bank, ""))
    for size in 11:-1:0
        n = length(s)
        if n + length(res) == 12
            push!(res, s...)
            break
        else
            number = maximum(s[begin:end-size])
            i = findfirst(==(number), s)
            push!(res, number)
            s = s[i+1:end]
        end
    end

    return parse(Int, prod(string.(res)))

end

println("test part 1 = $(joltage1.(banks))")
println("test part 2 = $(joltage2.(banks))")

banks = readlines(open("puzzle3.txt"))
    
println("part one = $(sum(joltage1.(banks)))")
println("part two = $(sum(joltage2.(banks)))")
