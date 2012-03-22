library IEEE;
use IEEE.std_logic_1164.all;

entity fetch_logic is
  port(i_imm                : in std_logic_vector(31 downto 0);
       i_rs_data            : in std_logic_vector(31 downto 0);
       i_jump_register      : in std_logic;
       i_branch_ctrl_rslt   : in std_logic;
       i_jump_ctrl          : in std_logic;
       i_reset              : in std_logic;
       i_CLK                : in std_logic;
       o_link_helper        : out std_logic_vector(31 downto 0));
end fetch_logic;

architecture structure of fetch_logic is
  

  component reg
      port (ireg_CLK     : in std_logic;
            ireg_RST     : in std_logic;
            ireg_WE      : in std_logic;
            ireg_D       : in std_logic_vector(31 downto 0);
            oreg_Q       : out std_logic_vector(31 downto 0));
  end component;
  
  
  component alu_32bit  
      port (ian_op_sel    : in std_logic_vector(2 downto 0);
            ian_A         : in std_logic_vector(31 downto 0);
            ian_B         : in std_logic_vector(31 downto 0);
            oan_result    : out std_logic_vector(31 downto 0);
            oan_overflow  : out std_logic );
  end component;
  
  component mux_nbit
      port (imux_SW : in std_logic;
            imux_A  : in std_logic_vector(31 downto 0);
            imux_B  : in std_logic_vector(31 downto 0);
            omux_E  : out std_logic_vector(31 downto 0));
  end component;          
  
  component barrel_shifter
      port(i_input        : in std_logic_vector(31 downto 0);
           i_shiftAmount  : in std_logic_vector(4 downto 0);
           i_control_L_R  : in std_logic;
           i_logical_arth : in std_logic;
           o_F            : out std_logic_vector(31 downto 0));
  end component;         
  
  component mem
      generic(depth_exp_of_2 	: integer;
            mif_filename: string);
    port(address :  in std_logic_vector;
         byteena :  in std_logic_vector;
         clock   :  in std_logic;
         data    :  in std_logic_vector;
         wren    :  in std_logic;
         q       :  out std_logic_vector);   	
  end component;
  
  -- Declare Signals --
  
  signal s_PC_out, s_instruction, s_PC_ALU_out, s_jump, s_imm_shift, s_jumpRegiser_rslt :  std_logic_vector(31 downto 0);
  signal s_PC_ALU_ovfl : std_logic;
 
  
  
  -- End of signal declaration --
    
  begin
    PC: reg
      port map(ireg_CLK =>  i_CLK,
               ireg_RST =>  i_reset,
               ireg_WE  =>  '1',
               ireg_D   =>  ,
               oreg_Q   =>  s_PC_out);
               
    PC_ALU: alu_32bit
      port map(ian_op_sel => "101",
               ian_A      => s_PC_out,
               ian_B      => s_PC_out,
               oan_result => s_PC_ALU_out,          
               oan_overflow => s_PC_ALU_ovfl);
               
    inst_mem: mem
    generic map(depth_exp_of_2 => 10,
              mif_filename => "imem.mif")  
    port map(address => s_PC_out,
             byteena => x"F",
             clock   => '0',
             data    => x"00000000",
             wren    => '0',
             q       => s_instruction);               
    
    s_jump <= s_PC_ALU_out(31 downto 28) & s_instruction(25 downto 0) & "00"; 
    
    
    immshifter: barrel_shifter
      port map(i_input        => i_imm,
               i_shiftAmount  => "10",
               i_control_L_R  => '1',
               i_logical_arth => '0',
               o_F            => s_imm_shift);
               
    mux1: mux_nbit
      port map(imux_SW => i_jump_register,
               imux_A  => s_imm_shift,
               imux_B  => i_rs_data,
               omux_E  =>            
    
    ALU2: alu_32bit
      port map(ian_op_sel => "101",
               ian_A      => s_PC_ALU_out,
               ian_B      => 
    
    
end structure;
  
    