"""
Euler published the remarkable quadratic formula:

n^2 + n + 41

It turns out that the formula will produce 40 primes for the
consecutive values n = 0 to 39. However, when n = 40, 402 + 40 + 41 =
40(40 + 1) + 41 is divisible by 41, and certainly when n = 41, 41^2 +
41 + 41 is clearly divisible by 41.

Using computers, the incredible formula n^2 79n + 1601 was discovered,
which produces 80 primes for the consecutive values n = 0 to 79. The
product of the coefficients, 79 and 1601, is 126479.

Considering quadratics of the form:

n^2 + an + b, where |a| < 1000 and |b| < 1000

where |n| is the modulus/absolute value of n
e.g. |11| = 11 and |4| = 4

Find the product of the coefficients, a and b, for the quadratic
expression that produces the maximum number of primes for consecutive
values of n, starting with n = 0.
"""

def is_prime(n, primes):
    N = abs(n)
    I = len(primes)
    i = 0
    factor = 2
    if N < 2:
        return False
    while factor**2 <= N:
        if N % factor == 0:
            return False
        if i == len(primes):
            factor += 2
            continue
        i += 1
        factor = primes[i]
    return True

# Generate primes
m = 1000
nums = range(m)
nums[1] = 0

print "sieve"

i = 0
while i**2 < m:
    if nums[i] == 0:
        i += 1
        continue
    # The next non-zero should be prime
    p = nums[i]

    # Zero out all the multiples of p, starting at the square (optimization)
    j = p
    while j * p < m:
        nums[j * p] = 0
        j += 1
    i += 1

print "filter"

primes = [x for x in nums if x != 0]

A = False
B = False
MAX_N = 0

print "loop"

# When n == 0, n^2 + a*n + b = b, so b must be prime
for b in reversed(primes):
    if b < MAX_N:
        continue
    for a in xrange(-999, 1000):
        n = 0
        while is_prime(n**2 + a*n + b, primes):
            n += 1
        if n > MAX_N:
            MAX_N = n
            A = a
            B = b

print A, B, MAX_N
print A*B
