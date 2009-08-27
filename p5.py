from math import sqrt
from collections import defaultdict

# Factor x:
# starting with 2, find a number that divides x.
# return that number with the others

def factors(x):
    for i in xrange(2, int(sqrt(x) + 1)):
        if x % i == 0:
            return [i] + factors(x / i)
    return [x]

factor_count = defaultdict(int)

for i in range(2, 21):
    new_count = defaultdict(int)
    for f in factors(i):
        new_count[f] += 1
        factor_count[f] = max(factor_count[f], new_count[f])

product = 1
for k, v in factor_count.iteritems():
    print k * v
    product *= pow(k,v)
print product
