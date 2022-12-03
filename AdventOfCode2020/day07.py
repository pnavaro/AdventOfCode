def load_data(filename):

    with open(filename) as f:
        bags = dict()
        for line in f:
            bins = [',', '.', 'bags', 'bag', 'no other']
            for b in bins:
                line = line.replace(b, '')
                line = line.strip()
            color, contain = line.split("contain")
            loads = []
            contain = contain.split()
            i = 0
            while i < len(contain): 
                 n = int(contain[i])
                 i += 1
                 c1 = contain[i]
                 i += 1
                 c2 = contain[i]
                 i += 1
                 loads += [f"{c1} {c2}" for j in range(n)]
            color = color.strip()
            bags[color] = loads
        return bags

def hold_shiny_gold( color, bags ):

    if "shiny gold" in bags[color]:
        return True
    elif len(bags[color]) > 0:
        return any(hold_shiny_gold( c, bags ) for c in set(bags[color]))
    else:
        return False

def contained_bags( color, bags, n):

    if len(bags[color]) == 0:
        return n
    else:
        s = len(bags[color])
        for c in bags[color]:
           s += contained_bags(c, bags, n)
        return s

bags = load_data("input07.txt")
print(sum([hold_shiny_gold(c, bags) for c in bags.keys()]))
print(contained_bags( "shiny gold", bags, 0))
