tri = 1
increment = 2
divisors = 0

while divisors <= 500:
    tri += increment
    TRI = tri
    increment += 1
    divisors = 1
    factor = 2
    while factor**2 <= TRI:
        factorcount = 1
        while TRI % factor == 0:
            factorcount += 1
            TRI /= factor
        divisors *= factorcount

        # 2->3, 3->5, 5->7, etc.
        factor += (1 + (factor & 1))
    if TRI != 1:
        divisors *= 2
    else:
        divisors += 1
print tri
