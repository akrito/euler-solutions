MAX = 354294

def fifthPowers(targetNum=0, digitPlace=5, sumSoFar=0, total=0):
    if digitPlace == 0:
        for x in xrange(0, 10):
            t = targetNum + x
            if sumSoFar + x**5 == t and t != 1:
                total += t
                print t
        return total
    for x in xrange(0, 10):
        total = fifthPowers(targetNum + (x*10**digitPlace), digitPlace - 1, sumSoFar + x**5, total)
    return total

print fifthPowers()
