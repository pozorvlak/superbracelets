int: n;
set of int: choice = 0..n;
int: pattern_length;
int: num_patterns;
int: num_classes;
set of int: PATTERN = 1..num_patterns;
set of int: CLASS = 1..num_classes;
array[PATTERN, 1..pattern_length] of choice: pattern;
array[PATTERN] of CLASS: class;
int: max_length = num_classes * pattern_length;
set of int: index = 1..max_length;
array[index] of var choice: seq;
var index: length;

% fill seq with 0s after the end of the superbracelet
constraint forall(i in length+1..max_length)(seq[i] = 0);
constraint forall(i in 1..length)(seq[i] != 0);

% break symmetries by forcing the sequence to start with 1..n
constraint forall(i in 1..n)(seq[i] = i);

% actually include all the classes!
array[CLASS] of var index: start;
constraint forall(c in class)(
    exists(p in PATTERN)(
        class[p] = c /\ forall(i in 1..pattern_length)(seq[start[c] + i - 1] = pattern[p, i])
    )
);

solve minimize length;
