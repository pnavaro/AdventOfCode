function read_answers( filename )

    answers = Vector{String}[]
    open(filename) do f
        batch = String[]
        for line in readlines(f)
            if isempty(line)
                push!(answers, batch)
                batch = String[]
            else
                push!(batch, line)
            end
        end
        push!(answers, batch)
    end
    return answers

end

function counts_1( answers )

    return sum(length.(unique.(join.(answers))))

end

function counts_2( answers )
 
    res = 0
    for group in answers, c in 'a':'z'
        res += all([ c in ans for ans in group])
    end
    return res

end


answers = read_answers( "input6.txt" )
println(counts_1( answers ))
println(counts_2( answers ))
