def collatz_len(n, l = 1):
    if n == 1:
        return l
    l += 1
    if n % 2 == 0:
        return collatz_len(n / 2, l)
    else:
        return collatz_len(3 * n + 1, l)

t = 0
for i in xrange(1,1000000):
    _t = collatz_len(i)
    if _t > t:
        t = _t
print t

