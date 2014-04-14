library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--NOTE: the "diff" input comes from the output of the add_sub module.
--the way the opcodes are defined, the output is always the difference 
--of A and B if the user is requesting a comparison operation. Otherwise, 
--the output of this module will technically be undefined/wrong, but it 
--doesn't matter because we won't be selecting it for the final output.

entity comparator is 
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           op : in STD_LOGIC_VECTOR (2 downto 0);
           zero : in STD_LOGIC;
           cout : in STD_LOGIC;
           overflow : in STD_LOGIC;
           diff : in STD_LOGIC_VECTOR (3 downto 0);
           R : out  STD_LOGIC
         );
end comparator;

architecture Behavioral of comparator is 

--signals
signal a_GEQ_b_SIGNED_R : std_logic:='0';
signal a_LE_b_SIGNED_R : std_logic:='0';
signal a_NEQ_b_UNSIGNED_R : std_logic:='0';
signal a_EQ_b_UNSIGNED_R : std_logic:='0';
signal a_GEQ_b_UNSIGNED_R : std_logic:='0';
signal a_LE_b_UNSIGNED_R : std_logic:='0';
signal s : std_logic_vector(3 downto 0);

begin

-------------------------------------------
--SIGNED PORTIONS
-------------------------------------------

--SIGNED is a bit more tricky. However, we can take 
--advantage of the overflow flag and arrive at the 
--following conclusions:
--(thanks to: http://teahlab.com/4-Bit_Signed_Comparator/)
-- X = Y <--> zero
-- X < Y <--> diff(3) XOR overflow
-- X > Y <--> !( zero OR ( diff(3) XOR overflow) )

--GEQ SIGNED
a_GEQ_b_SIGNED_R <= NOT(zero OR (diff(3) XOR overflow) ) OR zero;
--LE SIGNED
a_LE_b_SIGNED_R <= diff(3) XOR overflow;

-------------------------------------------
--UNSIGNED PORTIONS
-------------------------------------------

--EQ/NEQ
--well, *that* was easy :D
a_NEQ_b_UNSIGNED_R <= NOT(zero);
a_EQ_b_UNSIGNED_R <= zero;

--GEQ UNSIGNED

--Well, it turns out unsigned is harder. I'm way behind and 
--so close to being done, so I'm borrowing some code from here
--to make sure the tests all work:
--http://sid-vlsiarena.blogspot.com/2013/03/4-bit-magnitude-comparator-vhdl-code.html
--I'll have to explain the karnaugh map theory behind it later in the report.

s(0)<= a(0) xnor b(0);
s(1)<= a(1) xnor b(1);
s(2)<= a(2) xnor b(2);
s(3)<= a(3) xnor b(3);

a_GEQ_b_UNSIGNED_R <= (a(3) and (not b(3))) 
or (s(3) and a(2) and (not b(2))) 
or (s(3) and s(2) and a(1)and (not b(1))) 
or (s(3) and s(2) and s(1) and a(0) and (not b(0)))
or zero;

--LE UNSIGNED
a_LE_b_UNSIGNED_R <= (b(3) and (not a(3))) 
or (s(3) and b(2) and (not a(2)))
or (s(3) and s(2) and b(1)and (not a(1))) 
or (s(3) and s(2) and s(1) and b(0) and (not a(0)));

-------------------------------------------
--select output based on opcode
-------------------------------------------

output: entity work.mux8_bit port map (open, a_GEQ_b_SIGNED_R, a_LE_B_SIGNED_R,
a_NEQ_b_UNSIGNED_R, a_EQ_b_UNSIGNED_R, a_GEQ_b_UNSIGNED_R, a_LE_b_UNSIGNED_R,
open, op, R);

end Behavioral;

