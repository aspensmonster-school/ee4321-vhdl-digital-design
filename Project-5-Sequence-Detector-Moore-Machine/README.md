Project 5 - Sequence Detector with Moore Machine
================================================

The system has one input 'x' and one output 'z'.

Detect the following input sequence:

1,0,1,1,0,0,1

The output 'z' is 1 only if the input had those 
seven values during the last seven clock cycles.

My Truth Table
==============

|current_state|next_state|output z|
|             |x=0|x=1|           |
|:------------|:-:|:-:|----------:|
|sr|sr|s0|0|
|s0|s1|s0|0|
|s1|sr|s2|0|
|s2|s1|s3|0|
|s3|s4|s0|0|
|s4|s5|s2|0|
|s5|sr|s6|0|
|s6|s1|s0|1|
