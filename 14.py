collatz_store = {}
def collatz_len(n, s):
    if collatz_store.has_key(n):
        return collatz_store[n]
    if n == 1:
        return 1
    if n % 2 == 0:
        return 1 + collatz_len(n / 2, s)
    else:
        return 1 + collatz_len(3 * n + 1, s)

t = 0
for i in xrange(1,1000000):
    _t = collatz_len(i, collatz_store)
    collatz_store[i] = _t
    if _t > t:
        t = _t
        answer = i
print answer

