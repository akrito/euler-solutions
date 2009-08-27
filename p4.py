t = 0
for i in xrange(999, 99, -1):
    for j in xrange(999, i - 1, -1):
        k = i * j
        if k <= t:
            break
        s = str(k)
        good = True
        for l in xrange(0, len(s) / 2):
            if s[l] != s[-1 - l]:
                good = False
                break
        if good:
            t = k
print t
