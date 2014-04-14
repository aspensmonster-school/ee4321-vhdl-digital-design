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
a_NEQ_b_UNSIGNED_R <= zero;
a_EQ_b_UNSIGNED_R <= zero;

--GEQ UNSIGNED
--diff(3) is only 1 if A is less than B.
--There is no case where diff(3) is 1, AND zero is 1, 
--which would cause this to erroneously report a GEQ b.
--(zero wouldn't get set if diff(3) was also set).
a_GEQ_b_UNSIGNED_R <= NOT(diff(3)) OR zero;

--LE UNSIGNED
--A < B always results in diff(3) being set.
--no need to check zero because we're looking at 
--strictly less than.
a_LE_b_UNSIGNED_R <= diff(3);

-------------------------------------------
--select output based on opcode
-------------------------------------------

output: entity work.mux8_bit port map (open, a_GEQ_b_SIGNED_R, a_LE_B_SIGNED_R,
a_NEQ_b_UNSIGNED_R, a_EQ_b_UNSIGNED_R, a_GEQ_b_UNSIGNED_R, a_LE_b_UNSIGNED_R,
open, op, R);

end Behavioral;

