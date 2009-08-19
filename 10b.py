from math import sqrt

nums = range(2, 2000000)
primes = [2]

p = nums[0]
while p**2 < 2000000:
    _nums = [x for x in nums if x % p != 0]
    nums = _nums
    p = nums[0]
    print p
    primes.append(p)

t = 0
for p in primes[:-1]:
    t += p
for n in nums:
    t += n
print t
