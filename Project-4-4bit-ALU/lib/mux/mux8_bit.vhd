--Helpful resource:
--ftp://www.cs.uregina.ca/pub/class/301/multiplexer/lecture.html
library IEEE;
use IEEE.std_logic_1164.all;

entity mux8_bit is

  port(
    bit0 : in std_logic := '-';
    bit1 : in std_logic := '-';
    bit2 : in std_logic := '-';
    bit3 : in std_logic := '-';
    bit4 : in std_logic := '-';
    bit5 : in std_logic := '-';
    bit6 : in std_logic := '-';
    bit7 : in std_logic := '-';
    S : in std_logic_vector(2 downto 0);
    R : out std_logic
  );

end mux8_bit;

architecture Behavioural of mux8_bit is

begin

  with S select
  R <= bit0 when "000",
       bit1 when "001",
       bit2 when "010",
       bit3 when "011",
       bit4 when "100",
       bit5 when "101",
       bit6 when "110",
       bit7 when others;

end Behavioural;
