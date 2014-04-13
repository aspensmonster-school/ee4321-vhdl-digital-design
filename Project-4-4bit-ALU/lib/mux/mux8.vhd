--Helpful resource:
--ftp://www.cs.uregina.ca/pub/class/301/multiplexer/lecture.html
use IEEE.std_logic_1164.all;

library IEEE;

entity mux8 is

  port(
    bus0 : in std_logic_vector(3 downto 0);
    bus1 : in std_logic_vector(3 downto 0);
    bus2 : in std_logic_vector(3 downto 0);
    bus3 : in std_logic_vector(3 downto 0);
    bus4 : in std_logic_vector(3 downto 0);
    bus5 : in std_logic_vector(3 downto 0);
    bus6 : in std_logic_vector(3 downto 0);
    bus7 : in std_logic_vector(3 downto 0);
    S : in std_logic_vector(1 downto 0);
    R : out std_logic_vector(3 downto 0)
  );

end mux8;

architecture Behavioural of mux8 is

begin

  with S select
  R <= bus0 when "000",
       bus1 when "001",
       bus2 when "010",
       bus3 when "011",
       bus4 when "100",
       bus5 when "101",
       bus6 when "110",
       bus7 when "111";

end Behavioural;
