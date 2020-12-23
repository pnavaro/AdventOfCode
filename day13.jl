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

function part2()

    line1, line2 = readlines("input_example.txt")
    timestamp = parse(Int, line1)
    bus_ids = split(line2,",")
    
    for (minute,bus_id) in enumerate(bus_ids)

        if !occursin( "x", bus_id) 
            println(" $bus_id  departs $(minute-1) after t ")
        end
    
    end

end


println(part1())
println(part2())
