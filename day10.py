builtin_joltage = lambda adapters:max(adapters) + 3

def load( filename ):
    with open(filename) as f:
        return list(map(int, f.readlines()))

def part1( puzzle ):
    adapt = [0] + puzzle +[builtin_joltage(puzzle)]
    adapt.sort()
    differences = []
    adapter = 0
    for x in adapt:
         possibles = [0 < a - adapter <= 3 for a in adapt]
         if any(possibles):
             new_adapter = adapt[possibles.index(True)]
             differences.append(new_adapter - adapter )
             adapter = new_adapter
         else:
             return sum(map(lambda x:x==1, differences))*sum(map(lambda x:x==3, differences))

# I found the solution with the help of this reference
# https://www.geeksforgeeks.org/count-possible-paths-source-destination-exactly-k-edges/

def part2(puzzle):

    adapt = [0] + puzzle +[builtin_joltage(puzzle)]

    n = len(adapt)

    graph = [[0 for j in range(n)] 
                for i in range(n)] 
    for i in range(n):
        for j in range(n):
            graph[i][j] = (0 < adapt[j] - adapt[i] <= 3)

    count =  [[[0 for k in range(n)]
                  for i in range(n)]
                  for j in range(n)]
 
    e = 0
    while e < n and adapt[e] < builtin_joltage(adapt):

        for i in range(n):
            for j in range(n):
                 
                if (e == 0 and i == j):
                    count[i][j][e] = 1
                if (e == 1 and graph[i][j]):
                    count[i][j][e] = 1
 
                if e > 1:
                    for k in range(n):
                        if graph[i][k]:
                            count[i][j][e] += count[k][j][e-1]
        e = e+1
 
    return sum(count[0][-1][:])
  

puzzle = load("input10.txt")
print(part1(puzzle))
puzzle = load("input10.txt")
print(part2(puzzle))
