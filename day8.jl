const actions = Dict( "nop" => (i,x,p) -> (i+1, x), 
                      "acc" => (i,x,p) -> (i+1, x+p),
                      "jmp" => (i,x,p) -> (i+p, x) )

function bootcode( filename )
    open(filename) do f
        return split.(readlines(f))
    end
end

function get_value!(instructions, executed, index, value)
    a, p = instructions[index]
    executed[index] = true
    index, value = actions[a]( index, value, parse(Int,p))
    if index > length(instructions) 
        return nothing, value
    elseif executed[index]
        return index, nothing
    else
        return index, value
    end
end

function run_code( instructions )

    index = 1
    value = 0
    executed = [false for i in eachindex(instructions)]
    while true
        last_value = value
        index, value = get_value!(instructions, executed, index, value)
        index == nothing && ( return value, true )
        value == nothing && ( return last_value, false)
    end

end

function switch( instructions, position )

    action = instructions[position][1] 
    new_instructions = [ copy(x) for x in instructions]

    if action == "nop"
        new_instructions[position][1] = "jmp"
    elseif action == "jmp"
        new_instructions[position][1] = "nop"
    end
    return new_instructions

end

instructions = bootcode("input8.txt")

println(" Part 1 : ", first(run_code( instructions)))
positions = findall( a -> ( a[1] in ["jmp","nop"]), instructions)

for position in positions
    new_instructions = switch(instructions, position)
    value, check = run_code(new_instructions)
    if check
       println(" Part 2 : ", value)
       break
    end
end
