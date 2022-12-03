function load( filename )

    trans = Dict( "."=>0, "L"=>1,"#"=>2)

    open(filename) do f

        data = []
        for line in readlines(f)
           line = replace(line, "."=> "0" )
           line = replace(line, "L"=> "1" )
           line = replace(line, "#"=> "2" )
           push!(data, parse.(Int, collect(line)))
        end
        data = vcat(data'...)
        m, n = size(data)
        seats = zeros(Int, m+2, n+2)
        seats[2:m+1,2:n+1] .= data
        return seats

    end


end

function adjacents( i, j, seats )

    adjacents = [seats[i+1,j-1],
                 seats[i+1,j  ], 
                 seats[i+1,j+1],
                 seats[i  ,j-1], 
                 seats[i  ,j+1], 
                 seats[i-1,j-1], 
                 seats[i-1,j  ], 
                 seats[i-1,j+1]]
    
    adjacents
end

state = Dict( 0=>'.', 1=>'L', 2=>'#')

function plot( seats )

    m, n = size(seats)
    for i in 2:size(seats)[1]-1
        for j in 2:size(seats)[2]-1
            print(state[seats[i,j]])
        end
        println()
     end
     println()
end

function round1!( seats )

    m, n = size(seats)
    old = copy(seats)
    state = true
    for i in 2:m-1, j in 2:n-1
        if old[i,j] == 1 && all(adjacents(i,j, old) .< 2)
            seats[i,j] = 2
            state = false
        end
        if old[i,j] == 2 && count(adjacents(i,j, old) .== 2) >= 4
            seats[i,j] = 1
            state = false
        end
    end
    state
end

function get_seat( seats, row, col) 

    for (i,j) in zip(row, col)
        seats[i,j] == 1 && return false
        seats[i,j] == 2 && return true
    end
    return false
end

function get_seat(seats)
    for s in seats
        s == 1 && return false
        s == 2 && return true
    end
    false
end

function visible_seats( k, l, seats)

   m,n = size(seats)

   res = [
   get_seat(seats[k-1:-1:1,l]),
   get_seat(seats[k+1:1:m,l]), 
   get_seat(seats[k,l-1:-1:1]), 
   get_seat(seats[k,l+1:n]), 
   get_seat(seats, k-1:-1:1+k-min(k,l), l-1:-1:1+l-min(k,l)), 
   get_seat(seats, k-1:-1:k-min(k-1,n-l), l+1:1:l+min(k-1,n-l)), 
   get_seat(seats, k+1:1:min(m-k,n-l)+k, l+1:1:min(m-k,n-l)+l), 
   get_seat(seats, k+1:1:k+min(m-k,l-1), l-1:-1:l-min(m-k,l-1))]

   res
end

function round2!( seats )

    m, n = size(seats)
    old = copy(seats)
    state = true
    for i in 2:m-1, j in 2:n-1
        if old[i,j] == 1 && all(.!(visible_seats(i,j, old)))
            seats[i,j] = 2
            state = false
        end
        if old[i,j] == 2 && count(visible_seats(i,j, old)) >= 5
            seats[i,j] = 1
            state = false
        end
    end
    state
end

   
seats = load("input11.txt")
while true
   if round1!( seats)
       println(count(seats .== 2))
       break
  end
end

seats = load("input11.txt")
while true
   if round2!( seats)
       println(count(seats .== 2))
       break
  end
end
