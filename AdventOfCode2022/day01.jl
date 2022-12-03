import Base.Iterators:product


filename = "input01.txt"

function ex1()

    calories = 0
    calories_max = 0

    open(filename) do f
    
        for line in readlines(f)
            if length(line) == 0
                calories_max = max(calories_max, calories)
                calories = 0
            else
                calories += parse(Int, line)
            end
        end
    end

    return max(calories, calories_max)

end

function podium!(calories_max, calories)
    if calories > last(calories_max)
        pop!(calories_max)
        push!(calories_max, calories)
        sort!(calories_max, rev = true)
    end
    println(calories_max)
end

function ex2()

    calories = 0
    calories_max = zeros(Int, 3)

    open(filename) do f
    
        for line in readlines(f)
            if length(line) == 0
                podium!(calories_max, calories)
                calories = 0
            else
                calories += parse(Int, line)
            end
            println(calories)
        end
    end
    podium!(calories_max, calories)

    return sum(calories_max)

end

println(ex1())

println(ex2())
