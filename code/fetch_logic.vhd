library IEEE;
use IEEE.std_logic_1164.all;

--------------------------------
-- Upper Section of processor --
--------------------------------
-- By Juan Mozqueda and John Ryan --


entity fetch_logic is
  port(i_CLK                : in std_logic;
       i_reset              : in std_logic;
       i_jump_rslt          : in std_logic_vector(31 downto 0);
       o_PC_ALU_rslt        : out std_logic_vector(31 downto 0);
       o_instruction        : out std_logic_vector(31 downto 0));
end fetch_logic;

architecture structure of fetch_logic is
  

  component reg
      port (ireg_CLK     : in std_logic;
            ireg_RST     : in std_logic;
            ireg_WE      : in std_logic;
            ireg_D       : in std_logic_vector(31 downto 0);
            oreg_Q       : out std_logic_vector(31 downto 0));
  end component;

  
  component store_helper
      port(byte_addr    : in std_logic_vector(31 downto 0);
           wdata_in     : in std_logic_vector(31 downto 0);
           store_type   : in std_logic_vector(1 downto 0);
           word_address : out std_logic_vector(9 downto 0);
           byteena      : out std_logic_vector(3 downto 0);
           wdata        : out std_logic_vector(31 downto 0));      
  end component;
  
  component alu_32bit  
      port (ian_op_sel    : in std_logic_vector(2 downto 0);
            ian_A         : in std_logic_vector(31 downto 0);
            ian_B         : in std_logic_vector(31 downto 0);
            oan_result    : out std_logic_vector(31 downto 0);
            oan_overflow  : out std_logic );
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
    
  signal s_PC_out, s_wData  :  std_logic_vector(31 downto 0);
  signal s_PC_ALU_ovfl      : std_logic;
  signal s_byteena            : std_logic_vector(3 downto 0);
  signal s_address          : std_logic_vector(9 downto 0);
  
  -- End of signal declaration --
    
  begin
    PC: reg
      port map(ireg_CLK =>  i_CLK,
               ireg_RST =>  i_reset,
               ireg_WE  =>  '1',
               ireg_D   =>  i_jump_rslt,
               oreg_Q   =>  s_PC_out);
               
    PC_ALU: alu_32bit
      port map(ian_op_sel => "101",
               ian_A      => s_PC_out,
               ian_B      => x"00000004",
               oan_result => o_PC_ALU_rslt,          
               oan_overflow => s_PC_ALU_ovfl);
               
    dstore: store_helper
      port map(byte_addr => s_PC_out,
               wdata_in  => x"00000000",
               store_type => "10",
               word_address => s_address,
               byteena  => s_byteena,
               wdata => s_wData);
    
    inst_mem: mem
    generic map(depth_exp_of_2 => 10,
              mif_filename => "imem.mif")  
    port map(address => s_address,
             byteena => s_byteena,
             clock   => '0',
             data    => s_wData,
             wren    => '0',
             q       => o_instruction);               
       
end structure;
  
    