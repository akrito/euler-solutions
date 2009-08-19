a = 'x one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen'.split()

b = 'x x twenty thirty forty fifty sixty seventy eighty ninety'.split()

t = 0

for i in xrange(1, 20):
    print a[i]
    t += len(a[i])

for j in range(2, 10):
    print b[j]
    t += len(b[j])
    for k in range(1, 10):
        print b[j], a[k]
        t += len(b[j] + a[k])

for m in range(1, 10):
    print a[m], "hundred"
    t += len(a[m] + "hundred")

    for i in xrange(1, 20):
        print a[m], "hundredand", a[i]
        t += len(a[m] + "hundredand" + a[i])

    for j in range(2, 10):
        print a[m], "hundred and", b[j]
        t += len(a[m] + "hundredand" + b[j])
        for k in range(1, 10):
            print a[m], "hundred and", b[j], a[k]
            t += len(a[m] + "hundredand" + b[j] + a[k])

print "one thousand"
t += len("onethousand")

print t
