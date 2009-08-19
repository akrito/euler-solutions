from math import sqrt

tri = 1
increment = 2
divisors = 0

while divisors <= 500:
    tri += increment
    increment += 1
    divisors = 0
    for i in xrange(2, int(sqrt(tri)) + 1):
        if tri % i == 0:
            divisors += 1
    divisors = divisors * 2 + 2
print "%s: %s" % (tri, divisors)
