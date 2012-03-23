library IEEE;
use IEEE.std_logic_1164.all;

entity JumpBranchUnit is
  port(i_rs_data            : in std_logic_vector(31 downto 0);
       i_PC_ALU             : in std_logic_vector(31 downto 0);
       i_imm                : in std_logic_vector(31 downto 0);
       i_instruction        : in std_logic_vector(31 downto 0);
       i_jumpRegister_ctrl  : in std_logic;
       i_branchHelper_ctrl  : in std_logic;
       i_jump_ctrl          : in std_logic;
       o_jump_rslt          : out std_logic_vector(31 downto 0));
      
end JumpBranchUnit;

architecture structure of JumpBranchUnit is



  component alu_32bit  
      port (ian_op_sel    : in std_logic_vector(2 downto 0);
            ian_A         : in std_logic_vector(31 downto 0);
            ian_B         : in std_logic_vector(31 downto 0);
            oan_result    : out std_logic_vector(31 downto 0);
            oan_overflow  : out std_logic );
  end component;       
  
  component barrel_shifter
      port(i_input        : in std_logic_vector(31 downto 0);
           i_shiftAmount  : in std_logic_vector(4 downto 0);
           i_control_L_R  : in std_logic;
           i_logical_arth : in std_logic;
           o_F            : out std_logic_vector(31 downto 0));
  end component;  
  
  signal s_jump, s_imm_shift, s_jumpRegister_rslt :  std_logic_vector(31 downto 0);
  signal s_ALU2_rslt, s_branchHelper_rslt : std_logic_vector(31 downto 0);
  signal s_ALU2_ovfl : std_logic;
 
  
  begin
  
    s_jump <= i_PC_ALU(31 downto 28) & i_instruction(25 downto 0) & "00"; 
    
    
    immshifter: barrel_shifter
      port map(i_input        => i_imm,
               i_shiftAmount  => "00010",
               i_control_L_R  => '1',
               i_logical_arth => '0',
               o_F            => s_imm_shift);
               
    
    with i_jumpRegister_ctrl select
      s_jumpRegister_rslt <= s_imm_shift when '0',
                             i_rs_data when others;
    
           
    ALU2: alu_32bit
      port map(ian_op_sel => "101",
               ian_A      => i_PC_ALU,
               ian_B      => s_jumpRegister_rslt,
               oan_result => s_ALU2_rslt,
               oan_overflow => s_ALU2_ovfl);
               
    with i_branchHelper_ctrl select
      s_branchHelper_rslt <= i_PC_ALU when '0',
                             s_ALU2_rslt when others;
        
    
    with i_jump_Ctrl select
      o_jump_rslt <= s_branchHelper_rslt when '0',
                     s_jump when others;
                     
  
  
end structure;  