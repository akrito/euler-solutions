sum_of_squares = 0
for i in xrange(1,101):
    sum_of_squares += i**2

sum = 0
for j in xrange(1,101):
    sum += j

print sum_of_squares - (sum**2)
