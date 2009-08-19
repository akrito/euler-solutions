from collections import defaultdict

height = 100
tris = open("triangle.txt").readlines()

# Populate the matrix
ts = defaultdict(int)
_l = 0
for l in tris:
    _c = 0
    for c in l.split():
        ts[(_l, _c)] = int(c)
        _c += 1
    _l += 1

bests = defaultdict(int)
bests[(0, 0)] = ts[(0, 0)]

t = 0
for i in xrange(1, height):
    for j in xrange(0, i + 1):
        # Find the best total from the row above
        p = bests[(i-1, j-1)]
        q = bests[(i-1, j)]
        m = max(p, q)
        bests[(i, j)] = ts[(i, j)] + m
        _t = bests[(i, j)]
        if _t > t:
            t = _t
print t

