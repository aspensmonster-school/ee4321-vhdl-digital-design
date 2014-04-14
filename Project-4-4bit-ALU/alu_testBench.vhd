LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY cla_4_bit_testBench IS
END cla_4_bit_testBench;
 
ARCHITECTURE behavior OF alu_testBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
  COMPONENT alu

  PORT(
        A : IN  std_logic_vector(3 downto 0);
        B : IN  std_logic_vector(3 downto 0);
        op : IN  std_logic_vector(5 downto 0);
        R : OUT  std_logic_vector(3 downto 0);
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
  uut: cla_4_bit PORT MAP (
          A => A,
          B => B,
          Cin => Cin,
          Sum => Sum,
          Cout => Cout
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

  variable count_add_sub : integer :=0;
  variable count_comp : integer :=0;
  variable count_logic : integer :=0;
  variable count_shift_rot : integer :=0;

  begin

    ---------------------------
    -- Adder Subtractor    
    ---------------------------

     -- TEST ADDER FUNCTIONALITY
    A <= "0000";
    B <= "0000";
    op <= "000XXX";

    wait for 1 ns;  

    for i in 0 to 15 loop
      for j in 0 to 15 loop
        wait for 1 ns;
        if NOT(R = (A+B)) then
          assert R = (A + B) report "R should have been " &
          integer'image(to_integer(unsigned((A+B)))) & " with A=" &
          integer'image(to_integer(unsigned(A))) & " and B=" &
          integer'image(to_integer(unsigned(B))) & " but instead R was " &
          integer'image(to_integer(unsigned(Sum))) severity ERROR;
          count_add_sub := count_add_sub + 1;
        else
          --nada
        end if;
        B <= B + "0001";
      end loop;
      A <= A + "0001";
    end loop;
    
    -- TEST SUBTRACTOR FUNCTIONALITY
    A <= "0000";
    B <= "0000";
    op <= "001XXX";

    wait for 1 ns;  

    for i in 0 to 15 loop
      for j in 0 to 15 loop
        wait for 1 ns;
        if NOT(R = (A-B)) then
          assert R = (A - B) report "R should have been " &
          integer'image(to_integer(unsigned((A-B)))) & " with A=" &
          integer'image(to_integer(unsigned(A))) & " and B=" &
          integer'image(to_integer(unsigned(B))) & " but instead R was " &
          integer'image(to_integer(unsigned(Sum))) severity ERROR;
          count_add_sub := count_add_sub + 1;
        else
          --nada
        end if;
        B <= B + "0001";
      end loop;
      A <= A + "0001";
    end loop;

    ---------------------------
    -- Shift Rotate
    ---------------------------

    -- TEST Rotate Left    
    A <= "0000";
    B <= "0000";
    op <= "11X000";

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
    op <= "11X001";

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

    ---------------------------
    -- Testing Complete.
    ---------------------------

    -- Spit out error reports
    report "TEST FINISHED.";
    report "ERROR COUNT add_sub: " & integer'image(count_add_sub);
    report "ERROR COUNT comparator: " & integer'image(count_comp);
    report "ERROR COUNT logical/bitwise: " & integer'image(count_logic);
    report "ERROR COUNT shift_rotate: " & integer'image(count_shift_rot);

    wait;

  end process;

END;
