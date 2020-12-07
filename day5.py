
def read_boarding_passes( filename ):

    with open(filename) as f:
        return list(map(str.strip, f.readlines()))


def row( ticket ):

    front, back = 0, 127
    for c in ticket[:7]:
        half = (back-front)//2+1
        if c == 'F':
           back  -= half
        else:
           front += half

    return min(front,back)

def column( ticket ):

    left, right = 0, 7
    for c in ticket[-3:]:
        half = (right-left)//2+1
        if c == 'L':
           right -= half
        else:
           left += half

    return max(left, right)

seat_id = lambda ticket:  8 * row(ticket) + column(ticket) 

def find_myseat( tickets) :
    seats = sorted(list(map(seat_id, tickets )))
    for seat1, seat2 in zip(seats[:-1], seats[1:]):
        if seat2 - seat1 > 1:
            return seat1+1

for ticket in ["BFFFBBFRRR", "FFFBBBFRRR", "BBFFBBFRLL"]:
    print( f"{ticket} : row {row(ticket)}, column {column(ticket)}, seat ID {seat_id(ticket)}.")

print("""
BFFFBBFRRR : row 70, column 7, seat ID 567.
FFFBBBFRRR : row 14, column 7, seat ID 119.
BBFFBBFRLL : row 102, column 4, seat ID 820.
""")

tickets = read_boarding_passes( "input5.txt")
print(max(map(seat_id, tickets)))
print(find_myseat( tickets))


