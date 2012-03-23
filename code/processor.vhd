library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity processor is
  port (
    
  ) ;
end entity ; -- processor

architecture structure of processor is
    
-- ==============
-- = Components =
-- ==============
  component control
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
          slt_unsigned : out std_logic );
  end component; -- control
  
  component reg_file_32
    port( rfi_WEN : in std_logic;
          rfi_raddr1 : in std_logic_vector(4 downto 0);
          rfi_raddr2 : in std_logic_vector(4 downto 0);
          rfi_waddr : in std_logic_vector(4 downto 0);
          rfi_wdata : in std_logic_vector(31 downto 0);
          rfi_reset : in std_logic;
          rfi_CLK : in std_logic;
          rfo_rdata1 : out std_logic_vector(31 downto 0);
          rfo_rdata2 : out std_logic_vector(31 downto 0) );
  end component; -- reg_file_32
  
  component alu_32_bit
    port( ian_op_sel : in std_logic_vector(2 downto 0);
          ian_A : in std_logic_vector(31 downto 0);
          ian_B : in std_logic_vector(31 downto 0);
          oan_result : out std_logic_vector(31 downto 0);
          oan_overflow : out std_logic );
  end component; -- alu_32_bit
  
  component mem
  	generic(  depth_exp_of_2 	 : integer;
			        mif_filename 	   : string );
	  port( address		: IN STD_LOGIC_VECTOR;
			    byteena		: IN STD_LOGIC_VECTOR;
			    clock			: IN STD_LOGIC;
			    data		  : IN STD_LOGIC_VECTOR;
			    wren			: IN STD_LOGIC;
			    q				  : OUT STD_LOGIC_VECTOR );
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
  
  component load_helper
    port(
        load_type : in std_logic_vector(1 downto 0);
        is_signed : std_logic;
        alu_out   : in std_logic_vector(31 downto 0);
        mem_out   : in std_logic_vector(31 downto 0);
        o_load_out   : out std_logic_vector(31 downto 0)
      );
  end component;
  
  component ext_16_32
    port( sign_en : in std_logic;
          i_16bit  : in std_logic_vector(15 downto 0);
          o_32bit : out std_logic_vector(31 downto 0) );
  end component;
  
  component barrel_shifter
    port(i_input        : in std_logic_vector(31 downto 0);
         i_shiftAmount  : in std_logic_vector(4 downto 0);
         i_control_L_R  : in std_logic;
         i_logical_arth : in std_logic;
         o_F            : out std_logic_vector(31 downto 0));
  end component;
  
  component multiplier
    port(i_A  : in std_logic_vector(31 downto 0);
         i_B  : in std_logic_vector(31 downto 0);
         o_Result : out std_logic_vector(31 downto 0));
  end component;
-- ===========
-- = Signals =
-- ===========
  
begin
  control: control
    port MAP( instruction => 
              alu_op => 
              alu_src => 
              reg_write => 
              mem_write => 
              mem_to_reg => 
              mem_read => 
              branch => 
              branch_condition =>  
              jump => 
              jump_reg_en => 
              reg_dst => 
              and_link => 
              store_type => 
              load_type => 
              load_sign_en => 
              alu_shift_mul_sel => 
              shift_source => 
              overflow_trap => 
              left_right_shift => 
              logic_arith_shift => 
              slt_unsigned => 
              );
  register_file: reg_file_32
    port MAP (  rfi_WEN => 
                rfi_raddr1 => 
                rfi_raddr2 => 
                rfi_waddr => 
                rfi_wdata => 
                rfi_reset => 
                rfi_CLK => 
                rfo_rdata1 => 
                rfo_rdata2 => 
                );
  alu: alu_32
    port MAP (  ian_op_sel => 
                ian_A => 
                ian_B => 
                oan_result => 
                oan_overflow => );
  
  -- LOAD AND STORE HELPERS NEEDED IN PROJECT
  
  mem_unit : mem
    generic MAP ( depth_exp_of_2 => 10,
                  mif_filename => "/home/jpryan/cpre381/lab4/code/dmem.mif")
    port MAP( address => 
              byteena => 
              clock => 
              data => 
              wren => 
              q => 
      );
  
end architecture ; -- structure