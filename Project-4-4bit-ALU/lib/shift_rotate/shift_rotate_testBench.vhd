--READ THIS LINK:
--http://homepage.ntlworld.com/jonathan.deboynepollard/FGA/bit-shifts-in-vhdl.html
--Important bit: 

--Arithmetic and logical shifts and rotates are done with
--functions in VHDL, not operators.
--
--The problem with the operators -- sll, sla, srl, sra, rol, and rar, -- is
--that they were an afterthought, weren't specified correctly, and have been
--removed from IEEE 1076. 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY shift_rotate_testBench IS
END shift_rotate_testBench;
 
ARCHITECTURE behavior OF shift_rotate_testBench IS 
 
  -- Component Declaration for the Unit Under Test (UUT)
  COMPONENT shift_rotate

  PORT(
    A : IN  std_logic_vector(3 downto 0);
    B : IN  std_logic_vector(3 downto 0);
    op : IN std_logic_vector(2 downto 0);
    R : OUT  std_logic_vector(3 downto 0)
  );

  END COMPONENT;
    

  --Inputs
  signal A : std_logic_vector(3 downto 0) := (others => '0');
  signal B : std_logic_vector(3 downto 0) := (others => '0');
  signal op : std_logic_vector(3 downto 0) := (others => '0');

  --Outputs
  signal R : std_logic_vector(3 downto 0);
  -- No clocks detected in port list. Replace <clock> below with 
  -- appropriate port name 
 
  --constant <clock>_period : time := 10 ns;
 
BEGIN
 
  -- Instantiate the Unit Under Test (UUT)
  uut: shift_rotate PORT MAP (
          A => A,
          B => B,
          op => op,
          R => R
  );

   -- Clock process definitions
   --<clock>_process :process
   --begin
  --  <clock> <= '0';
  --  wait for <clock>_period/2;
  --  <clock> <= '1';
  --  wait for <clock>_period/2;
   --end process;
 

  -- Stimulus process
  stim_proc: process

  variable count : integer :=0;
  
  begin

    -- TEST Rotate Left    
    A <= "0000";
    B <= "0000";
    op <= "000";

    wait for 1 ns;  

    for i in 0 to 15 loop
      for j in 0 to 15 loop
        wait for 1 ns;
        if NOT(R = std_logic_vector(rotate_left(unsigned(A),to_integer(unsigned(B))))) 
        then
          assert R = std_logic_vector(rotate_left(unsigned(A),to_integer(unsigned(B)))) 
          report "R = A rol B should have been " &
          integer'image(to_integer(rotate_left(unsigned(A),to_integer(unsigned(B))))) & 
          " with A=" & integer'image(to_integer(unsigned(A))) & 
          " and B=" & integer'image(to_integer(unsigned(B))) & 
          " but instead R was " & integer'image(to_integer(unsigned(R))) 
          severity ERROR;
          count := count + 1;
        else
          --nada
        end if;
        B <= B + "0001";
      end loop;
      A <= A + "0001";
    end loop;

    -- TEST Rotate Right
    A <= "0000";
    B <= "0000";
    op <= "001";

    wait for 1 ns;

    for i in 0 to 15 loop
      for j in 0 to 15 loop
        wait for 1 ns;
        if NOT(R = std_logic_vector(rotate_right(unsigned(A),to_integer(unsigned(B))))) 
        then
          assert R = std_logic_vector(rotate_right(unsigned(A),to_integer(unsigned(B)))) 
          report "R = A rol B should have been " &
          integer'image(to_integer(rotate_right(unsigned(A),to_integer(unsigned(B))))) & 
          " with A=" & integer'image(to_integer(unsigned(A))) & 
          " and B=" & integer'image(to_integer(unsigned(B))) & 
          " but instead R was " & integer'image(to_integer(unsigned(R))) 
          severity ERROR;
          count := count + 1;
        else
          --nada
        end if;
        B <= B + "0001";
      end loop;
      A <= A + "0001";
    end loop;
   
    --testing done
    report "TEST FINISHED.";
    report "ERROR COUNT: " & integer'image(count);
      wait;
   end process;

END;
