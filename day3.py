def read_trees(filename):

    with open(filename) as f:
        data = f.readlines()
        return list(map(lambda x:list(x.strip()), data ))


def hit_count(trees, down, right):
    nrow = len(trees)
    hits = 0
    i, j = 0, 0
    while i < len(trees):
        hits += trees[i][j] == "#"
        j = (j+right) % len(trees[i])
        i += down

    return hits


trees = read_trees("input3.txt")

print(hit_count(trees, 1, 3))
print(hit_count(trees, 1, 1) * 
      hit_count(trees, 1, 3) * 
      hit_count(trees, 1, 5) * 
      hit_count(trees, 1, 7) * 
      hit_count(trees, 2, 1) ) 
