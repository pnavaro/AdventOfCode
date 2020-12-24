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

function part2(start, departs)

    bus_ids = split(departs,",")
    
    departs = Tuple{Int,Int}[]
    for (minute,bus_id) in enumerate(bus_ids)
        if !occursin( "x", bus_id) 
            push!(departs, (parse(Int,bus_id),minute-1))
        end
    end

    # # Brute force solution
    # timestamp = 0
    # while !check(timestamp, res)
    #     timestamp += 1
    # end
    sort!(departs)
    reverse!(departs)

    flag = true
    buf_size = 10000
    buffer = copy(departs)
    while true

        flag, res = check( start:(start+buf_size), buffer)
        if flag 
           return res
        end
        start += buf_size
        buffer = copy(departs)

    end


end

# brute force
function check( timestamp, departs)
    for (bus_id, t) in departs
        if (timestamp+t) % bus_id !== 0
            return false
        end
    end
    return true
end

function check( timestamps, departs )
    
    bus_id, t = popfirst!(departs)
    res = filter( x -> ((x+t) % bus_id == 0), timestamps)

    if length(res) == 0 
       return (false, res)
    end

    if length(departs) == 0
       println(res[1])
       return true, res[1]
    else
       return check( res, departs)
    end
       
end


println(part1())
@assert part2(1, "17,x,13,19") == 3417
@assert part2(1, "67,7,59,61") == 754018
@assert part2(1, "67,x,7,59,61") == 779210
@assert part2(1, "7,13,x,x,59,x,31,19") == 1068781
@assert part2(1, "67,7,x,59,61") == 1261476
@assert part2(1, "1789,37,47,1889") == 1202161486
_, departs = readlines("input13.txt")
@time println(part2(100000000000000, departs))
