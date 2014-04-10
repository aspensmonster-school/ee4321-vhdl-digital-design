library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity logical is 
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           op : in STD_LOGIC_VECTOR (1 downto 0);
           R : out  STD_LOGIC_VECTOR (3 downto 0)
         );
end logical;

architecture Behavioral of logical is 

--output signals
signal and_R : std_logic_vector (3 downto 0);
signal or_R : std_logic_vector (3 downto 0);
signal nor_R : std_logic_vector (3 downto 0);
signal xor_R : std_logic_vector (3 downto 0);

begin

--crunch all possible values
and_R <= A AND B;
or_R <= A OR B;
nor_R <= A NOR B;
xor_R <= A XOR B;

--select output based on opcode
output: entity work.mux4 (nor_R, and_R, or_R, xor_R, op, R);

end Behavioral;

