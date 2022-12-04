filename = joinpath(@__DIR__, "input04.txt")


function ex1(filename)

     overlap = 0
     open(filename) do f
        for line in  eachline(f)
            task1, task2 = split(line, ",")
            begin1, end1 = parse.(Int, split(task1,"-"))
            begin2, end2 = parse.(Int, split(task2,"-"))
            if (begin1 >= begin2) && (end1 <= end2)
                overlap += 1
            elseif (begin2 >= begin1) && (end2 <= end1)
                overlap += 1
            end
        end
    end

    return overlap

end



function ex2(filename)

     overlap = 0
     open(filename) do f
        for line in  eachline(f)
            task1, task2 = split(line, ",")
            begin1, end1 = parse.(Int, split(task1,"-"))
            begin2, end2 = parse.(Int, split(task2,"-"))

            for i in begin1:end1
                if i in begin2:end2
                    overlap += 1
                    break
                end
            end
        end
    end

    return overlap

end

println(ex1(filename))
println(ex2(filename))
