from math import sqrt
# find largest prime factor of 600851475143

# Factor x:
# starting with 2, find a number that divides x.
# return that number with the others

def factors(x):
    for i in xrange(2, int(sqrt(x) + 1)):
        if x % i == 0:
            return [i] + factors(x / i)
    return [x]

print factors(600851475143)
print factors(10)
