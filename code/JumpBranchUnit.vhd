library IEEE;
use IEEE.std_logic_1164.all;

entity JumpBranchUnit is
  port(i_rs_data            : in std_logic_vector(31 downto 0);
       i_PC_ALU             : in std_logic_vector(31 downto 0);
       i_imm                : in std_logic_vector(31 downto 0);
       i_jumpRegister_ctrl  : in std_logic;
       i_branchHelper_ctrl  : in std_logic;
       i_jump_ctrl          : in std_logic;
       o_linkhelper         : out std_logic_vector(31 downto 0));
      
end JumpBranchUnit;

architecture structure of JumpBranchUnit is


  