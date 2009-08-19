# Given a permutation, what's the next one?
# 0123456789
# 0123456798 swapped last two 10
# 0123456879
# 0123456897
# 0123456978
#       6987
#       7689

def perms(left, right, count):
    # Base case: print left
    if len(right) == 1:
        count += 1
        if count == 1000000:
            print ''.join(left + [right])
            return False
        return count

    # For each element in right,
    #   Attach it to the left and run perms on the left
    #   Update the count with the result of perms

    for i in xrange(len(right)):
        d = right[i]
        count = perms(left + [d], right[:i] + right[i+1:], count)
        if count == False:
            break
    return count

perms([], "0123456789", 0)
