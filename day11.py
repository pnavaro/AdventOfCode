import copy

def load( filename ):

    trans = { ".":0, "L":1,"#":2}

    with open(filename) as f:

        data = []
        for line in f:
           line = line.replace(".","0" )
           line = line.replace("L","1" )
           line = line.replace("#","2" )
           line = list(line.strip())
           data.append(list(map(int, line)))

        m, n = len(data), len(data[0])
        seats = [[0 for j in range(n+2)] for i in range(m+2)]
        for i in range(m):
           for j in range(n):
                seats[i+1][j+1] = data[i][j]

        return seats

def adj( x, dx,  y, dy, seats ):

    adj = [seats[x+dx][ y-dy],
           seats[x+dx][ y   ], 
           seats[x+dx][ y+dy],
           seats[x   ][ y-dy], 
           seats[x   ][ y+dy], 
           seats[x-dx][ y-dy], 
           seats[x-dx][ y   ], 
           seats[x-dx][ y+dy]]
    
    return adj

state = ['.', 'L', '#']

def round1( seats ):

    m, n = len(seats), len(seats[0])
    old = copy.deepcopy(seats)
    state = True
    for i in range(1,m-1):
        for j in range(1, n-1):
            if old[i][j] == 1 and all(a<2 for a in adj(i,1,j,1,old)):
                seats[i][j] = 2
                state = False
            if old[i][j] == 2 and sum(a==2 for a in adj(i,1,j,1,old)) >= 4:
                seats[i][j] = 1
                state = False
    return state

#def get_seat( seats, c ) :
#
#    if seats[i][j] == 1: return False
#    if seats[i][j] == 2: return True
#
#    return False
#
#def visible_seats( i, j, seats)
#
#    for a in adj( i, 1, j, 1, seats)
#
#
#def round2( seats ):
#
#    m, n = size(seats)
#    old = copy.deepcopy(seats)
#    state = True
#    for i in 2:m-1:
#        for j in 2:n-1:
#            if old[i][j] == 1 and all(visible_seats(i,j, old)):
#                seats[i][j] = 2
#                state = False
#            if old[i][j] == 2 and sum(visible_seats(i,j, old)) >= 5:
#                seats[i][j] = 1
#                state = False
#    state

   
seats = load("input11.txt")
while True:
   if round1(seats):
       s = 0
       for row in seats:
           s += sum(c == 2 for c in row)
       print(s)
       break

#seats = load("input11.txt")
#while true
#   if round2!( seats)
#       println(count(seats .== 2))
#       break
#  end
#end
