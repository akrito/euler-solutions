"""
It was proposed by Christian Goldbach that every odd composite number can be
written as the sum of a prime and twice a square.

It turns out that the conjecture was false.

What is the smallest odd composite that cannot be written as the sum of a prime
and twice a square?
"""

from math import sqrt

primes = [2,3,5,7]

def is_prime(maybe_p):
    root = int(sqrt(maybe_p))
    for prime in primes:
        if prime > root:
            primes.append(maybe_p)
            return True
        if maybe_p % prime == 0:
            return False


def square_generator():
    i = 1
    while True:
        yield i ** 2
        i += 1

def is_goldbach(candidate):
    for p in primes:
        squares = square_generator()

        while True:
            square = squares.next()
            sum = p + (2 * square)
            if sum == candidate:
                return True
            if sum > candidate:
                break

    return False

candidate = 9
while True:
    candidate += 2

    if is_prime(candidate):
        continue

    if not is_goldbach(candidate):
        print "%s violates Goldbach" % candidate
        break

