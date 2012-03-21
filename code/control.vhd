library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

--------------------------
-- Control Logic Module --
--------------------------
-- John Ryan and Juan Mozqueda

entity control is
  port( instruction : in std_logic_vector(31 downto 0);
        alu_op : out std_logic_vector(2 downto 0);
        alu_src : out std_logic;
        reg_write : out std_logic;
        mem_write : out std_logic;
        mem_to_reg : out std_logic;
        mem_read : out std_logic;
        branch : out std_logic;
        branch_condition : out std_logic_vector(2 downto 0);
        jump : out std_logic;
        jump_reg_en : out std_logic;
        reg_dst : out std_logic;
        and_link : out std_logic;
        store_type : out std_logic_vector(1 downto 0);
        load_type : out std_logic_vector(1 downto 0);
        load_sign_en : out std_logic;
        alu_shift_mul_sel : out std_logic_vector(1 downto 0);
        shift_source : out std_logic_vector(1 downto 0);
        overflow_trap : out std_logic;
        left_right_shift : out std_logic;
        logic_arith_shift : out std_logic;
        slt_unsigned : out std_logic
    );
end control;

architecture structure of control is
-------------
-- Signals --
-------------
signal sHelper : std_logic_vector(28 downto 0);
---------------
-- Structure --
---------------
begin
  alu_op <= sHelper(2 downto 0);
end structure;