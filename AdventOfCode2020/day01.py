from itertools import combinations
from math import prod

def read_puzzle(filename):
    with open(filename) as f:
         return list(map(int, f.readlines()))

def ex1( puzzle ):
    for item in combinations(puzzle, 2):
        if sum(item) == 2020:
            return prod(item)

def ex2( puzzle ):
    for item in combinations(puzzle, 3):
        if sum(item) == 2020: 
            return prod(item)

puzzle = read_puzzle("input01.txt")
print(ex1(puzzle))
print(ex2(puzzle))
