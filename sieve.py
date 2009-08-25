def raw_sieve(m):
    nums = range(m)
    nums[1] = 0
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
    return nums

def filtered_sieve(m):
    return [x for x in raw_sieve(m) if x != 0]
