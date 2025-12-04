function load(filename)

    return open(filename) do f
        return [(x[1], parse(Int, join(x[2:end]))) for x in collect.(readlines(f))]
    end

end

mutable struct Ship

    d::Int
    x::Int
    y::Int

    Ship() = new(0, 0, 0)

end

function move!(ship, cmd)

    d, l = cmd

    return if d == 'N'
        ship.y += l
    elseif d == 'S'
        ship.y -= l
    elseif d == 'E'
        ship.x += l
    elseif d == 'W'
        ship.x -= l
    elseif d == 'L'
        ship.d += l
    elseif d == 'R'
        ship.d -= l
    elseif d == 'F'
        ship.x += round(Int, cos(ship.d * π / 180) * l)
        ship.y += round(Int, sin(ship.d * π / 180) * l)
    end

end

manhattan_distance(ship) = abs(ship.x) + abs(ship.y)

rotate(x, y, θ) = round.(
    Int, (
        x * cos(θ * π / 180) - y * sin(θ * π / 180),
        x * sin(θ * π / 180) + y * cos(θ * π / 180),
    )
)

function move!(ship, cmd, waipoint)

    d, l = cmd
    x, y = waypoint

    if d == 'N'
        y += l
    elseif d == 'S'
        y -= l
    elseif d == 'E'
        x += l
    elseif d == 'W'
        x -= l
    elseif d == 'L'
        x, y = rotate(x, y, l)
    elseif d == 'R'
        x, y = rotate(x, y, -l)
    elseif d == 'F'
        ship.x += l * x
        ship.y += l * y
    end

    return (x, y)

end

ship = Ship()
for cmd in load("input12.txt")
    move!(ship, cmd)
end
println(manhattan_distance(ship))

ship = Ship()
waypoint = (10, 1)
for cmd in load("input12.txt")
    global waypoint
    waypoint = move!(ship, cmd, waypoint)
end
println(manhattan_distance(ship))
