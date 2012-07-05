#!/usr/bin/env python
from math import sqrt

TARGET = 2000000


def count(m,n):
    return ((m**2 + m)/2) * ((n**2 + n)/2)

highest = int(-.5 + sqrt(0.25 + (4*0.5*TARGET)))
closest_prod = 0
closest_diff = TARGET

for m in xrange(1, highest):
    for n in xrange(1, m):
        new_count = count(m, n)
        diff = abs(new_count - TARGET)
        if diff < closest_diff:
            closest_prod = m * n
            closest_diff = diff
        if new_count > TARGET:
            break

print closest_prod

