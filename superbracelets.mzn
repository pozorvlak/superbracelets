int: n;
set of int: choice = 0..n;
int: pattern_length;
int: num_patterns;
int: num_classes;
set of int: PATTERN = 1..num_patterns;
set of int: CLASS = 1..num_classes;
array[PATTERN, 1..pattern_length] of choice: pattern;
array[CLASS] of set of PATTERN: class;
int: max_length = num_classes * pattern_length;
set of int: index = 1..max_length;
array[index] of var choice: seq;
var index: length;
array[CLASS] of var PATTERN: rep;

% fill seq with 0s after the end of the superbracelet
constraint forall(i in length+1..max_length)(seq[i] = 0);
constraint forall(i in 1..length)(seq[i] != 0);

% break symmetries by forcing the sequence to start with 1..n
constraint forall(i in 1..n)(seq[i] = i);

% actually include all the classes!
include "globals.mzn";
array[CLASS] of var index: start;
constraint alldifferent(start);
% pick a representative pattern for each class
constraint forall(c in CLASS)(rep[c] in class[c]);
constraint forall(c in CLASS)(
    forall(i in 1..pattern_length)(seq[start[c] + i - 1] = pattern[rep[c], i])
);

solve minimize length;
