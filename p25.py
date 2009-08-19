stopper = 10**999
f = 1
F = 1
n = 2
while F < stopper:
    _F = F + f
    f = F
    F = _F
    n += 1
print n
