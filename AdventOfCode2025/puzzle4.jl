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


function accessible(puzzle, i, j)
    m = length(puzzle)
    n = length(puzzle[1])
    @assert puzzle[i][j] == '@'
    @assert all(length(row) == n for row in puzzle)
    roll = 0
    offsets = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
    for (di, dj) in offsets
        ni, nj = i + di, j + dj
        if 1 <= ni <= m && 1 <= nj <= n
            roll += puzzle[ni][nj] == '@'
            roll == 4 && return false
        end
    end
    return true
end

function part_one(puzzle)
    k = 0
    for (i, row) in enumerate(puzzle), (j, ch) in enumerate(row)
        if ch == '@'
            k += accessible(puzzle, i, j)
        end
    end
    return k
end

println("test = $(part_one(puzzle))")

puzzle = readlines(open("puzzle4.txt"))

println("part one = $(part_one(puzzle))")
