from itertools import chain
from glob import glob

file = open('sowpods-upper.txt', 'r')

lines = [line.lower() for line in file]
with open('sowpods-lower.txt', 'w') as out:
     out.writelines(sorted(lines))