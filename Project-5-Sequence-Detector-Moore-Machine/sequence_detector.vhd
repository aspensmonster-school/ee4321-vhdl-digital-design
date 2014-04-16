library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--NOTE: The following link is a very helpful reference:
--http://cseweb.ucsd.edu/~tweng/cse143/VHDLReference/aa.pdf

entity moore_seq_detect is
  port ( 
    x : IN STD_LOGIC;
    z : OUT STD_LOGIC;
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
signal current_state: state_type;
signal next_state: state_type;

--combinatorial portion
cruncher: process(current_state, x)

begin

  case current_state is

    when sr =>
      z <= '0';
      if X = '0' then
        next_state <= sr;
      else
        next_state <= s0;
      end if;

    when s1 =>
