LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY sequence_detector_testBench IS
END sequence_detector_testBench;
 
ARCHITECTURE behavior OF sequence_detector_testBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sequence_detector
    PORT(
         x : IN STD_LOGIC;
         clock : IN STD_LOGIC;
         z : OUT  STD_LOGIC
        );
    END COMPONENT;
    

   --Inputs
   signal x : std_logic;
   signal clock : std_logic;

   --Outputs
   signal z : std_logic;
 
BEGIN
 
  -- Instantiate the Unit Under Test (UUT)
  uut: sequence_detector_testBench PORT MAP (
    x => x,
    clock => clock,
    z => z
  );

  -- define clock behaviour
  proc_clock: process 

  begin

    clock <= NOT(clock) after 10 ns;
    wait for 20 ns;

  end process; --end proc_clock

  -- define x input behaviour
  proc_x_01: process

  begin

    x <= '1'; wait 20 ns;
    x <= '0'; wait 20 ns; 
    x <= '1'; wait 20 ns;
    x <= '1'; wait 20 ns; 
    x <= '0'; wait 20 ns;
    x <= '0'; wait 20 ns; 
    x <= '1'; wait 20 ns;

  end process; --end proc_x_01

END;
