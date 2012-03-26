library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

--------------------------
-- Control Logic Module --
--------------------------
-- John Ryan and Juan Mozqueda

entity control is
  port( instruction         : in std_logic_vector(31 downto 0);
        alu_op              : out std_logic_vector(2 downto 0);
        alu_src             : out std_logic;
        reg_write           : out std_logic;
        mem_write           : out std_logic;
        mem_to_reg          : out std_logic;
        mem_read            : out std_logic;
        branch              : out std_logic;
        br_const_en         : out std_logic; -- new -- 
        br_const            : out std_logic; -- new --
        br_zero_should_be   : out std_logic; -- new --
        jump                : out std_logic;
        jump_reg_en         : out std_logic;
        reg_dst             : out std_logic;
        and_link            : out std_logic;
        store_type          : out std_logic_vector(1 downto 0);
        load_type           : out std_logic_vector(1 downto 0);
        load_sign_en        : out std_logic;
        alu_shift_mul_sel   : out std_logic_vector(1 downto 0);
        shift_source        : out std_logic_vector(1 downto 0);
        overflow_trap       : out std_logic;
        left_right_shift    : out std_logic;
        logic_arith_shift   : out std_logic;
        slt_unsigned        : out std_logic );
end control;

architecture structure of control is
-------------
-- Signals --
-------------
signal sHelper : std_logic_vector(28 downto 0);
signal opcode : std_logic_vector(5 downto 0);
signal funct_code : std_logic_vector(5 downto 0);

---------------
-- Structure --
---------------
begin
  
  opcode <= instruction(31 downto 26);
  funct_code <= instruction(5 downto 0);
  
    -- the following statements aren't correct right now --
  sHelper <= "1010100-00--0010-----00--0--0" when (opcode = "000000" AND funct_code = "100000") else
             "1011100-00--0000-----00--0--0" when opcode = "001000" else
             "1011100-00--0010-----00--1--0" when opcode = "001001" else
             "1011100-00--0000-----00--1--0" when opcode = "000000" AND funct_code = "100001" else
             "00000000000000000000000000000";

  alu_op <= sHelper(28 downto 26);
  alu_src <= sHelper(25);
  reg_write <= sHelper(24);
  mem_write <= sHelper(23);
  mem_to_reg <= sHelper(22);
  mem_read <= sHelper(21);
  branch <= sHelper(20);
  br_const_en <= sHelper(19); -- new --
  br_const <= sHelper(18); -- new --
  br_zero_should_be <= sHelper(17); -- new --
  jump <= sHelper(16);
  jump_reg_en <= sHelper(15);
  reg_dst <= sHelper(14);
  and_link <= sHelper(13);
  store_type <= sHelper(12 downto 11);
  load_type <= sHelper(10 downto 9);
  load_sign_en <= sHelper(8);
  alu_shift_mul_sel <=sHelper(7 downto 6);
  shift_source <= sHelper(5 downto 4);
  overflow_trap <= sHelper(3);
  left_right_shift <= sHelper(2);
  logic_arith_shift <= sHelper(1);
  slt_unsigned <= sHelper(0);
  
    -- the following statements aren't correct right now --
  sHelper <= "1010100-0---0010-----00--0--0" when opcode = "000000" AND funct_code="100000" else
             "1011100-0---0000-----00--0--0" when opcode = "001000" else
             "00000000000000000000000000000";
end structure;
