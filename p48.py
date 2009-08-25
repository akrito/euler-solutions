modder = 10000000000
last10 = 0
for i in xrange(1,1001):
    last10forI = i
    for j in xrange(2,i+1):
        last10forI = (i * last10forI) % modder
    last10 = (last10 + last10forI) % modder
print last10
