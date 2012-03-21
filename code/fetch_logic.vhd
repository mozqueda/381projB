library IEEE;
use IEEE.std_logic_1164.all;

entity fetch_logic is
  port(i_branch_ctrl_helper : in std_logic;
       i_imm_shift          : in std_logic_vector(31 downto 0);
       i_rs_data            : in std_logic_vector(31 downto 0);
       i_jump_register      : in std_logic;
       i_branch_ctrl_rslt   : in std_logic;
       i_jump_ctrl          : in std_logic;
       o_link_helper        :  out std_logic_vector(31 downto 0);
end fetch_logic;

architecture structure of fetch_logic is
  

  component reg
      port (ireg_CLK     : in std_logic;
            ireg_RST     : in std_logic;
            ireg_WE      : in std_logic;
            ireg_D       : in std_logic_vector(N-1 downto 0);
            oreg_Q       : out std_logic_vector(N-1 downto 0));
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
            imux_A  : in std_logic_vector(N-1 downto 0);
            imux_B  : in std_logic_vector(N-1 downto 0);
            omux_E  : out std_logic_vector(N-1 downto 0));
  end component;          
  
  component barrel_shifter
      port(i_input        : in std_logic_vector(31 downto 0);
           i_shiftAmount  : in std_logic_vector(4 downto 0);
           i_control_L_R  : in std_logic;
           i_logical_arth : in std_logic;
           o_F            : out std_logic_vector(31 downto 0));
  end component;         
  
  begin
    
end structure;
  
    