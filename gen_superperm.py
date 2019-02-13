#!/usr/bin/env python3

import itertools
import math
import sys

n = int(sys.argv[1])
nfac = math.factorial(n)

print(f"n = {n};")
print(f"pattern_length = {n};")
print(f"num_patterns = {nfac};")
print(f"num_classes = {nfac};")
print("pattern = [|",)
perms = itertools.permutations(range(1, n + 1))
perm_strings = (", ".join(map(str, p)) for p in perms)
print("\n| ".join(perm_strings))
print("|];");
print("class = " + str([i for i in range(1, nfac + 1)]) + ";")
