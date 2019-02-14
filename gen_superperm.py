#!/usr/bin/env python3

import argparse
from collections import defaultdict
import itertools
import math
import sys


def normalise_perm(p):
    return list(p)

def normalise_necklace(p):
    n = normalise_perm(p)
    i = n.index(1)
    return n[i:] + n[0:i]

def normalise_bracelet(p):
    n = normalise_necklace(p)
    i = n.index(2)
    j = n.index(3)
    if i < j:
        n.reverse()
        return normalise_necklace(n)
    return n


parser = argparse.ArgumentParser(description="Generate MiniZinc input data.")
parser.add_argument('n', type=int)
parser.add_argument('--permutations', '-p', action='store_true')
parser.add_argument('--necklaces', '-n', action='store_true')
parser.add_argument('--bracelets', '-b', action='store_true')

args = parser.parse_args()

n = args.n
class_type_count = sum([args.permutations, args.necklaces, args.bracelets])
if class_type_count > 1:
    sys.exit("More than one orbit class was specified")

if args.bracelets:
    normalise = normalise_bracelet
elif args.necklaces:
    normalise = normalise_necklace
else:
    # default to permutations
    normalise = normalise_perm

nfac = math.factorial(n)

perms = list(itertools.permutations(range(1, n + 1)))
classes = defaultdict(set)
for (i, p) in enumerate(perms):
    key = "".join(map(str, normalise(p)))
    classes[key].add(i + 1) # MiniZinc arrays are 1-indexed
num_classes = len(classes)

print(f"n = {n};")
print(f"pattern_length = {n};")
print(f"num_patterns = {nfac};")
print(f"num_classes = {num_classes};")
print("pattern = [|",)
perm_strings = (", ".join(map(str, p)) for p in perms)
print("\n| ".join(perm_strings))
print("|];");
print(f"class = {list(classes.values())};")
