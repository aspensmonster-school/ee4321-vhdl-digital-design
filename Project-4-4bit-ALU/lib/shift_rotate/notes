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

--Update a few days later:

--I can't think of a good way to do this completely combinatorially.
--I keep wanting to use flip-flops. However, we could still use the 
--barrel shifter idea above to shift as well as rotate. We'd need to 
--wire the result of ( B > 3 ) to the shifter though. If B > 3, AND 
--opcode implies logical shift, clear out the result of the barrel 
--shift. Otherwise... we can appropriately wire 4 mux4s to 
--output the appropriate amount of the barrel-shifted result, and 
--zero out the rest. I.e., something like:

-- mux4(B(3),B(3),B(3),B(3),S(1 downto 0),D(3))
-- mux4(B(2),B(2),B(2),0,S(1 downto 0),D(2))
-- mux4(B(1),B(1),0,0,S(1 downto 0),D(1))
-- mux4(B(0),0,0,0,S(1 downto 0),D(0))

--Granted, this will have us replicating sll and rol in the 
--opposite direction for srl and ror. Still don't have sra 
--figured out though. I'm dog tired though now. It's nearly 
--four in the morning and I've still got to get to class.

--Who am I kidding. I probably won't. I don't like showing 
--my face when I'm behind everyone else. Dishonor on me, 
--Dishonor on my cow...
