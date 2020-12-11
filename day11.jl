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

function round!( seats )

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

seats = load("input11.txt")
while true
   if round!( seats)
       println(count(seats .== 2))
       break
  end
end

