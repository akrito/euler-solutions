# Thanks to Sean Bleier for the tip
def ss(n):
    m = 999 / abs(n)
    return n * ((m * (m + 1)) / 2)
print sum(map(ss, [3, 5, -15]))
