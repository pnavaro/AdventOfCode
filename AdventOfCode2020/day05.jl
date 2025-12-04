function read_boarding_passes(filename)

    return open(filename) do f
        return readlines(f)
    end

end

tickets = read_boarding_passes("input05.txt")
tickets .= replace.(tickets, r"[RB]" => "1")
tickets .= replace.(tickets, r"[FL]" => "0")
seat_id = parse.(Int, tickets, base = 2)

println(maximum(seat_id))
seat = setdiff(minimum(seat_id):maximum(seat_id), seat_id)
println(seat)
