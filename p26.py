# Long division
import sys

t = 0
answer = 0
for denom in xrange(2,1000):
    r = 1
    i = 0
    rs = []
    while r != 0 and r not in rs:
        rs.append(r)
        top = r * 10
        p = top / denom
        r = top - (denom * p)
        i += 1
        sys.stdout.write(str(p))
        if i > t:
            t = i
            answer = denom
    if r in rs:
        print " ", i - rs.index(r)
        continue
    print
print answer, t
