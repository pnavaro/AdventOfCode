def read_boarding_passes( filename ):

    with open(filename) as f:
        tickets = f.read()
        table = str.maketrans(dict(zip("FBLR","0101")))
        tickets = tickets.translate(table)
        return tickets.split()

tickets = read_boarding_passes( "input05.txt")
seat_ids = list(map( lambda x: int(x, base=2), tickets))
print(max(seat_ids))
print(set(range(min(seat_ids),max(seat_ids))) - set(seat_ids))
