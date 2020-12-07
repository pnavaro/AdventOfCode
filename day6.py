from string import ascii_lowercase as alphabet

def read_answers( filename ):

    answers = []
    with open(filename) as f:
        batch = []
        for line in f:
            if line == "\n":
                answers.append(batch)
                batch = []
            else:
                batch.append(line.strip())
        answers.append(batch)

    return answers

def counts_1( answers ):

    return sum(map(len,map(set,("".join(ans) for ans in answers))))


def counts_2( answers ):
 
    res = 0
    for group in answers:
        for c in alphabet:
            res += all([ c in ans for ans in group])

    return res


answers = read_answers( "input6.txt" )
print(counts_1( answers ))
print(counts_2( answers ))
