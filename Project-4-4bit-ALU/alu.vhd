library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_4_bit is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           op : in  STD_LOGIC_VECTOR (5 downto 0);
           R : out  STD_LOGIC_VECTOR (3 downto 0);
           Cout : out  STD_LOGIC);
end alu_4_bit;

architecture Behavioral of alu_4_bit is

--these signals carry internal outputs from the different blocks for routing to
--appropriate stages (mostly the output choice mux4)
signal add_sub_zero : std_logic:='0';
signal add_sub_Cout : std_logic:='0';
signal add_sub_overflow : std_logic:='0';
signal add_sub_R : std_logic_vector (3 downto 0);
signal comparator_R: std_logic_vector (3 downto 0) := (others => '0');
signal logical_R: std_logic_vector (3 downto 0);
signal shift_rot_R: std_logic_vector (3 downto 0);

begin

--adder/subtractor unit
add_sub: entity work.cla_4_bit port map (A, B, op(3), add_sub_R,
  add_sub_Cout, add_sub_zero, add_sub_overflow);

--comparator unit
comparator: entity work.comparator port map (A, B, op(2 downto 0),
  add_sub_zero, add_sub_Cout, add_sub_overflow, add_sub_R, comparator_R(0));

--logical unit
logical: entity work.logical port map (A, B, op(1 downto 0), logical_R);

--shift/rotate unit
shift_rot: entity work.shift_rotate port map (A, B, op(2 downto 0), shift_rot_R);

--output selection mux
output_choice_mux: entity work.mux4 port map (add_sub_R, comparator_R, logical_R,
  shift_rot_R, op(5 downto 4), R);

--make sure Cout gets assigned
Cout <= add_sub_Cout;

end Behavioral;

--A note: This design is entirely combinatorial and likely purely insane. EVERY
--operation is carried out, and the output choice mux merely selects which 
--block_R to push to the ALU's "R" output. This would be a truly terrible 
--design as far as power constraints go.
