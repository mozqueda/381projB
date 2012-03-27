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
signal rt : std_logic_vector(4 downto 0);

---------------
-- Structure --
---------------
begin
  
  opcode <= instruction(31 downto 26);
  funct_code <= instruction(5 downto 0);
  rt <= instruction(20 downto 16);
  
    -- the following statements aren't correct right now --
  sHelper <= 
              -- add
              "1010100-00--0010-----00--0--0" when (opcode = "000000" and funct_code = "100000") else
              
              -- addi
              "1011100-00--0000-----00--0--0" when opcode = "001000" else
             
              -- addiu
              "1011100-00--0000-----00--1--0" when opcode = "001001" else
             
              -- addu
              "1011100-00--0000-----00--1--0" when (opcode = "000000" AND funct_code = "100001") else
             
              -- and
              "0000100-00--0010-----00--0--0" when (opcode = "000000" AND funct_code = "100010") else
              
              --andi
              "0001100-00--0000-----00--0--0" when opcode = "001100" else
              
              -- beq
              "110000--10-100-0-----00--0--0" when opcode = "000100" else
              
              -- bgez
              "111000--110100-0---------0--0" when (opcode = "000001" AND rt = "00001") else
              
              -- bgezal
              "111010--110100-1---------0--0" when (opcode = "000001" AND rt = "10001") else
              
              -- bgtz
              "111000--111000-0---------0--0" when opcode = "000111" else -- AND rt = "00000"?
              
              -- blez
              "111000--111000-0---------0--0" when opcode = "000110" else -- AND rt = "00000"?
              
              -- bltz
              "111000--110100-0---------0--0" when (opcode = "000001" AND rt = "00000") else
              
              -- bltzal
              "111010--110100-1---------0--0" when (opcode = "000001" AND rt = "00000") else
              
              -- bne
              "110000--10-000-0-----00--0--0" when opcode = "000101" else
              
              -- j
              "----00--00--10-0---------0--0" when opcode = "000010" else
              
              -- jal
              "----10--00--10-1---------0--0" when opcode = "000011" else
              
              -- jalr
              "----00--00--11-1---------0--0" when (opcode = "000000" AND funct_code = "001001") else
              
              -- jr
              "----00--00--11-0---------0--0" when (opcode = "000000" AND funct_code = "001000") else
              
              -- lb
              "1011101100--00000000100--0--0" when (opcode = "000000" AND funct_code = "001000") else
              
              -- lbu
              "1011101100--00000000000--0--0" when opcode = "100100" else
              
              -- lh
              "1011101100--00000101100--0--0" when opcode = "100001" else
              
              -- lhu
              "1011101100--00000101000--0--0" when opcode = "100101" else
              
              -- lui
              "---1100-00--0010-----01100000" when opcode = "001111" else
              
              -- lw
              "1011101100--00001010-00--0--0" when opcode = "100011" else
              
              -- mul
              "---0100000--0010-----10--0--0" when (opcode = "011100" AND funct_code = "000010") else
              
              -- nor
              "0110100000--0010-----00--0--0" when (opcode = "000000" AND funct_code = "100111") else
              
              -- or
              "0100100-00--0010-----00--0--0" when (opcode = "100101" AND funct_code = "100101") else
              
              -- ori
              "0101100-00--0000-----00--0--0" when opcode = "001101" else
              
              -- sb
              "101101--00--000000---00--0--0" when opcode = "101000" else
              
              -- sh
              "101101--00--000001---00--0--0" when opcode = "101000" else
              
              -- sll
              "----100000--0010-----01010000" when (opcode = "000000" AND funct_code = "000000") else
              
              -- sllv
              "----100000--0010-----01000000" when (opcode = "000000" AND funct_code = "000100") else
              
              -- slt
              "1110100000--0010-----00--0--0" when (opcode = "000000" AND funct_code = "101010") else
              
              -- slti
              "1111100000--0000-----00--0--0" when opcode = "001010" else
              
              -- sltiu
              "1111100000--0000-----00--0--1" when opcode = "001011" else
              
              -- sltu
              "1110100000--0010-----00--0--1" when (opcode = "000000" AND funct_code = "101011") else
              
              -- sra
              "----100000--0010-----01010110" when (opcode = "000000" AND funct_code = "000011") else
              
              -- srav
              "----100000--0010-----01000110" when (opcode = "000000" AND funct_code = "000111") else
              
              -- srl
              "----100000--0010-----01010100" when (opcode = "000000" AND funct_code = "000010") else
              
              -- srlv
              "----100000--0010-----01000100" when (opcode = "000000" AND funct_code = "000110") else
              
              -- sub
              "1100100000--0010-----00--0--0" when (opcode = "000000" AND funct_code = "100010") else
              
              -- subu
              "1100100000--0010-----00--1--0" when (opcode = "000000" AND funct_code = "100101") else
              
              -- sw
              "101101--00--000010---00--0--0" when opcode = "101011" else
              
              -- xor
              "1000100000--0010-----00--0--0" when (opcode = "000000" AND funct_code = "100110") else
              
              -- xori
              "1001100-00--0000-----00--0--0" when opcode = "001110" else 
              
              
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
  

end structure;
