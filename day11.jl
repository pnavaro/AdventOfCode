function load( filename )

    open(filename) do f

        data = readlines(f)
        data = map(line -> (map( x->(x=='L'), collect(line))), data)
        data = Int.(vcat(data'...))
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

function round!( seats )

    m, n = size(seats)
    old = copy(seats)
    state = false
    for i in 2:m-1, j in 2:n-1
        if old[i,j] == 1 && all(adjacents(i,j, old) .< 2)
            seats[i,j] = 2
            state = true
        end
        if old[i,j] == 2 && count(adjacents(i,j, old) .== 2) >= 4
            seats[i,j] = 1
            state = true
        end
    end
    state
end
#    for i in 1:size(seats)[1], j in 1:size(seats)[2]
#        if seats[i,j] == 2 && count(seats[adjacents(i,j,seats)] .==2) >= 4
#            seats[i,j] == 1
#        end
#    end

seats = load("input11.txt")

while round!( seats)
   println(count(seats .== 2))
end
