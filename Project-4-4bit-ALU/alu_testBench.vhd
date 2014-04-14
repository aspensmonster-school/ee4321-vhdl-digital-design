LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY alu_testBench IS

  --thanks to: https://groups.google.com/forum/#!topic/comp.lang.vhdl/Ap0d7bl5ExU
  function to_std_logic_vector(L: BOOLEAN) return std_logic_vector is
  begin
    if L then
      return("0001");
    else
      return("0000");
    end if;
  end function to_std_logic_vector;

END alu_testBench;
 
ARCHITECTURE behavior OF alu_testBench IS 
 
  -- Component Declaration for the Unit Under Test (UUT)
  COMPONENT alu_4_bit

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
  signal op : std_logic_vector(5 downto 0) := (others => '0');

  --Outputs
  signal R : std_logic_vector(3 downto 0);
  signal Cout : std_logic;
  -- No clocks detected in port list. Replace <clock> below with 
  -- appropriate port name 

  --constant <clock>_period : time := 10 ns;
 
BEGIN
 
  -- Instantiate the Unit Under Test (UUT)
  uut: alu_4_bit PORT MAP (
          A => A,
          B => B,
          op => op,
          R => R,
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
          integer'image(to_integer(unsigned(R))) severity ERROR;
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
          integer'image(to_integer(unsigned(R))) severity ERROR;
          count_add_sub := count_add_sub + 1;
        else
          --nada
        end if;
        B <= B + "0001";
      end loop;
      A <= A + "0001";
    end loop;

    ---------------------------
    -- Comparison
    ---------------------------

    --the comparison testing makes use of a user-defined function for converting
    --a boolean back into a std_logic_vector. it is at the top of this file where
    --the alu_testBench entity is declared.

    -- Test A >= B (signed)
    A <= "0000";
    B <= "0000";
    op <= "011001";

    wait for 1 ns;  

    for i in 0 to 15 loop
      for j in 0 to 15 loop
        wait for 1 ns;
        if NOT( R = to_std_logic_vector(to_integer(signed(A)) >= to_integer(signed(B)) ) )
        then
          assert R = to_std_logic_vector( to_integer(signed(A)) >= to_integer(signed(B)) )
          report "R = A >= B signed should have been " &
          boolean'image(to_integer(signed(A)) >= to_integer(signed(B)) ) & 
          " with A=" & integer'image(to_integer(signed(A))) & 
          " and B=" & integer'image(to_integer(signed(B))) & 
          " but instead R was " & integer'image(to_integer(unsigned(R))) 
          severity ERROR;
          count_comp := count_comp + 1;
        else
          --nada
        end if;
        B <= B + "0001";
      end loop;
      A <= A + "0001";
    end loop;

    -- Test A < B (signed)
    A <= "0000";
    B <= "0000";
    op <= "011010";

    wait for 1 ns;  

    for i in 0 to 15 loop
      for j in 0 to 15 loop
        wait for 1 ns;
        if NOT( R = std_logic_vector( to_integer(signed(A)) < to_integer(signed(B)) ) )
        then
          assert R = std_logic_vector( to_integer(signed(A)) < to_integer(signed(B)) )  
          report "R = A < B signed should have been " &
          integer'image(to_integer( to_integer(signed(A)) < to_integer(signed(B)) )) & 
          " with A=" & integer'image(to_integer(signed(A))) & 
          " and B=" & integer'image(to_integer(signed(B))) & 
          " but instead R was " & integer'image(to_integer(unsigned(R))) 
          severity ERROR;
          count_comp := count_comp + 1;
        else
          --nada
        end if;
        B <= B + "0001";
      end loop;
      A <= A + "0001";
    end loop;

    -- Test A != B
    A <= "0000";
    B <= "0000";
    op <= "011011";

    wait for 1 ns;  

    for i in 0 to 15 loop
      for j in 0 to 15 loop
        wait for 1 ns;
        if NOT( R = std_logic_vector( to_integer(unsigned(A)) /= to_integer(unsigned(B)) ) )
        then
          assert R = std_logic_vector( to_integer(unsigned(A)) /= to_integer(unsigned(B)) )  
          report "R = A != B should have been " &
          integer'image(to_integer( to_integer(unsigned(A)) /= to_integer(unsigned(B)) )) & 
          " with A=" & integer'image(to_integer(unsigned(A))) & 
          " and B=" & integer'image(to_integer(unsigned(B))) & 
          " but instead R was " & integer'image(to_integer(unsigned(R))) 
          severity ERROR;
          count_comp := count_comp + 1;
        else
          --nada
        end if;
        B <= B + "0001";
      end loop;
      A <= A + "0001";
    end loop;

    -- Test A = B
    A <= "0000";
    B <= "0000";
    op <= "011100";

    wait for 1 ns;  

    for i in 0 to 15 loop
      for j in 0 to 15 loop
        wait for 1 ns;
        if NOT( R = std_logic_vector( to_integer(unsigned(A)) = to_integer(unsigned(B)) ) )
        then
          assert R = std_logic_vector( to_integer(unsigned(A)) = to_integer(unsigned(B)) )  
          report "R = A = B should have been " &
          integer'image(to_integer( to_integer(unsigned(A)) = to_integer(unsigned(B)) )) & 
          " with A=" & integer'image(to_integer(unsigned(A))) & 
          " and B=" & integer'image(to_integer(unsigned(B))) & 
          " but instead R was " & integer'image(to_integer(unsigned(R))) 
          severity ERROR;
          count_comp := count_comp + 1;
        else
          --nada
        end if;
        B <= B + "0001";
      end loop;
      A <= A + "0001";
    end loop;

    -- Test A >= B (unsigned)
    A <= "0000";
    B <= "0000";
    op <= "011101";

    wait for 1 ns;  

    for i in 0 to 15 loop
      for j in 0 to 15 loop
        wait for 1 ns;
        if NOT( R = std_logic_vector( to_integer(unsigned(A)) >= to_integer(unsigned(B)) ) )
        then
          assert R = std_logic_vector( to_integer(unsigned(A)) >= to_integer(unsigned(B)) )  
          report "R = A >= B unsigned should have been " &
          integer'image(to_integer( to_integer(unsigned(A)) >= to_integer(unsigned(B)) )) & 
          " with A=" & integer'image(to_integer(unsigned(A))) & 
          " and B=" & integer'image(to_integer(unsigned(B))) & 
          " but instead R was " & integer'image(to_integer(unsigned(R))) 
          severity ERROR;
          count_comp := count_comp + 1;
        else
          --nada
        end if;
        B <= B + "0001";
      end loop;
      A <= A + "0001";
    end loop;

    -- Test A < B (unsigned)
    A <= "0000";
    B <= "0000";
    op <= "011110";

    wait for 1 ns;  

    for i in 0 to 15 loop
      for j in 0 to 15 loop
        wait for 1 ns;
        if NOT( R = std_logic_vector( to_integer(unsigned(A)) < to_integer(unsigned(B)) ) )
        then
          assert R = std_logic_vector( to_integer(unsigned(A)) < to_integer(unsigned(B)) )  
          report "R = A < B unsigned should have been " &
          integer'image(to_integer( to_integer(unsigned(A)) < to_integer(unsigned(B)) )) & 
          " with A=" & integer'image(to_integer(unsigned(A))) & 
          " and B=" & integer'image(to_integer(unsigned(B))) & 
          " but instead R was " & integer'image(to_integer(unsigned(R))) 
          severity ERROR;
          count_comp := count_comp + 1;
        else
          --nada
        end if;
        B <= B + "0001";
      end loop;
      A <= A + "0001";
    end loop;

    ---------------------------
    -- Logical
    ---------------------------

    -- Test A NOR B
    A <= "0000";
    B <= "0000";
    op <= "10XX00";

    wait for 1 ns;  

    for i in 0 to 15 loop
      for j in 0 to 15 loop
        wait for 1 ns;
        if NOT( R = std_logic_vector( A NOR B) )
        then
          assert R = std_logic_vector(A NOR B )
          report "R = A NOR B should have been " &
          integer'image(to_integer(A NOR B)) & 
          " with A=" & integer'image(to_integer(unsigned(A))) & 
          " and B=" & integer'image(to_integer(unsigned(B))) & 
          " but instead R was " & integer'image(to_integer(unsigned(R))) 
          severity ERROR;
          count_logic := count_logic + 1;
        else
          --nada
        end if;
        B <= B + "0001";
      end loop;
      A <= A + "0001";
    end loop;

    -- Test A AND B
    A <= "0000";
    B <= "0000";
    op <= "10XX01";

    wait for 1 ns;  

    for i in 0 to 15 loop
      for j in 0 to 15 loop
        wait for 1 ns;
        if NOT( R = std_logic_vector( A AND B) )
        then
          assert R = std_logic_vector(A AND B )
          report "R = A AND B should have been " &
          integer'image(to_integer(A AND B)) & 
          " with A=" & integer'image(to_integer(unsigned(A))) & 
          " and B=" & integer'image(to_integer(unsigned(B))) & 
          " but instead R was " & integer'image(to_integer(unsigned(R))) 
          severity ERROR;
          count_logic := count_logic + 1;
        else
          --nada
        end if;
        B <= B + "0001";
      end loop;
      A <= A + "0001";
    end loop;

    -- Test A OR B
    A <= "0000";
    B <= "0000";
    op <= "10XX10";

    wait for 1 ns;  

    for i in 0 to 15 loop
      for j in 0 to 15 loop
        wait for 1 ns;
        if NOT( R = std_logic_vector( A OR B) )
        then
          assert R = std_logic_vector(A OR B )
          report "R = A OR B should have been " &
          integer'image(to_integer(A OR B)) & 
          " with A=" & integer'image(to_integer(unsigned(A))) & 
          " and B=" & integer'image(to_integer(unsigned(B))) & 
          " but instead R was " & integer'image(to_integer(unsigned(R))) 
          severity ERROR;
          count_logic := count_logic + 1;
        else
          --nada
        end if;
        B <= B + "0001";
      end loop;
      A <= A + "0001";
    end loop;

    -- Test A XOR B
    A <= "0000";
    B <= "0000";
    op <= "10XX11";

    wait for 1 ns;  

    for i in 0 to 15 loop
      for j in 0 to 15 loop
        wait for 1 ns;
        if NOT( R = std_logic_vector( A XOR B) )
        then
          assert R = std_logic_vector(A XOR B )
          report "R = A XOR B should have been " &
          integer'image(to_integer(A XOR B)) & 
          " with A=" & integer'image(to_integer(unsigned(A))) & 
          " and B=" & integer'image(to_integer(unsigned(B))) & 
          " but instead R was " & integer'image(to_integer(unsigned(R))) 
          severity ERROR;
          count_logic := count_logic + 1;
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
          count_shift_rot := count_shift_rot + 1;
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
          count_shift_rot := count_shift_rot + 1;
        else
          --nada
        end if;
        B <= B + "0001";
      end loop;
      A <= A + "0001";
    end loop;

    -- TEST Shift Left Logical
    A <= "0000";
    B <= "0000";
    op <= "11X010";

    wait for 1 ns;

    for i in 0 to 15 loop
      for j in 0 to 15 loop
        wait for 1 ns;
        if NOT(R = std_logic_vector(shift_left(unsigned(A),to_integer(unsigned(B))))) 
        then
          assert R = std_logic_vector(shift_left(unsigned(A),to_integer(unsigned(B)))) 
          report "R = A sll B should have been " &
          integer'image(to_integer(shift_left(unsigned(A),to_integer(unsigned(B))))) & 
          " with A=" & integer'image(to_integer(unsigned(A))) & 
          " and B=" & integer'image(to_integer(unsigned(B))) & 
          " but instead R was " & integer'image(to_integer(unsigned(R))) 
          severity ERROR;
          count_shift_rot := count_shift_rot + 1;
        else
          --nada
        end if;
        B <= B + "0001";
      end loop;
      A <= A + "0001";
    end loop;

    -- TEST Shift Right Logical
    A <= "0000";
    B <= "0000";
    op <= "11X011";

    wait for 1 ns;

    for i in 0 to 15 loop
      for j in 0 to 15 loop
        wait for 1 ns;
        if NOT(R = std_logic_vector(shift_right(unsigned(A),to_integer(unsigned(B))))) 
        then
          assert R = std_logic_vector(shift_right(unsigned(A),to_integer(unsigned(B)))) 
          report "R = A srl B should have been " &
          integer'image(to_integer(shift_right(unsigned(A),to_integer(unsigned(B))))) & 
          " with A=" & integer'image(to_integer(unsigned(A))) & 
          " and B=" & integer'image(to_integer(unsigned(B))) & 
          " but instead R was " & integer'image(to_integer(unsigned(R))) 
          severity ERROR;
          count_shift_rot := count_shift_rot + 1;
        else
          --nada
        end if;
        B <= B + "0001";
      end loop;
      A <= A + "0001";
    end loop;

    -- TEST Shift Right Arithmetic
    A <= "0000";
    B <= "0000";
    op <= "11X011";

    wait for 1 ns;

    for i in 0 to 15 loop
      for j in 0 to 15 loop
        wait for 1 ns;
        if NOT(R = std_logic_vector(shift_right(signed(A),to_integer(unsigned(B))))) 
        then
          assert R = std_logic_vector(shift_right(signed(A),to_integer(unsigned(B)))) 
          report "R = A sra B should have been " &
          integer'image(to_integer(shift_right(signed(A),to_integer(unsigned(B))))) & 
          " with A=" & integer'image(to_integer(unsigned(A))) & 
          " and B=" & integer'image(to_integer(unsigned(B))) & 
          " but instead R was " & integer'image(to_integer(unsigned(R))) 
          severity ERROR;
          count_shift_rot := count_shift_rot + 1;
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
