struct Password

    cmin :: Int
    cmax :: Int
    char :: Char
    pass :: String

end

function read_passwords(filename)

    passwords = Password[]
    open(filename) do f
         for line in eachline(f)
             data = split(line)
             cmin, cmax  = parse.(Int, split(data[1],"-"))
             char = first(data[2])
             pass = data[3]
             push!(passwords, Password(cmin, cmax, char, pass))
         end
         return passwords
    end

end

function check1(p) 
    p.cmin <= count(c->(c==p.char), p.pass) <= p.cmax
end


function check2(p) 
    ans = ((p.pass[p.cmin] == p.char && p.pass[p.cmax] != p.char) ||
          (p.pass[p.cmin] != p.char && p.pass[p.cmax] == p.char) )
    return ans
end

passwords = read_passwords("input2.txt")
println(sum(check1.(passwords)))
println(sum(check2.(passwords)))
