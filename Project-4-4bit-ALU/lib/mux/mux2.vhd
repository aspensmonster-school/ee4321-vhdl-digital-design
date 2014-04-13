--Helpful resource:
--ftp://www.cs.uregina.ca/pub/class/301/multiplexer/lecture.html
use IEEE.std_logic_1164.all;

library IEEE;

entity mux2 is

  port(
    bus0 : in std_logic_vector(3 downto 0);
    bus1 : in std_logic_vector(3 downto 0);
    S : in std_logic;
    R : out std_logic_vector(3 downto 0)
  );

end mux2;

architecture Behavioural of mux2 is

begin

  with S select
  R <= bus0 when '0',
       bus1 when others;

end Behavioural;
