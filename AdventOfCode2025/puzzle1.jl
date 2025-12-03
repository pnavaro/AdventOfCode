inputs = ["L68", "L30", "R48", "L5", "R60", "L55", "L1", "L99", "R14", "L82"]

println("The dial starts by pointing at 50.")

function password1(inputs)

    position = 50
    k = 0
    for move in inputs
    
        d, clicks = move[1] , parse(Int, move[2:end])
        if d == 'L'
            position -= clicks
        else
            position += clicks
        end

        position = mod(position, 100)
        k += position == 0
        println("The dial is rotated $move to point at $position.")
    end

    return k
end

println(password1(inputs))

# The dial is rotated L68 to point at 82.
# The dial is rotated L30 to point at 52.
# The dial is rotated R48 to point at 0.
# The dial is rotated L5 to point at 95.
# The dial is rotated R60 to point at 55.
# The dial is rotated L55 to point at 0.
# The dial is rotated L1 to point at 99.
# The dial is rotated L99 to point at 0.
# The dial is rotated R14 to point at 14.
# The dial is rotated L82 to point at 32.

position = 50

println(password1(readlines(open("puzzle1.txt"))))

function password2(inputs)

    position = 50

    k = 0
    
    for move in inputs
    
        d, clicks = move[1] , parse(Int, move[2:end])

        for i in 1:clicks
            if d == 'L'
                position = mod(position-1, 100)
            else
                position = mod(position+1, 100)
            end

            k += position == 0

        end
    end

    return k
end

println(password2(inputs))

println(password2(readlines(open("puzzle1.txt"))))
