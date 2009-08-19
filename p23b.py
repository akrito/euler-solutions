# http://mathworld.wolfram.com/DivisorFunction.html
def sum_of_divisors(n):
    prod = 1
    N = n
    factor = 2
    while factor**2 <= N:
        a = 0
        while N % factor == 0:
            a += 1
            N /= factor
        # Skip doing the math if factor's not a factor
        if a > 0:
            prod *= ((factor**(a+1) - 1) / (factor - 1))
        if factor == 2:
            factor += 1
        else:
            factor += 2
    # If N != 1, N is prime and needs to be counted in the factors
    if N != 1:
        prod *= ((N**2 - 1) / (N - 1))
    return prod - n

# Find abundant numbers and cross off all summations
if __name__ == '__main__':
    numbers = range(28123)
    abundants = []
    for i in xrange(1, 28123):
        s = sum_of_divisors(i)
        if s > i:
            abundants.append(i)

    for i, a in enumerate(abundants):
        for b in abundants[i:]:
            t = a + b
            # Since both lists are sorted, exit early when we can
            if t >= 28123:
                break
            numbers[t] = 0

    print sum(numbers)
