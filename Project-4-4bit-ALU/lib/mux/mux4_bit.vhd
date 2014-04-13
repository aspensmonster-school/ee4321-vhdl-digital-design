--Helpful resource:
--ftp://www.cs.uregina.ca/pub/class/301/multiplexer/lecture.html
library IEEE;
use IEEE.std_logic_1164.all;

entity mux4_bit is

  port(
    bit3 : in std_logic;
    bit2 : in std_logic;
    bit1 : in std_logic;
    bit0 : in std_logic;
    S : in std_logic_vector(1 downto 0);
    R : out std_logic
  );

end mux4_bit;

architecture Behavioural of mux4_bit is

begin

  with S select
  R <= bit0 when "00",
       bit1 when "01",
       bit2 when "10",
       bit3 when others;

end Behavioural;
