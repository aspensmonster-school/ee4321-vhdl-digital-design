----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:15:26 02/12/2014 
-- Design Name: 
-- Module Name:    rca_4_bit - Behavioral 
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

entity rca_4_bit is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           Cin : in  STD_LOGIC;
           Sum : out  STD_LOGIC_VECTOR (3 downto 0);
           Cout : out  STD_LOGIC);
end rca_4_bit;

architecture Behavioral of rca_4_bit is

signal c0, c1, c2 : std_logic:='0';
signal b0, b1, b2, b3 : std_logic:='0';

begin

--add/sub control; If Cin is high, then we are subtracting, and these 
--muxes output the inverse of B. If Cin is low, then we are adding, and
--these muxes just pass B.
mux0: entity work.mux2 port map (B(0),NOT(B(0)),Cin,b0);
mux1: entity work.mux2 port map (B(1),NOT(B(1)),Cin,b1);
mux2: entity work.mux2 port map (B(2),NOT(B(2)),Cin,b2);
mux3: entity work.mux2 port map (B(3),NOT(B(3)),Cin,b3);


FA0: entity work.full_adder_1_bit port map (A(0),b0,Cin,c0,Sum(0));

FA1: entity work.full_adder_1_bit port map (A(1),b1,c0,c1,Sum(1));

FA2: entity work.full_adder_1_bit port map (A(2),b2,c1,c2,Sum(2));

FA3: entity work.full_adder_1_bit port map (A(3),b3,c2,Cout,Sum(3));

end Behavioral;


