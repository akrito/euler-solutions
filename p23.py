#from p21 import divisors
from math import sqrt

#def sum_of_divisors(n):
#    return sum(divisors(n))

def sum_of_divisors(n, primes):
    prod = 1
    N = n
    factor = 0
    while factor**2 <= N:
        a = 0
        if factor == 2:
            factor += 1
        else:
            factor += 2
        while N % factor == 0:
            a += 1
            N /= factor
        # if a > 0
        prod *= ((factor**(a+1) - 1) / factor - 1)
    return prod

# Find abundant numbers and cross off all summations
numbers = range(28123)
abundants = []
for i in xrange(1, 28123):
    if sum_of_divisors(i) > i:
        abundants.append(i)
        for a in abundants:
            t = a + i
            if t < 28123:
                numbers[t] = 0
print sum(numbers)
