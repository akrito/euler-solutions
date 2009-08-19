from math import sqrt

primes = [2]

i = 1
while primes[-1] < 2000000:
    i += 2
    prime = True
    for p in primes:
        if p > sqrt(i):
            break
        if i % p == 0:
            prime = False
            break
    if prime:
        primes.append(i)

s = 0
for p in primes[:-1]:
    s += p
print s
