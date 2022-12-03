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

function check( timestamp, departs ) 

   for (bus_id,t) in departs
      if (timestamp+t) % bus_id !== 0
         return false
      end
   end
   return true
end

# Three days to find the solution
# This page helps me https://www.geeksforgeeks.org/chinese-remainder-theorem-set-1-introduction/

function part2(departs)

    bus_ids = split(departs,",")
    
    departs = Tuple{Int,Int}[]
    for (minute,bus_id) in enumerate(bus_ids)
        if !occursin( "x", bus_id) 
            push!(departs, (parse(Int,bus_id),minute-1))
        end
    end

    timestamp = 1
    increment = timestamp

    for (bus, offset) in departs
        while (timestamp + offset) % bus != 0
            timestamp += increment
        end
        increment = lcm(increment, bus)
    end

    return timestamp

end


println(part1())
@assert part2("17,x,13,19") == 3417
@assert part2("67,7,59,61") == 754018
@assert part2("67,x,7,59,61") == 779210
@assert part2("7,13,x,x,59,x,31,19") == 1068781
@assert part2("67,7,x,59,61") == 1261476
@time @assert part2(1, "1789,37,47,1889") == 1202161486
_, departs = readlines("input13.txt")
@time println(part2(departs))
