def raw_sieve(m):
    nums = range(m)
    nums[1] = 0
    i = 2
    while i**2 < m:
        if nums[i] == 0:
            i += 1
            continue
        # Zero out all the multiples of p, starting at the square (optimization)
        j = i**2
        while j < m:
            nums[j] = 0
            j += i
        i += 1
    return nums

def filtered_sieve(m):
    return [x for x in raw_sieve(m) if x != 0]

def wheel_sieve(m):
    nums = range(m >> 1)
    i = 3
    while i**2 < m:
        if nums[i >> 1] == 0:
            i += 2
            continue
        # Zero out all the multiples of p, starting at the square (optimization)
        # Ignore the evens
        j = i**2
        I = i << 1
        while j < m:
            nums[j >> 1] = 0
            j += I
        i += 2
    return [2] + [n * 2 + 1 for n in nums if n != 0]
