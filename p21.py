from math import sqrt

def divisors(n):
    ds = [1]
    # go up to sqrt(n)
    for x in xrange(2, int(sqrt(n)) + 1):
        if n % x == 0:
            a = n / x
            ds.append(x)
            # Don't push the square twice
            if a != x:
                ds.append(n / x)
    return ds

if __name__ == '__main__':
    h = {}
    for x in xrange(1, 10001):
        h[x] = sum(divisors(x))
    t = 0
    for k, v in h.iteritems():
        if k != v and h.get(v, -1) == k:
            print "amicable: %s and %s" % (k, v)
            t += k + v

    print t / 2
