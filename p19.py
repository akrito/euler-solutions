# * 1 Jan 1900 was a Monday.
# * Thirty days has September,
#   April, June and November.
#   All the rest have thirty-one,
#   Saving February alone,
#   Which has twenty-eight, rain or shine.
#   And on leap years, twenty-nine.
# * A leap year occurs on any year evenly divisible by 4,
#   but not on a century unless it is divisible by 400.

# How many Sundays fell on the first of the month during
# the twentieth century (1 Jan 1901 to 31 Dec 2000)?

# Day mod 7 = 0
# Monday = 1

def daysinmonth(m, y):
    if m in [1, 3, 5, 7, 8, 10, 12]:
        return 31
    if m in [4, 6, 9, 11]:
        return 30
    if y % 400 == 0:
        return 29
    if y % 100 == 0:
        return 28
    if y % 4 == 0:
        return 29
    return 28

d = 1
t = 0
for y in xrange(1900, 2001):
    for m in xrange(1, 13):
        d += daysinmonth(m, y)
        if d % 7 == 0 and y >= 1901:
            print "%s %s was a Sunday" % (m, y)
            t += 1

print t

