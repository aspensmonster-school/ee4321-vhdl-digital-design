library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--NOTE: the "diff" input comes from the output of the add_sub module.
--the way the opcodes are defined, the output is always the difference 
--of A and B if the user is requesting a comparison operation. Otherwise, 
--the output of this module will technically be undefined/wrong, but it 
--doesn't matter because we won't be selecting it for the final output.

entity shift_rotate is 
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           op : in STD_LOGIC_VECTOR (2 downto 0);
           R : out  STD_LOGIC_VECTOR (3 downto 0)
         );
end shift_rotate;

architecture Behavioral of shift_rotate is 

--signals
signal rol_R : std_logic_vector(3 downto 0);
signal ror_R : std_logic_vector(3 downto 0);
signal sll_R : std_logic_vector(3 downto 0);
signal sll_R_int : std_logic_vector(3 downto 0);
signal srl_R : std_logic_vector(3 downto 0);
signal srl_R_int : std_logic_vector(3 downto 0);
signal sra_R : std_logic_vector(3 downto 0);

signal magnitude : std_logic_vector(1 downto 0);

--if the shift increment is over four, fill in with 
--zeros for the logical by setting this flag to zero
--and anding it with the output of the logical shifter.
signal flag_if_b_geq_four : std_logic;

begin

-------------------------------------------
--Set up magnitude
--and flag
-------------------------------------------

magnitude <= B(1 downto 0);
flag_if_b_geq_four <= NOT(B(3) OR B(2));

-------------------------------------------
--Rotate Left
--not sure if this is all syntactically correct or not.
--in particular, I don't know if you can assign values 
--to bits of a vector at a time. I'm sure there is a way,
--but the syntax might be off.
-------------------------------------------

rol_mux_3: entity work.mux4_bit port map 
  (A(0), A(1), A(2), A(3), magnitude, rol_R(3));
rol_mux_2: entity work.mux4_bit port map 
  (A(3), A(0), A(1), A(2), magnitude, rol_R(2));
rol_mux_1: entity work.mux4_bit port map 
  (A(2), A(3), A(0), A(1), magnitude, rol_R(1));
rol_mux_0: entity work.mux4_bit port map 
  (A(1), A(2), A(3), A(0), magnitude, rol_R(0));

-------------------------------------------
--Rotate Right
--going to duplicate a lot of hardware for now,
--just to be on the safe side of things.
-------------------------------------------

ror_mux_3: entity work.mux4_bit port map 
  (A(2), A(1), A(0), A(3), magnitude, ror_R(3));
ror_mux_2: entity work.mux4_bit port map 
  (A(1), A(0), A(3), A(2), magnitude, ror_R(2));
ror_mux_1: entity work.mux4_bit port map 
  (A(0), A(3), A(2), A(1), magnitude, ror_R(1));
ror_mux_0: entity work.mux4_bit port map 
  (A(3), A(2), A(1), A(0), magnitude, ror_R(0));

-------------------------------------------
--Shift Left Logical
-------------------------------------------

sll_mux_3: entity work.mux4_bit port map 
  (A(0), A(1), A(2), A(3), magnitude, sll_R_int(3));
sll_mux_2: entity work.mux4_bit port map 
  ('0', A(0), A(1), A(2), magnitude, sll_R_int(2));
sll_mux_1: entity work.mux4_bit port map 
  ('0', '0', A(0), A(1), magnitude, sll_R_int(1));
sll_mux_0: entity work.mux4_bit port map 
  ('0', '0', '0', A(0), magnitude, sll_R_int(0));

sll_R(3) <= sll_R_int(3) AND flag_if_b_geq_four;
sll_R(2) <= sll_R_int(2) AND flag_if_b_geq_four;
sll_R(1) <= sll_R_int(1) AND flag_if_b_geq_four;
sll_R(0) <= sll_R_int(0) AND flag_if_b_geq_four;

-------------------------------------------
--Shift Right Logical
-------------------------------------------

srl_mux_3: entity work.mux4_bit port map 
  ('0', '0', '0', A(3), magnitude, srl_R_int(3));
srl_mux_2: entity work.mux4_bit port map 
  ('0', '0', A(3), A(2), magnitude, srl_R_int(2));
srl_mux_1: entity work.mux4_bit port map 
  ('0', A(3), A(2), A(1), magnitude, srl_R_int(1));
srl_mux_0: entity work.mux4_bit port map 
  (A(3), A(2), A(1), A(0), magnitude, srl_R_int(0));

srl_R(3) <= srl_R_int(3) AND flag_if_b_geq_four;
srl_R(2) <= srl_R_int(2) AND flag_if_b_geq_four;
srl_R(1) <= srl_R_int(1) AND flag_if_b_geq_four;
srl_R(0) <= srl_R_int(0) AND flag_if_b_geq_four;

-------------------------------------------
--Shift Right Arithmetic
--same as SRL except instead of hard-coded zeros
--we fill in the value of A(3)
-------------------------------------------

sra_mux_3: entity work.mux4_bit port map 
  (A(3), A(3), A(3), A(3), magnitude, sra_R(3));
sra_mux_2: entity work.mux4_bit port map 
  (A(3), A(3), A(3), A(2), magnitude, sra_R(2));
sra_mux_1: entity work.mux4_bit port map 
  (A(3), A(3), A(2), A(1), magnitude, sra_R(1));
sra_mux_0: entity work.mux4_bit port map 
  (A(3), A(2), A(1), A(0), magnitude, sra_R(0));

-------------------------------------------
--Output
-------------------------------------------

output: entity work.mux8 port map (rol_R, ror_R, sll_R, srl_R, sra_R, open,
open, open, op, R);

end Behavioral;

