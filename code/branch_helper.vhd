library ieee ;
  use ieee.std_logic_1164.all ;
  use ieee.numeric_std.all ;

entity branch_helper is
  port (  out_branch : out std_logic;
          in_branch : in std_logic;
          br_cond : in std_logic_vector(2 downto 0);
          alu_out : in std_logic_vector(31 downto 0);
          zero : in std_logic ) ;
end entity ; -- branch_helper

architecture arch of branch_helper is

signal lt : std_logic;

signal beq : std_logic;
signal bgtz : std_logic;
signal bltz : std_logic;
signal blez : std_logic;

-- instructions 
-- beq      000
-- bgez     001
-- bgezal   001
-- bgtz     010
-- blez     011
-- bltz     100
-- bltzal   100
-- bne      101

begin
lt <= alu_out(0);

-- 
beq <= in_branch AND (NOT br_cond(0)) AND (NOT br_cond(1)) AND (NOT br_cond(2)) AND zero;
bgtz <= in_branch AND (NOT br_cond(0)) AND (br_cond(1)) AND (NOT br_cond(2)) AND zero;
bltz <= in_branch AND (br_cond(0)) AND (NOT br_cond(1)) AND (NOT br_cond(2)) AND zero;
bgez <= 
blez <= 
  out_branch <= beq OR bgtz OR bltz OR bgez OR blez;
  
  with in_branch select
    out_branch <= '1' when beq
                  '1' when '1' AND br_cond = "001" AND (lt = '0' OR zero = '1') --bgez / bgezal
                  '1' when '1' AND br_cond = "010" AND lt = '0', --bgtz
                  '1' when '1' AND br_cond = "011" AND (lt = '1' OR zero = '1')--blez
                  '1' when '1' AND br_cond = "100" AND lt = '1', -- bltz / bltzal
                  '1' when '1' AND br_cond = "101" AND NOT (alu_out = x"00000000"),-- bne
                  '0' when others;
end architecture ; -- arch