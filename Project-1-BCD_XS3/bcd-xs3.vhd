----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:48:38 02/04/2014 
-- Design Name: 
-- Module Name:    bcd-xs3 - Behavioral 
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

entity bcd_xs3 is
    Port ( X : in  STD_LOGIC_VECTOR(3 downto 0);
           Y : out  STD_LOGIC_VECTOR(3 downto 0));
end bcd_xs3;

architecture Behavioral of bcd_xs3 is

begin

Y(3) <= X(3) OR (X(0) AND X(2)) OR (X(1) AND X(2));
Y(2) <= (X(0) AND (NOT X(2))) OR (X(1) AND (NOT X(2))) OR ((NOT X(0))
AND (NOT X(1)) AND X(2) AND (NOT X(3)));
Y(1) <= ((NOT X(0)) AND (NOT X(1))) OR (X(0) AND X(1));
Y(0) <= (NOT X(0));

end Behavioral;

