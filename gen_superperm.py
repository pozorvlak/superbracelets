#!/usr/bin/env python3

from collections import defaultdict
import itertools
import math
import sys


n = int(sys.argv[1])
nfac = math.factorial(n)

def normalise_necklace(p):
    i = p.index(1)
    return p[i:] + p[0:i]

perms = list(itertools.permutations(range(1, n + 1)))
classes = defaultdict(set)
for (i, p) in enumerate(perms):
    classes[normalise_necklace(p)].add(i + 1) # MiniZinc arrays are 1-indexed

print(f"n = {n};")
print(f"pattern_length = {n};")
print(f"num_patterns = {nfac};")
print(f"num_classes = {nfac};")
print("pattern = [|",)
perm_strings = (", ".join(map(str, p)) for p in perms)
print("\n| ".join(perm_strings))
print("|];");
print(f"class = {list(classes.values())};")
