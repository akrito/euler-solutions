cur = 1
last = 1
sum = 0

while cur < 4000000:
    print cur
    if cur % 2 == 0:
        sum += cur
    saved = cur
    cur += last
    last = saved
print sum
