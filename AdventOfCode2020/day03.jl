function read_trees(filename)

    return open(filename) do f
        data = readlines(f)
        return transpose(map(x -> (x == '#'), hcat(collect.(data)...)))
    end

end

function hit_count(trees, down, right)
    nrow, ncol = size(trees)
    hit = 0
    j = 1
    for i in 1:down:nrow
        hit += trees[i, j]
        j = mod1(j + right, ncol)
    end
    return hit
end


trees = read_trees("input03.txt")
println(hit_count(trees, 1, 3))
println(
    hit_count(trees, 1, 1) *
        hit_count(trees, 1, 3) *
        hit_count(trees, 1, 5) *
        hit_count(trees, 1, 7) *
        hit_count(trees, 2, 1)
)
