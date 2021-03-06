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

# loop through a and b

# prime factor a. the first number that divides into a and b is the
# highest n that could generate a prime

def factor(n):
    N = n
    factor = 2
    factors = []
    while factor**2 <= abs(N):
        a = False
        while N % factor == 0:
            a = True
            N /= factor
        if a:
            factors.append(factor)
        if factor == 2:
            factor += 1
        else:
            factor += 2
    # If N != 1, N is prime and needs to be counted in the factors
    if N != 1 and N != 0:
        factors.append(abs(N))
    return factors

def is_prime(n):
    N = abs(n)
    factor = 2
    if N < 2:
        return False
    while factor**2 <= N:
        if N % factor == 0:
            return False
        if factor == 2:
            factor += 1
            continue
        factor += 2
    return True

A = False
B = False
MAX_N = 0

# When n == 0, n^2 + a*n + b = b, so b must be prime
for a in xrange(-999, 1000):
    factors = factor(a)
    for b in xrange(2, 1000):
        upper = False
        # When n is lowest common divisor of a and b, the quadratic will not be prime
        for f in factors:
            if b % f == 0:
                upper = f
                break
        if upper and upper < MAX_N:
            break
        n = 0
        while is_prime(n**2 + a*n + b):
            n += 1
        if n > MAX_N:
            MAX_N = n
            A = a
            B = b

print A, B, MAX_N
print A*B
