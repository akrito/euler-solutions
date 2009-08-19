from math import sqrt

primes = [2]

i = 1
while len(primes) < 10001:
    i += 2
    I = sqrt(i)
    prime = True
    for p in primes:
        if p > I:
            break
        if i % p == 0:
            prime = False
            break
    if prime:
        primes.append(i)
print primes[-1]
