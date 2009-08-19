from p21 import divisors

def sum_of_divisors(n):
    return sum(divisors(n))


# Find abundant numbers and cross off all summations
if __name__ == '__main__':
    numbers = range(28123)
    abundants = []
    for i in xrange(1, 28123):
        s = sum_of_divisors(i)
        if s > i:
            abundants.append(i)
            for a in abundants:
                t = a + i
                if t < 28123:
                    numbers[t] = 0
    print sum(numbers)
