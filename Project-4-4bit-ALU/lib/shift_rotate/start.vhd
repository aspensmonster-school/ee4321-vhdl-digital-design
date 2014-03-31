--http://www.csit-sun.pub.ro/courses/Masterat/Xilinx%20Synthesis%20Technology/toolbox.xilinx.com/docsan/xilinx4/data/docs/xst/hdlcode12.html
--I don't know if this is what Dr. Salamy is after though. I'm not actually 
--implementing a shifter at the gate level, which is likely what Dr. 
--Salamy actually wants to see.

--Update: This looks promising.
--http://dcslab.snu.ac.kr/courses/cs101-2009/notes/Lecture03_Arithmetic_Logic_Unit.pdf

--I could just wire the two least significant bits to the selector and do 
--shifting and rotating that way. This also picks up bases where we are 
--"shifting" or "rotating" a 4-bit number more than 3 places. For shifting, 
--you just get zeroed out. For rotating, the way binary works, rotating by 
--one, 0001, is the same as rotating by 5, 0101, which is the same as 
--rotating by 9, 1001, which is the same as rotating by 13, 1101... etc etc.
--the two least significant bits are always the same!

--Shifting on the other hand still looks a bit dicey.
