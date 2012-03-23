library ieee ;
  use ieee.std_logic_1164.all ;
  use ieee.numeric_std.all ;

entity branch_helper is
  port (  out_branch : out std_logic;
          in_branch : in std_logic;
          br_cond : in std_logic_vector(2 downto 0);
          rs : in std_logic_vector(31 downto 0);
          zero : in std_logic ) ;
end entity ; -- branch_helper

architecture arch of branch_helper is
signal gtz : std_logic;
signal ez : std_logic;
signal ltz : std_logic;

-- instructions 
-- beq      000
-- bgez     0001
-- bgezal   001
-- bgtz     010
-- blez     011
-- bltz     100
-- bltzal   100
-- bne      101

begin
  gtz <= (rs >= x"00000000");
  ez <= (rs = x"00000000");
  ltz <= (rs <= x"00000000");
  
  -- beq
  -- out_branch <= '1' when in_branch = '1' AND br_cond = "000" AND zero = '1';
  
  with in_branch select
    out_branch <= '1' when '1' AND br_cond = "000" AND zero = '1', -- beq
                  '1' when '1' AND br_cond = "001" AND (gtz = '1' OR ez = '1'), --bgez / bgezal
                  '1' when '1' AND br_cond = "010" AND gtz = '1', --bgtz
                  '1' when '1' AND br_cond = "011" AND (ltz = '1' OR ez = '1')--blez
                  '1' when '1' AND br_cond = "100" AND ltz = '1', -- bltz / bltzal
                  '1' when '1' AND br_cond = "101" AND zero = '0',-- bne
                  '0' when others;
  
end architecture ; -- arch