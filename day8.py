

actions = dict( nop = lambda i,x,p: (i+1, x), 
                acc = lambda i,x,p: (i+1, x+p),
                jmp = lambda i,x,p: (i+p, x) )


class BootCode:

    def __init__(self, filename):
    
        with open(filename) as f:
            self.instructions = [ line.split() for line in f]

        self.index = 0
        self.value = 0
        self.executed = [False] * len(self.instructions)

    def __iter__(self):
        return self

    def __next__(self):
        a, p = self.instructions[self.index]
        self.executed[self.index] = True
        self.index, self.value = actions[a]( self.index, self.value, int(p))
        if self.executed[self.index]:
            raise StopIteration 
        return self.value

    def positions(self):
        return map( lambda y:y[0], 
                    filter(lambda x:(x[1][0] in ["nop","jmp"]), 
                    enumerate(self.instructions)))

    def switch( self, position):

        if self.instructions[position][0] == "nop":
            self.instructions[position][0] = "jmp"
        else:
            self.instructions[position][0] = "nop"

        


code = BootCode("input8.txt")
for value in code:
    pass

print(f" Part 1 : {value}")

for position in code.positions():

    code = BootCode("input8.txt")
    code.switch(position)
    try:
        for value in code:
            pass
    except IndexError:
        print(f" Part 2 : {value}")
