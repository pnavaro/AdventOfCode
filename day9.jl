import Base.Iterators
function load( filename )

    open(filename) do f
        return [parse(Int,x) for x in readlines(f)]
    end

end

function check( numbers, item )

    for (i, n1) in enumerate(numbers[1:end-1])
        for n2 in numbers[i+1:end]
	    n1 + n2 == item && ( return true )
        end
    end
    return false

end

function part1(puzzle, preamble)
    numbers = load(puzzle)
    size = length(numbers)
    index = preamble + 1
    
    while index < size
        item = numbers[index]
        previous_numbers = numbers[index-preamble:index-1]
        if !check(previous_numbers, item)
            return item
        else
            index += 1
        end
    end
end

println(part1("input9.txt", 25))
