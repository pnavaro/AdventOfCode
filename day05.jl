function read_boarding_passes( filename )

    open(filename) do f
        return readlines(f)
    end

end

function row( 🎫 )

    front, back = 0, 127
    for c in first(🎫,7)
        half = (back-front)÷2+1
        if c == 'F'
           back  -= half
        else
           front += half
        end
    end

    return min(front, back)

end

function column( 🎫 )

    left, right = 0, 7
    for c in last(🎫,3)
        half = (right-left)÷2+1
        if c == 'L'
           right -= half
        else
           left += half
        end
    end

    return max(right, left)

end

seat_id( 🎫 ) = 8 * row(🎫) + column(🎫) 

function seat_position( seat_id )

    seat_id ÷ 8, seat_id % 8

end

tickets = read_boarding_passes( "input05.txt")
println(maximum(seat_id.(tickets)))
seats = sort(seat_id.(tickets))
position = findfirst(seats[2:end] .- seats[1:end-1] .== 2)
println(seats[position]+1)
