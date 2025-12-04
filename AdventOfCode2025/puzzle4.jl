puzzle = [
    "..@@.@@@@.",
    "@@@.@.@.@@",
    "@@@@@.@.@@",
    "@.@@@@..@.",
    "@@.@@@@.@@",
    ".@@@@@@@.@",
    ".@.@.@.@@@",
    "@.@@@.@@@@",
    ".@@@@@@@@.",
    "@.@.@@@.@.",
]


function accessible(mat, i, j)
    m, n = size(mat)

    mat[i, j] == "@"  || return false

    roll = 0
    offsets = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
    for (di, dj) in offsets
        ni, nj = i + di, j + dj
        if 1 <= ni <= m && 1 <= nj <= n
            roll += mat[ni, nj] == "@"
            roll == 4 && return false
        end
    end
    return true
end

function part_one(puzzle)

    mat = stack(split.(puzzle, ""))
    k = 0
    for i in axes(mat, 1), j in axes(mat, 2)
        k += accessible(mat, i, j)
    end
    return k
end

function part_two(puzzle)
    mat = stack(split.(puzzle, ""))
    k_old, k_new = -1, 0
    while k_new > k_old
        k_old = k_new
        for i in axes(mat, 1), j in axes(mat, 2)
            if accessible(mat, i, j)
                mat[i, j] = "."
                k_new += 1
            end
        end
    end
    return k_new
end


println("test part one = $(part_one(puzzle))")
println("test part two = $(part_two(puzzle))")

puzzle = readlines(open("puzzle4.txt"))

println("part one = $(part_one(puzzle))")
println("part two = $(part_two(puzzle))")
