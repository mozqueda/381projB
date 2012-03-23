library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

-------------------
-- A 32-Bit ALU  --
-------------------
-- By Juan Mozqueda and John Ryan

entity alu_32bit is
  port( ian_op_sel    : in std_logic_vector(2 downto 0);
        ian_A         : in std_logic_vector(31 downto 0);
        ian_B         : in std_logic_vector(31 downto 0);
        oan_result    : out std_logic_vector(31 downto 0);
        oan_overflow  : out std_logic;
        oan_zero      : out std_logic );
end alu_32bit;

architecture structure of alu_32bit is

----------------
-- Components --
----------------
  component alu_1bit
    port(
      ia1_op_sel  : in std_logic_vector(2 downto 0);
      ia1_A : in std_logic;
      ia1_B : in std_logic;
      ia1_cin : in std_logic;
      ia1_less: in std_logic;
      oa1_result  : out std_logic;
      oa1_cout  : out std_logic );
  end component;
  
  component alu_1bit_last
    port(
      ia1_op_sel  : in std_logic_vector(2 downto 0);
      ia1_A : in std_logic;
      ia1_B : in std_logic;
      ia1_cin : in std_logic;
      ia1_less: in std_logic;
      oa1_result  : out std_logic;
      oa1_cout : out std_logic;
      oa1_set  : out std_logic );
  end component;
  
  component xor2
    port(i_A  : in std_logic;
         i_B  : in std_logic;
         o_F  : out std_logic );
  end component;
-------------
-- Signals --
-------------
signal sCARRY : std_logic_vector(32 downto 0);
signal sSet : std_logic; -- for slt operation
signal sCin : std_logic;
---------------
-- Structure --
---------------
begin
  
  oan_overflow <= sCARRY(30) XOR sCARRY(31);
  
  -- set zero output
  with oan_result select
    zero <= '1' when x"00000000",
            '0' when others;

  -- set sCin when subtracting (adding one)
  with ian_op_sel select
    sCin <= '1' when "110" ,-- for subtraction
            '1' when "111" ,-- for slt (also subtraction)
            '0' when others;
            
  -- First 1-bit ALU --
  -- NOTE: sCARRY(0) is the OUTPUT of the first 1-bit ALU
  alu1: alu_1bit
    port MAP(
        ia1_op_sel => ian_op_sel,
        ia1_A => ian_A(0),
        ia1_B => ian_B(0),
        ia1_cin => sCin,
        ia1_less => sSet,
        oa1_result => oan_result(0),
        oa1_cout => sCARRY(0) );
        
  -- Middle 1-bit ALUs --
  G1: for i in 1 to 30 generate
    alu1: alu_1bit
    port MAP(
        ia1_op_sel => ian_op_sel,
        ia1_A => ian_A(i),
        ia1_B => ian_B(i),
        ia1_cin => sCARRY(i-1),
        ia1_less => '0',
        oa1_result => oan_result(i),
        oa1_cout => sCARRY(i) );
  end generate;
  
  -- Last 1-bit ALU --
  alu_last: alu_1bit_last
    port MAP(
      ia1_op_sel => ian_op_sel,
      ia1_A => ian_A(31),
      ia1_B => ian_B(31),
      ia1_cin => sCARRY(30),
      ia1_less => '0',
      oa1_result => oan_result(31),
      oa1_cout => sCARRY(31),
      oa1_set => sSet );
      
end structure;