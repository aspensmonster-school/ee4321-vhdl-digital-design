library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--NOTE: The following link is a very helpful reference:
--http://cseweb.ucsd.edu/~tweng/cse143/VHDLReference/aa.pdf

entity moore_seq_detect is
  port ( 
    x : IN STD_LOGIC;
    clock : IN STD_LOGIC;
    z : OUT STD_LOGIC
  );
end;

architecture Behavioural of moore_seq_detect is

--declare state vars (this is basically enumerating 
--a list of the possible values that a type of 
--"state_type" may hold)
type state_type is (sr, s0, s1, s2, s3, s4, s5, s6);

--declare internal signals and their type. At any
--given time, each state could be defined as any of 
--the states enumerated above (sr, s0, ... , s6).
--current state defaults to sr
signal current_state: state_type := sr;
signal next_state: state_type;

BEGIN

--combinatorial portion
proc_cruncher: process(current_state, x)

begin

  case current_state is

    when sr =>
      z <= '0';
      if X = '0' then
        next_state <= sr;
      else
        next_state <= s0;
      end if;

    when s0 =>
      z <= '0';
      if X = '0' then
        next_state <= s1;
      else
        next_state <= s0;
      end if;

    when s1 =>
      z <= '0';
      if X = '0' then
        next_state <= sr;
      else
        next_state <= s2;
      end if;

    when s2 =>
      z <= '0';
      if X = '0' then
        next_state <= s1;
      else
        next_state <= s3;
      end if;

    when s3 =>
      z <= '0';
      if X = '0' then
        next_state <= s4;
      else
        next_state <= s0;
      end if;

    when s4 =>
      z <= '0';
      if X = '0' then
        next_state <= s5;
      else
        next_state <= s2;
      end if;

    when s5 =>
      z <= '0';
      if X = '0' then
        next_state <= sr;
      else
        next_state <= s6;
      end if;

    when s6 =>
      z <= '1';
      if X = '0' then
        next_state <= s1;
      else
        next_state <= s0;
      end if;

    when others =>
      current_state <= sr;

  end case;
end process;

--sync'd portion
--using wait directive precludes need to pass clock to process directly.
--(I think)
proc_clock: process

begin

  wait until clock'event and clock = '1');
  current_state <= next_state;

end process;

end Behavioural;
