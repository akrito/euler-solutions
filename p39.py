from collections import defaultdict
from math import sqrt
ps = defaultdict(int)

# c > a and c > b, since c is the hyp
# a can't be over a third of p, since b >= a, c > a and a + b + c = p
for a in xrange(1, 1000 / 3):
    # we know a <= b
    for b in xrange(a, (1000 - a) / 2):
        c = sqrt(a**2 + b**2)
        if c == int(c):
            ps[a + b + c] += 1

bestP = 0
mostAnswers = 0
for k, v in ps.iteritems():
    if v > mostAnswers:
        mostAnswers = v
        bestP = k
print int(bestP)
