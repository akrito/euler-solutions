def coins(n, total, denoms):
    if len(denoms) == 0:
        return total
    coin = denoms[0]
    rest = denoms[1:]
    multiplier = 0
    while n >= coin * multiplier:
        if n == coin * multiplier:
            total += 1
            break
        total = coins(n - coin * multiplier, total, rest)
        multiplier += 1
    return total

print coins(200, 0, [1,2,5,10,20,50,100,200])
