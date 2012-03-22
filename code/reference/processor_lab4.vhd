library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;
use work.arr_32.all;

entity processor_lab4 is
  port(
    rs : in std_logic_vector(4 downto 0);
    rt : in std_logic_vector(4 downto 0);
    rd : in std_logic_vector(4 downto 0);
    clk: in std_logic;
    imm: in std_logic_vector(15 downto 0);
    sel_imm: in std_logic;
    sel_addsub: in std_logic;
    instr_store_type : in std_logic_vector(1 downto 0);
    mem_wren   : in std_logic;
    memtoreg   : in std_logic;
    sign_enable: in std_logic;
    reg_wren   : in std_logic;
    MEM_RESET  : in std_logic
    );
end processor_lab4;

architecture structure of processor_lab4 is
  component reg_file_32
    port(
      rfi_WEN : in std_logic;
      rfi_raddr1 : in std_logic_vector(4 downto 0);
      rfi_raddr2 : in std_logic_vector(4 downto 0);
      rfi_waddr : in std_logic_vector(4 downto 0);
      rfi_wdata : in std_logic_vector(31 downto 0);
      rfi_reset : in std_logic;
      rfi_CLK : in std_logic;
      rfo_rdata1 : out std_logic_vector(31 downto 0);
      rfo_rdata2 : out std_logic_vector(31 downto 0)     
    );
  end component;
  
  component add_sub
    port(
      ias_A     : in std_logic_vector(31 downto 0);
      ias_B     : in std_logic_vector(31 downto 0);
      nAdd_Sub  : in std_logic;
      oas_output: out std_logic_vector(31 downto 0);
      ALUSrc    : in std_logic;
      ias_immed : in std_logic_vector(31 downto 0)      
      );
  end component;
  
  component mem
  	generic(
  	   depth_exp_of_2 	 : integer;
			mif_filename 	   : string
			);
	 port(
	    address			 : IN STD_LOGIC_VECTOR;
			byteena			 : IN STD_LOGIC_VECTOR;
			clock			   : IN STD_LOGIC;
			data			    : IN STD_LOGIC_VECTOR;
			wren			    : IN STD_LOGIC;
			q				   : OUT STD_LOGIC_VECTOR
			);
  end component;
  
  component store_helper
    port(
        byte_addr   : in std_logic_vector(31 downto 0);
        wdata_in    : in std_logic_vector(31 downto 0);
        store_type  : in std_logic_vector(1 downto 0);
        word_address: out std_logic_vector(9 downto 0);
        byteena     : out std_logic_vector(3 downto 0);
        wdata       : out std_logic_vector(31 downto 0)
      );  
  end component;
  
  component mux_nbit
      generic(N : integer := 32);
      port(
     imux_SW : in std_logic;
     imux_A  : in std_logic_vector(N-1 downto 0);
     imux_B  : in std_logic_vector(N-1 downto 0);
     omux_E  : out std_logic_vector(N-1 downto 0)
      );
  end component;
  
  component ext_16_32
    port(
      sign_en : in std_logic;
      i_16bit  : in std_logic_vector(15 downto 0);
      o_32bit : out std_logic_vector(31 downto 0) );
  end component;
  
  component load_helper
    port(
        load_type : in std_logic_vector(1 downto 0);
        is_signed : std_logic;
        alu_out   : in std_logic_vector(31 downto 0);
        mem_out   : in std_logic_vector(31 downto 0);
        o_load_out   : out std_logic_vector(31 downto 0)
      );
  end component;
  
    signal sALU_IN_A  : std_logic_vector(31 downto 0);
    signal sALU_IN_B  : std_logic_vector(31 downto 0);
    signal sALU_OUT  : std_logic_vector(31 downto 0);
    signal sREG_DATA : std_logic_vector(31 downto 0);
    signal sMEM_OUT : std_logic_vector(31 downto 0);
    signal sMEM_ADDR : std_logic_vector(9 downto 0);
    signal sMEM_byteena : std_logic_vector(3 downto 0);
    signal sMEM_wdata : std_logic_vector(31 downto 0);
    signal signal_imm : std_logic_vector(31 downto 0);
    signal sLOAD_HELPER_OUT: std_logic_vector(31 downto 0);
  begin
    register_file: reg_file_32
      port MAP(
        rfi_WEN => reg_wren,
        rfi_raddr1 => rs,
        rfi_raddr2 => rt,
        rfi_waddr => rd,
        rfi_wdata => sREG_DATA,
        rfi_reset => MEM_RESET,
        rfi_CLK => clk,
        rfo_rdata1 => sALU_IN_A,
        rfo_rdata2 => sALU_IN_B );
     
      alu : add_sub
        port MAP(
          ias_A => sALU_IN_A,
          ias_B => sALU_IN_B,
          ias_immed => signal_imm,
          nAdd_Sub => sel_addsub,
          ALUSrc => sel_imm,
          oas_output => sALU_OUT );
      mem_unit : mem
      generic MAP (
        depth_exp_of_2 => 10,
        mif_filename => "/home/jpryan/cpre381/lab4/code/dmem.mif"
        )
        port MAP(
     	     address => sMEM_ADDR,
			     byteena => sMEM_byteena,
			     clock => clk,
			     data => sMEM_wdata,
			     wren => mem_wren,
			     q => sMEM_OUT
          );
      memory_ouput_mux : mux_nbit
        port MAP(
            imux_SW => memtoreg,
            imux_A  => sALU_OUT,
            imux_B  => sLOAD_HELPER_OUT,
            omux_E  => sREG_DATA
          );
          
      store_helper_instance : store_helper
        port MAP(
            byte_addr => sALU_OUT,
            wdata_in => sALU_IN_B, -- output of register's rdata2
            store_type => instr_store_type,
            word_address => sMEM_ADDR,
            byteena => sMEM_byteena,
            wdata => sMEM_wdata
          );
      sign_extender: ext_16_32
        port MAP(
          sign_en => '1', -- Always assuming immediates are signed.
          i_16bit => imm,
          o_32bit => signal_imm
          );
      load_helper_instance: load_helper
        port MAP(
          load_type => instr_store_type,
          is_signed => sign_enable,
          alu_out   => sALU_OUT,
          mem_out   => sMEM_OUT,
          o_load_out   => sLOAD_HELPER_OUT
          );
        
end structure;
