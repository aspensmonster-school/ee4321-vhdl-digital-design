--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:15:53 02/04/2014
-- Design Name:   
-- Module Name:   E:/EE4321-VHDL/Project-1/testBench.vhd
-- Project Name:  Project-1
-- Target Device:  
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testBench IS
END testBench;
 
ARCHITECTURE behavior OF testBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT bcd_xs3
    PORT(
         X : IN std_logic_vector(3 downto 0);
			Y : OUT std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   --signal X : std_logic_vector := "0000";
   --signal X2 : std_logic := '0';
   --signal X1 : std_logic := '0';
   --signal X0 : std_logic := '0';

 	--Outputs
   --signal Y : std_logic_vector;
   --signal Y2 : std_logic;
   --signal Y1 : std_logic;
   --signal Y0 : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: bcd_xs3 PORT MAP (
          --X(3) => X(3),
          --X(2) => X(2),
          --X(1) => X(1),
          --X(0) => X(0),
          --Y(3) => Y(3),
          --Y(2) => Y(2),
          --Y(1) => Y(1),
          --Y(0) => Y(0)
			 X => X,
			 Y => Y
        );

   -- Clock process definitions
   --<clock>_process :process
   --begin
		--<clock> <= '0';
		--wait for <clock>_period/2;
		--<clock> <= '1';
		--wait for <clock>_period/2;
   --end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;	

      --wait for <clock>_period*10;

      -- insert stimulus here 
		--X3 <= '1';
		--X2 <= '0';
		--X1 <= '0';
		--X0 <= '1';
		
		X <= "0000";
		 
		wait for 10 ns;
		
		assert Y = "0011" report "X = 0000 gives wrong answer" severity Error;
		

   end process;

END;
