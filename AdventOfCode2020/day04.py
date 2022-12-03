from itertools import chain


required_fields = [
    "byr",  # Birth Year
    "ecl",  # Eye Color
    "eyr",  # Expiration Year
    "hcl",  # Hair Color
    "hgt",  # Height
    "iyr",  # Issue Year
    "pid"   # Passport ID
]


def new_passport(fields):

    p = dict()
    for field in chain(*fields):
       key, value = field.split(":")
       p[key] = value

    return p

def read_passports(filename):

   passports = []
   with open(filename) as f:
     
       fields  = list()
       for line in f:
           if line == '\n':
               passports.append(new_passport(fields))
               fields.clear()
           else:
               fields.append(line.strip().split())

       # end of the file, last passport
       passports.append(new_passport(fields))

   return passports

def valid1( p ) :

    valid_fields = sorted(filter(lambda k:(k != "cid"), p.keys()))
   
    if len(valid_fields) == 7:
        return all([u == v for u,v in zip(valid_fields,required_fields)])
    else:
        return False


eye_colors = ["amb","blu","brn","gry","grn","hzl","oth"]

def valid2( p ) :

    if valid1(p) :

        if not (1920 <= int(p["byr"]) <= 2002) : 
            return False
        if not (2010 <= int(p["iyr"]) <= 2020) : 
            return False
        if not (2020 <= int(p["eyr"]) <= 2030) : 
            return False
        hgt = p["hgt"]
        if hgt.endswith("cm"):
            if not (150 <= int(hgt[:-2]) <= 193) : 
                return False
        elif hgt.endswith("in"):
            if not (59 <= int(hgt[:-2]) <= 76) : 
                return False
        else:
            return False

        if not p["hcl"].startswith("#"): 
            return False

        try:
            hcl = int(p["hcl"][1:], base=16)
        except:
            return False
        if not p["ecl"] in eye_colors:
            return False
        if len(p["pid"]) != 9 :
            return False
        if not p["pid"].isdigit():
            return False

        return True

    else:
        return False


passports = read_passports( "input04.txt")
print(sum(map(valid1, passports)))
print(sum(map(valid2, passports)))
