library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity maxOnes is

  port(
    x : in std_logic;
    clk : in std_logic;
    maxOnes : out std_logic_vector(7 downto 0)
  );

end maxOnes

architecture behavioural of maxOnes is

begin

  clk_process: process(clk)

  variable count:unsigned(7 downto 0) := "00000000";
  variable max:unsigned(7 downto 0) := "00000000";

  begin
    if (clk'event and clk = '1') then
      if x = '1' then
        count := count +1;
      else
      if x = '0' then
        if count > max then
          max <= count;
          count := "00000000";
          maxOnes <= max;
        end if; --end x=0 count > max check
      end if; --end main ifels
    end if; --end posedge
  end process clk_process;

end
