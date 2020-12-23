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

function part2(departs)

    bus_ids = split(departs,",")
    
    res = Tuple{Int,Int}[]
    for (minute,bus_id) in enumerate(bus_ids)
        if !occursin( "x", bus_id) 
            push!(res, (parse(Int,bus_id),minute-1))
        end
    end

    timestamp = 0
    while !check(timestamp, res)
        timestamp += 1
    end

    println(timestamp)
    return timestamp

end


println(part1())
_, departs = readlines("input_example.txt")
@assert part2(departs) == 1068781
@assert part2("17,x,13,19") == 3417
@assert part2("67,7,59,61") == 754018
@assert part2("67,x,7,59,61") == 779210
@assert part2("67,7,x,59,61") == 1261476
@assert part2("1789,37,47,1889") == 1202161486
