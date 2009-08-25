from sieve import raw_sieve

nums = raw_sieve(1000000)

# Loop through. If any rotation isn't prime, 0 it out.
def rotated(n):
    yield n
    N = str(n)
    for i in range(1, len(N)):
        yield int(N[i:] + N[:i])

for n in nums:
    if n != 0:
        if any([nums[p] == 0 for p in rotated(n)]):
            nums[n] = 0

# Filter and count
print len([x for x in nums if x != 0])
