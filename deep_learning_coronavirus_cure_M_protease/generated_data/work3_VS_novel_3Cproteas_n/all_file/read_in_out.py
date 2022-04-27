
import os
import sys

file=sys.argv[1]
f = open(file,encoding='gbk')
each_line = f.readlines()

for line in each_line:
     print (line.strip())
