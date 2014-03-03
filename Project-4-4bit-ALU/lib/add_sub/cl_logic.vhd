----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:41:32 02/12/2014 
-- Design Name: 
-- Module Name:    full_adder_1_bit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cl_logic is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
	   Cin : in  STD_LOGIC;
           Cin1 : out  STD_LOGIC;
           Cin2 : out  STD_LOGIC;
           Cin3 : out  STD_LOGIC;
           Cout : out  STD_LOGIC);
end cl_logic;

architecture Behavioral of cl_logic is

begin

-- Cin1 = G_0 + P_0 * Cin0
Cin1 <= ( A(0) AND B(0) ) 
  OR ( (Cin) 
    AND (A(0) OR B(0)) );

-- Cin2 = G_1 + P_1 * Cin1
Cin2 <= ( A(1) AND B(1) ) 
  OR ( (A(0) AND B(0)) 
    AND (A(1) OR B(1)) ) 
  OR ( (Cin) 
    AND (A(0) OR B(0)) 
    AND (A(1) OR B(1)) );

-- Cin3 = G_2 + P_2 * Cin2
Cin3 <= ( A(2) AND B(2) )
  OR ( (A(1) AND B(1)) 
    AND (A(2) OR B(2)) )
  OR ( (A(0) AND B(0)) 
    AND (A(1) OR B(1)) 
    AND (A(2) OR B(2)) )
  OR ( (Cin) 
    AND (A(0) OR B(0)) 
    AND (A(1) OR B(1)) 
    AND (A(2) OR B(2)) );

-- Cout = G_3 + P_3 * Cin3
Cout <= ( A(3) AND B(3) )
  OR ( (A(2) AND B(2)) 
    AND (A(3) OR B(3)) )
  OR ( (A(1) AND B(1)) 
    AND (A(2) OR B(2)) 
    AND (A(3) OR B(3)) )
  OR ( (A(0) AND B(0)) 
    AND (A(1) OR B(1)) 
    AND (A(2) OR B(2)) 
    AND (A(3) OR B(3)) )
  OR ( (Cin) 
    AND (A(0) OR B(0)) 
    AND (A(1) OR B(1)) 
    AND (A(2) OR B(2)) 
    AND (A(3) OR B(3)) );

end Behavioral;

