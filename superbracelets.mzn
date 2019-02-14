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

% track the start points of each new pattern
include "globals.mzn";
array[CLASS] of var index: start;
constraint increasing(start);
constraint forall(i in 1..num_classes-1)(start[i+1] - start[i] <= pattern_length);
% track which order classes occur in
array[CLASS] of var CLASS: class_seq;
constraint alldifferent(class_seq);

% pick a representative pattern for each class
constraint forall(c in CLASS)(rep[c] in class[c]);
% actually include all the classes!
constraint forall(c in CLASS)(
    forall(i in 1..pattern_length)(
        seq[start[c] + i - 1] = pattern[rep[class_seq[c]], i]));

solve minimize length;
