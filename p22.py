import csv
print sum([(a+1)*sum([ord(x)-64 for x in b]) for a,b in enumerate(sorted(csv.reader(open("names.txt")).next()))])
