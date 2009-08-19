t = 0
for i in xrange(1, 1000):
    for j in xrange(1, 1000):
        k = i * j
        s = str(k)
        good = True
        for l in xrange(0, len(s) / 2):
            if s[l] != s[-1 - l]:
                good = False
                break
        if good:
            if k > t:
                t = k
                print t
