--Helpful resource:
--ftp://www.cs.uregina.ca/pub/class/301/multiplexer/lecture.html
library IEEE;
use IEEE.std_logic_1164.all;

entity mux2_bit is

  port(
    bit0 : in std_logic;
    bit1 : in std_logic;
    S : in std_logic;
    R : out std_logic
  );

end mux2_bit;

architecture Behavioural of mux2_bit is

begin

  with S select
  R <= bit0 when '0',
       bit1 when others;

end Behavioural;
