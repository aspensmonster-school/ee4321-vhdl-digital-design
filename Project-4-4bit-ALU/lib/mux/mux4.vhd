--Helpful resource:
--ftp://www.cs.uregina.ca/pub/class/301/multiplexer/lecture.html
use IEEE.std_logic_1164.all;

library IEEE;

entity mux4 is

  port(
    bus0 : in std_logic_vector(3 downto 0);
    bus1 : in std_logic_vector(3 downto 0);
    bus2 : in std_logic_vector(3 downto 0);
    bus3 : in std_logic_vector(3 downto 0);
    S : in std_logic_vector(1 downto 0);
    R : out std_logic_vector(3 downto 0)
  );

end mux4;

architecture Behavioural of mux4 is

begin

  with S select
  R <= bus0 when "00";
       bus1 when "01";
       bus2 when "10";
       bus3 when "11";

end Behavioural;
