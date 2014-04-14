library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cla_4_bit is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           Cin : in  STD_LOGIC;
           Sum : out  STD_LOGIC_VECTOR (3 downto 0);
           Cout : out  STD_LOGIC;
           zero : out STD_LOGIC;
           overflow : out STD_LOGIC
         );
end cla_4_bit;

architecture Behavioral of cla_4_bit is

--these wire the output of the CLL to each FA.
signal Cin1, Cin2, Cin3 : std_logic:='0';

--these wire the result of the add/sub check to each FA.
signal b0, b1, b2, b3 : std_logic:='0';
signal Bxor : std_logic_vector (3 downto 0);

begin

--add/sub control; this flips B if necessary.
Bxor(0) <= B(0) XOR Cin;
Bxor(1) <= B(1) XOR Cin;
Bxor(2) <= B(2) XOR Cin;
Bxor(3) <= B(3) XOR Cin;

--Carry-Look-Ahead Logic
CLL0: entity work.cl_logic port map (A,Bxor,Cin,Cin1,Cin2,Cin3,Cout);

--Full adders; for CLA, then individual Couts dangle; they are  
--handled by the CLL module and are technically unnecessary for 
--the CLA implementation.
FA0: entity work.full_adder_1_bit port map (A(0),Bxor(0),Cin,open,Sum(0));

FA1: entity work.full_adder_1_bit port map (A(1),Bxor(1),Cin1,open,Sum(1));

FA2: entity work.full_adder_1_bit port map (A(2),Bxor(2),Cin2,open,Sum(2));

FA3: entity work.full_adder_1_bit port map (A(3),Bxor(3),Cin3,open,Sum(3));

--if any bit in sum is non-zero, then zero gets set to zero. Otherwise, zero 
--gets set to one.
zero <= NOT(Sum(0) OR Sum(1) OR Sum(2) OR Sum(3));

--detect overflow for signed case.
overflow <= Cout XOR Cin3;

end Behavioral;

