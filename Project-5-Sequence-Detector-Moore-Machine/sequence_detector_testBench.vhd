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
 
    COMPONENT moore_seq_detect
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
  uut: moore_seq_detect PORT MAP (
    x => x,
    clock => clock,
    z => z
  );

  -- define clock behaviour
  proc_clock: process 

  begin

    clock <= '0';
    wait for 10 ns;
    clock <= '1';
    wait for 10 ns;

  end process; --end proc_clock

  -- define x input behaviour
  proc_x_01: process

  begin

    --this should give a z=1 at the end.
    x <= '1'; wait for 20 ns;
    x <= '0'; wait for 20 ns; 
    x <= '1'; wait for 20 ns;
    x <= '1'; wait for 20 ns; 
    x <= '0'; wait for 20 ns;
    x <= '0'; wait for 20 ns; 
    x <= '1'; wait for 20 ns;

    --this serves as a reset for now. synchronous, but still resets.
    x <= 'X'; 

    --this should give a z=0 at the end.
    x <= '1'; wait for 20 ns;
    x <= '0'; wait for 20 ns; 
    x <= '1'; wait for 20 ns;
    x <= '1'; wait for 20 ns; 
    x <= '0'; wait for 20 ns;
    x <= '0'; wait for 20 ns; 
    x <= '0'; wait for 20 ns;
 
    report "Simulation done." severity failure;

  end process; --end proc_x_01

END;
