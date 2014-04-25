LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY maxOnes_testBench IS
END maxOnes_testBench;
 
ARCHITECTURE behavior OF maxOnes_testBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT maxOnes
    PORT(
         x : IN STD_LOGIC;
         clock : IN STD_LOGIC;
         maxOnes : out std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal x : std_logic;
   signal clock : std_logic;

   --Outputs
   signal maxOnes : out std_logic_vector(7 downto 0);
 
BEGIN
 
  -- Instantiate the Unit Under Test (UUT)
  uut: maxOnes PORT MAP (
    x => x,
    clock => clock,
    maxOnes => maxOnes
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
  proc_input: process

  begin

    --this should give maxOnes of 3
    x <= '1'; wait for 20 ns;
    x <= '0'; wait for 20 ns; 
    x <= '1'; wait for 20 ns;
    x <= '1'; wait for 20 ns; 
    x <= '0'; wait for 20 ns;
    x <= '0'; wait for 20 ns; 
    x <= '1'; wait for 20 ns;
    x <= '1'; wait for 20 ns;

    report "Simulation done." severity failure;

  end process; --end proc_input

END;
