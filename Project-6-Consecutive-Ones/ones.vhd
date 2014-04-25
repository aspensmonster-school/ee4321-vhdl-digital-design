library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity maxOnesCounter is

  port(
    x : in std_logic;
    clock : in std_logic;
    maxOnes : out std_logic_vector(7 downto 0) := (others => '0')
  );

end maxOnesCounter;

architecture behavioural of maxOnesCounter is

begin

  clock_process: process(clock,x)

  variable count:unsigned(7 downto 0) := "00000000";
  variable max:unsigned(7 downto 0) := "00000000";

  begin
    if (clock'event and clock = '1') then
      if x = '1' then
        count := count +1;
        if count > max then
          max := count;
          maxOnes <= std_logic_vector(max);
        end if; --end count > max check
		else
		  count := "00000000";
      end if; --end main if elss
    end if; --end posedge
  end process;

end architecture behavioural;
