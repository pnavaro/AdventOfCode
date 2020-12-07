from collections import namedtuple

Password = namedtuple("Password", "cmin cmax char, pawd")

def read_passwords(filename):

    passwords = []
    with open(filename) as f:
         for line in f:
             d1, d2, d3 = line.split()
             cmin, cmax  = list(map(int, d1.split("-")))
             char = d2[0]
             pawd = d3
             passwords.append(Password(cmin, cmax, char, pawd))
         return passwords

def check1(p):
     return p.cmin <= p.pawd.count(p.char) <= p.cmax

 
def check2(p):
     return (p.pawd[p.cmin-1] == p.char) ^ (p.pawd[p.cmax-1] == p.char)

passwords = read_passwords("input2.txt")
print(sum(map(check1, passwords)))
print(sum(map(check2, passwords)))
