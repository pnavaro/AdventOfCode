function part1()

    line1, line2 = readlines("input13.txt")
    timestamp = parse(Int, line1)
    bus_ids = parse.(Int, filter( x-> !occursin("x",x), split(line2,",")))
    
    flag = true
    wait = 0
    
    while flag
        for bus_id in bus_ids
            if (timestamp+wait) % bus_id == 0
                return wait * bus_id
            end
        end
        wait += 1
    end
       
end

check( timestamp, departs ) = all( [ (timestamp+t) % bus_id == 0 for (bus_id,t) in departs])

function part2()

    line1, line2 = readlines("input_example.txt")
    timestamp = parse(Int, line1)
    bus_ids = split(line2,",")
    
    res = Tuple{Int,Int}[]
    for (minute,bus_id) in enumerate(bus_ids)
        if !occursin( "x", bus_id) 
            push!(res, (parse(Int,bus_id),minute-1))
        end
    end
    return res

end


println(part1())
println(part2())
