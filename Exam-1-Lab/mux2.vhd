library IEEE;

use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity mux2 is

  port(
    b : in std_logic;
    notb : in std_logic;
    S : in std_logic;
    R : out std_logic
  );

end mux2;

architecture Behavioural of mux2 is

begin

  with S select
  R <= b when '0',
       notb when others;

end Behavioural;
