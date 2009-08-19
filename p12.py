from math import sqrt

tri = 1
increment = 2
divisors = 0

while divisors < 497:
    tri += increment
    increment += 1
    divs = filter(lambda x: tri % x == 0, xrange(2, int(sqrt(tri)) + 1))
    divisors = len(divs) * 2 + 2
print "%s: %s" % (tri, divisors)
