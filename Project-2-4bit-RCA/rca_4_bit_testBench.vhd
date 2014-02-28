--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:38:16 02/12/2014
-- Design Name:   
-- Module Name:   /home/preston/Dropbox/EE4321-VHDL/Project-2-4bit-adder/rca_4_bit_testBench.vhd
-- Project Name:  Project-2-4bit-adder
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: rca_4_bit
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
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY rca_4_bit_testBench IS
END rca_4_bit_testBench;
 
ARCHITECTURE behavior OF rca_4_bit_testBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT rca_4_bit
    PORT(
         A : IN  std_logic_vector(3 downto 0);
         B : IN  std_logic_vector(3 downto 0);
         Cin : IN  std_logic;
         Sum : OUT  std_logic_vector(3 downto 0);
         Cout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(3 downto 0) := (others => '0');
   signal B : std_logic_vector(3 downto 0) := (others => '0');
   signal Cin : std_logic := '0';

 	--Outputs
   signal Sum : std_logic_vector(3 downto 0);
   signal Cout : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: rca_4_bit PORT MAP (
          A => A,
          B => B,
          Cin => Cin,
          Sum => Sum,
          Cout => Cout
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
	variable count : integer :=0;
   begin
		
		A <= "0000";
		B <= "0000";
		
		-- TEST ADDER FUNCTIONALITY
		Cin <= '0';
      wait for 1 ns;	

		for i in 0 to 15 loop
			for j in 0 to 15 loop
				wait for 1 ns;
				if NOT(Sum = (A+B)) then
					assert Sum = (A + B) report "Sum should have been " &
					integer'image(to_integer(unsigned((A+B)))) & " with A=" &
					integer'image(to_integer(unsigned(A))) & " and B=" &
					integer'image(to_integer(unsigned(B))) & " but instead Sum was " &
					integer'image(to_integer(unsigned(Sum))) severity ERROR;
					count := count + 1;
				else
					--nada
				end if;
				B <= B + "0001";
			end loop;
			A <= A + "0001";
		end loop;
		
		-- TEST SUBTRACTOR FUNCTIONALITY
		Cin <= '1';
      wait for 1 ns;	

		for i in 0 to 15 loop
			for j in 0 to 15 loop
				wait for 1 ns;
				if NOT(Sum = (A-B)) then
					assert Sum = (A - B) report "Sum should have been " &
					integer'image(to_integer(unsigned((A-B)))) & " with A=" &
					integer'image(to_integer(unsigned(A))) & " and B=" &
					integer'image(to_integer(unsigned(B))) & " but instead Sum was " &
					integer'image(to_integer(unsigned(Sum))) severity ERROR;
					count := count + 1;
				else
					--nada
				end if;
				B <= B + "0001";
			end loop;
			A <= A + "0001";
		end loop;

      --wait for <clock>_period*10;

      -- insert stimulus here 
		report "TEST FINISHED.";
		report "ERROR COUNT: " & integer'image(count);
      wait;
   end process;

END;
