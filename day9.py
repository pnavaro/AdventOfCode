from collections import deque

def load( filename ):

    with open(filename) as f:
        return [int(x) for x in f]

def check( numbers, item ):

    for i, n1 in enumerate(numbers[:-1]):
        for n2 in numbers[i+1:]:
            if n1 + n2 == item : return True
    return False

def part1(puzzle, preamble):
    numbers = load(puzzle)
    size = len(numbers)
    previous_numbers = numbers[:preamble]
    index = preamble
    while index < size:
        item = numbers[index]
        previous_numbers = numbers[index-preamble:index]
        if not check(previous_numbers, item):
            return item
        else:
            index += 1

def part2(puzzle, preamble):

    numbers = load(puzzle)
    size = len(numbers)
    invalid = part1(puzzle, preamble)
    roll = deque(numbers[:2])
    s = sum(roll)
    index = 2
    while s != invalid and index < size:
        if s < invalid:
           roll.append(numbers[index])
           index += 1
        elif s > invalid:
           roll.popleft()
        s = sum(roll)

    return max(roll) + min(roll)
    
print(part1("input9.txt", 25))
print(part2("input9.txt", 25))
