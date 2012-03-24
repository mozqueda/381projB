library IEEE;
use IEEE.std_logic_1164.all;

entity tb_JumpBranchUnit is

end tb_JumpBranchUnit;

architecture behavior of tb_JumpBranchUnit is
  
  component JumpBranchUnit
    port(i_rs_data            : in std_logic_vector(31 downto 0);
         i_PC_ALU             : in std_logic_vector(31 downto 0);
         i_imm                : in std_logic_vector(31 downto 0);
         i_instruction        : in std_logic_vector(31 downto 0);
         i_jumpRegister_ctrl  : in std_logic;
         i_branchHelper_ctrl  : in std_logic;
         i_jump_ctrl          : in std_logic;
         o_jump_rslt          : out std_logic_vector(31 downto 0)); 
    end component;
    
    signal t_rs_data, t_PC_ALU, t_imm, t_instruction : std_logic_vector(31 downto 0);
    signal t_jumpRegister_ctrl, t_branchHelper_ctrl, t_jump_ctrl : std_logic;
    signal t_jump_rslt : std_logic_vector(31 downto 0);
    signal o_expected  : std_logic_vector(31 downto 0);
    
    begin
      DUT: JumpBranchUnit
        port map(i_rs_data => t_rs_data,
                 i_PC_ALU  => t_PC_ALU,
                 i_imm     => t_imm,
                 i_instruction => t_instruction,
                 i_jumpRegister_ctrl => t_jumpRegister_ctrl,
                 i_branchHelper_ctrl => t_branchHelper_ctrl,
                 i_jump_ctrl         => t_jump_ctrl,
                 o_jump_rslt         => t_jump_rslt);
                 
    
      process begin
        
      t_rs_data   <= x"00000008";
      t_PC_ALU    <= x"00000004";  
      t_imm <= x"00000010";
      t_instruction <= x"00000000";
      t_jumpRegister_ctrl <= '1';
      t_branchHelper_ctrl <= '1';
      t_jump_ctrl <= '0';
      o_expected <= x"0000000c";
      wait for 100 ns;
      
      t_rs_data   <= x"00000008";
      t_PC_ALU    <= x"00000004";  
      t_imm <= x"00000010";
      t_instruction <= x"00000000";
      t_jumpRegister_ctrl <= '1';
      t_branchHelper_ctrl <= '0';
      t_jump_ctrl <= '0';
      o_expected <= x"00000004";
      wait for 100 ns;      
      
      t_rs_data   <= x"00000008";
      t_PC_ALU    <= x"00000004";  
      t_imm <= x"00000010";
      t_instruction <= x"00000004";
      t_jumpRegister_ctrl <= '1';
      t_branchHelper_ctrl <= '0';
      t_jump_ctrl <= '1';
      o_expected <= x"00000010";
      wait for 100 ns;    
      
      end process;
end behavior;