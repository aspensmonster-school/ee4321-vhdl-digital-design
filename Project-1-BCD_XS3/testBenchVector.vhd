--------------------------------------------------------------------------------
-- Company: Texas State University
-- Engineer: Preston Maness
--
-- Create Date:   15:20:39 02/11/2014
-- Design Name:   BCD_XS3
-- Module Name:   /home/preston/Dropbox/EE4321-VHDL/Project-1/testBenchVector.vhd
-- Project Name:  BCD_XS3
-- Target Device:  Spartan 3E Starter Dev Board
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: bcd_xs3
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testBenchVector IS
END testBenchVector;
 
ARCHITECTURE behavior OF testBenchVector IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT bcd_xs3
    PORT(
         X : IN  std_logic_vector(3 downto 0);
         Y : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal X : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Y : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: bcd_xs3 PORT MAP (
          X => X,
          Y => Y
        );

   -- Clock process definitions
   --<clock>_process :process
   --begin
	--	<clock> <= '0';
	--	wait for <clock>_period/2;
	--	<clock> <= '1';
	--	wait for <clock>_period/2;
   --end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 5 ns
      wait for 5 ns;	

      --wait for <clock>_period*10;

      -- insert stimulus here 

		--X <= "0000";
		
		for i in 0 to 9 loop
		   X <= std_logic_vector(to_unsigned(i, 4));
			wait for 5 ns;
			assert Y = (X + "0011") report "wrong Y-value for X-value: " & 
			integer'image(i) severity Error;		
		end loop;
		
      wait for 5 ns;
		
   end process;

END;