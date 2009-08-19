# Or just 40 choose 20
rights = 20
downs = 20

h = {}

def possible(r, d, h):
    if h.has_key((r, d)):
        return h[(r,d)]
    if r == 0 or d == 0:
        return 1
    p = q = 0
    if r > 0:
        p = possible(r - 1, d, h)
    if d > 0:
        q = possible(r, d - 1, h)
    h[(r,d)] = p + q
    return p + q

print possible(rights, downs, h)
