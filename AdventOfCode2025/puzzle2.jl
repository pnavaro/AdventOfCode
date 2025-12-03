inputs = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"


function invalid1(id)
    s = string(id)
    n = length(s)
    if n % 2 == 0
        return s[1:n÷2] == s[n÷2+1:end]
    else
        return false
    end
end

function invalid2(id)
    s = string(id)
    n = length(s)
    for i in 1:n÷2
        if length(unique(Iterators.partition(s, i))) == 1
            return true
        end
    end
    return false
end

function puzzle(inputs, invalid_function)
    result = 0
    for id_range in split(inputs, ",")
        first_id, last_id = parse.(Int,split(id_range, "-"))
        ids = first_id:last_id
        result += sum(filter(invalid_function,ids))
    end
    
    return result
end

inputs = readline(open("puzzle2.txt"))
println(puzzle(inputs, invalid1))
println(puzzle(inputs, invalid2))


