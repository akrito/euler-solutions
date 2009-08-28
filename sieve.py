from math import sqrt
def raw_sieve(m):
    nums = range(m)
    nums[1] = 0
    i = 2
    while i**2 < m:
        if nums[i] == 0:
            i += 1
            continue
        # Zero out all the multiples of p, starting at the square
        j = i**2
        while j < m:
            nums[j] = 0
            j += i
        i += 1
    return nums

def filtered_sieve(m):
    return [x for x in raw_sieve(m) if x != 0]

# Uses a half-length array
def wheel_sieve(m):
    nums = range(m / 2)
    i = 3
    while i**2 < m:
        if nums[i / 2] == 0:
            i += 2
            continue
        # Zero out all the multiples of p, starting at the square
        # Ignore the evens
        j = i ** 2
        I = i * 2
        while j < m:
            nums[j / 2] = 0
            j += I
        i += 2
    return [2] + [n * 2 + 1 for n in nums if n != 0]

# Currently this isn't very fast, probably because of the generators
def generator_sieve(m):
    yield 2
    yield 3
    nums = [1] * m
    sqrtm = int(sqrt(m))
    for i in roll():
        if i >= sqrtm:
            break
        if nums[i] == 0:
            continue
        yield i
        # Zero out all the multiples of p, starting at the square
        for j in roll(i):
            ji = j * i
            if ji >= m:
                break
            nums[ji] = 0
    for j in roll(i):
        if j >= m:
            break
        if nums[j] != 0:
            yield j

def roll(start = 5):
    k, r = divmod(start, 6)
    k *= 6
    if r > 1:
        yield k + 5
        k += 6
    while True:
        yield k + 1
        yield k + 5
        k += 6
