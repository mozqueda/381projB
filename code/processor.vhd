library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity processor is
  port (  p_CLK : in std_logic;
          p_reset : in std_logic ) ;
end entity ; -- processor

architecture structure of processor is
    
-- ==============
-- = Components =
-- ==============
  component control
  port( instruction         : in std_logic_vector(31 downto 0);
        alu_op              : out std_logic_vector(2 downto 0);
        alu_src             : out std_logic;
        reg_write           : out std_logic;
        mem_write           : out std_logic;
        mem_to_reg          : out std_logic;
        mem_read            : out std_logic;
        branch              : out std_logic;
        br_const_en         : out std_logic; -- new -- 
        br_const            : out std_logic; -- new --
        br_zero_should_be   : out std_logic; -- new --
        jump                : out std_logic;
        jump_reg_en         : out std_logic;
        reg_dst             : out std_logic;
        and_link            : out std_logic;
        store_type          : out std_logic_vector(1 downto 0);
        load_type           : out std_logic_vector(1 downto 0);
        load_sign_en        : out std_logic;
        alu_shift_mul_sel   : out std_logic_vector(1 downto 0);
        shift_source        : out std_logic_vector(1 downto 0);
        overflow_trap       : out std_logic;
        left_right_shift    : out std_logic;
        logic_arith_shift   : out std_logic;
        slt_unsigned        : out std_logic );
  end component; -- control
  
  component fetch_logic
      port( i_CLK                : in std_logic;
            i_reset              : in std_logic;
            i_jump_rslt          : in std_logic_vector(31 downto 0);
            o_PC_ALU_rslt        : out std_logic_vector(31 downto 0);
            o_instruction        : out std_logic_vector(31 downto 0));
  end component;
  
  component JumpBranchUnit
      port( i_rs_data            : in std_logic_vector(31 downto 0);
            i_PC_ALU             : in std_logic_vector(31 downto 0);
            i_imm                : in std_logic_vector(31 downto 0);
            i_instruction        : in std_logic_vector(31 downto 0);
            i_jumpRegister_ctrl  : in std_logic;
            i_branchHelper_ctrl  : in std_logic;
            i_jump_ctrl          : in std_logic;
            o_jump_rslt          : out std_logic_vector(31 downto 0));
  end component;
  
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
  
  component alu_32bit
    port( ian_op_sel    : in std_logic_vector(2 downto 0);
          ian_A         : in std_logic_vector(31 downto 0);
          ian_B         : in std_logic_vector(31 downto 0);
          oan_result    : out std_logic_vector(31 downto 0);
          oan_overflow  : out std_logic;
          oan_zero      : out std_logic );
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
  
  component load_helper
      port( load_type     : in std_logic_vector(1 downto 0);
            is_signed     : std_logic;
            alu_out       : in std_logic_vector(31 downto 0);
            mem_out       : in std_logic_vector(31 downto 0);
            o_load_out    : out std_logic_vector(31 downto 0) );
  end component;
  
  component store_helper
    port( byte_addr   : in std_logic_vector(31 downto 0);
          wdata_in    : in std_logic_vector(31 downto 0);
          store_type  : in std_logic_vector(1 downto 0);
          word_address: out std_logic_vector(9 downto 0);
          byteena     : out std_logic_vector(3 downto 0);
          wdata       : out std_logic_vector(31 downto 0) );
  end component;
  
  component link_helper
    port (  wdata_out : out std_logic_vector(31 downto 0);
          waddr_out : out std_logic_vector(4 downto 0);
          wdata_in : in std_logic_vector(31 downto 0);
          waddr_in : in std_logic_vector(4 downto 0);
          pc : in std_logic_vector(31 downto 0);
          and_link : in std_logic );
  end component;
  
-- ===========
-- = Signals =
-- ===========

-- instruction fetch logic signals
signal s_next_pc : std_logic_vector(31 downto 0); -- the pc after taking jumps or branches into account.
signal s_pc_plus_4 : std_logic_vector(31 downto 0); -- the current pc with 4 added to it.

-- before the register file
signal s_rs                : std_logic_vector(4 downto 0);
signal s_rt                : std_logic_vector(4 downto 0);
signal s_rd                : std_logic_vector(4 downto 0);
signal s_link_helper_waddr : std_logic_vector(4 downto 0);
signal s_link_helper_wdata : std_logic_vector(31 downto 0);
signal s_rt_rd_choice      : std_logic_vector(4 downto 0);

-- after the register file / before the ALU
signal s_reg_data1          : std_logic_vector(31 downto 0);
signal s_reg_data2          : std_logic_vector(31 downto 0);
signal s_reg_data2_or_branch_const  : std_logic_vector(31 downto 0);
signal s_imm_sign_extended  : std_logic_vector(31 downto 0);
signal s_imm                : std_logic_vector(31 downto 0);
signal s_alu_input_b        : std_logic_vector(31 downto 0);

-- parallel to the ALU
signal s_barrel_shifter_out  : std_logic_vector(31 downto 0);
signal s_multiplier_out      : std_logic_vector(31 downto 0);
signal s_shamt               : std_logic_vector(4 downto 0);

-- after the ALU / before the memory unit
signal s_alu_result : std_logic_vector(31 downto 0);
signal s_alu_zero : std_logic;
signal s_mem_word_address : std_logic_vector(9 downto 0);
signal s_mem_byte_enable : std_logic_vector(3 downto 0);
signal s_mem_wdata : std_logic_vector(31 downto 0);

-- after the memory unit
signal s_mem_out : std_logic_vector(31 downto 0);
signal s_load_helper_out : std_logic_vector(31 downto 0);
signal s_alu_shift_mul_selection : std_logic_vector(31 downto 0);
signal s_mem_to_reg_data : std_logic_vector(31 downto 0);

-- branch helper signals
signal s_branch_help_result : std_logic;

-- Control Signals
signal s_instruction        : std_logic_vector(31 downto 0);
signal s_alu_op             : std_logic_vector(2 downto 0);
signal s_alu_src            : std_logic;
signal s_reg_write          : std_logic;
signal s_mem_write          : std_logic;
signal s_mem_to_reg         : std_logic;
signal s_mem_read           : std_logic;
signal s_branch             : std_logic;
signal s_br_const_en        : std_logic;
signal s_br_const           : std_logic;
signal s_br_zero_should_be  : std_logic;
signal s_jump               : std_logic;
signal s_jump_reg_en        : std_logic;
signal s_reg_dst            : std_logic;
signal s_and_link           : std_logic;
signal s_store_type         : std_logic_vector(1 downto 0);
signal s_load_type          : std_logic_vector(1 downto 0);
signal s_load_sign_en       : std_logic;
signal s_alu_shift_mul_sel  : std_logic_vector(1 downto 0);
signal s_shift_source       : std_logic_vector(1 downto 0);
signal s_overflow_trap      : std_logic;
signal s_left_right_shift   : std_logic;
signal s_logic_arith_shift  : std_logic;
signal s_slt_unsigned       : std_logic;

-- =============
-- = Structure =
-- =============

begin
  control_component: control
    port MAP( instruction       => s_instruction,
              alu_op            => s_alu_op, -- 3 bits
              alu_src           => s_alu_src,
              reg_write         => s_reg_write,
              mem_write         => s_mem_write,
              mem_to_reg        => s_mem_to_reg,
              mem_read          => s_mem_read,
              branch            => s_branch,
              br_const_en       => s_br_const_en,
              br_const          => s_br_const,
              br_zero_should_be => s_br_zero_should_be,
              jump              => s_jump,
              jump_reg_en       => s_jump_reg_en,
              reg_dst           => s_reg_dst,
              and_link          => s_and_link,
              store_type        => s_store_type, -- 2 bits
              load_type         => s_load_type, -- 2 bits
              load_sign_en      => s_load_sign_en,
              alu_shift_mul_sel => s_alu_shift_mul_sel, -- 2 bits
              shift_source      => s_shift_source, -- 2 bits
              overflow_trap     => s_overflow_trap,
              left_right_shift  => s_left_right_shift,
              logic_arith_shift => s_logic_arith_shift,
              slt_unsigned      => s_slt_unsigned
              );
              
  fetch_log: fetch_logic
    port MAP( i_CLK          =>p_clk,
              i_reset        => p_reset,
              i_jump_rslt    => s_next_pc,
              o_PC_ALU_rslt  => s_pc_plus_4,
              o_instruction  => s_instruction
              );
              
  jump_branch: JumpBranchUnit
    port MAP( i_rs_data            => s_reg_data1,
              i_PC_ALU             => s_pc_plus_4,
              i_imm                => s_imm_sign_extended,
              i_instruction        => s_instruction,
              i_jumpRegister_ctrl  => s_jump_reg_en,
              i_branchHelper_ctrl  => s_branch_help_result,
              i_jump_ctrl          => s_jump,
              o_jump_rslt          => s_next_pc
              );
  
  s_rs <= s_instruction(25 downto 21);
  s_rt <= s_instruction(20 downto 16);
  s_rd <= s_instruction(15 downto 11);
              
  extender: ext_16_32
    port MAP( sign_en   => '1',
              i_16bit   => s_instruction(15 downto 0),
              o_32bit   => s_imm_sign_extended);
          
  
  link_help_component: link_helper
    port MAP( wdata_out => s_link_helper_wdata,
              waddr_out => s_link_helper_waddr,
              wdata_in  => s_mem_to_reg_data, -- signal from memtoreg mux
              waddr_in  => s_rt_rd_choice,
              pc        => s_pc_plus_4,        -- signal from fetch logic's o_PC_ALU_rslt
              and_link  => s_and_link  );
              
  register_file: reg_file_32
    port MAP (  rfi_WEN     => s_reg_write,
                rfi_raddr1  => s_rs,
                rfi_raddr2  => s_rt,
                rfi_waddr   => s_link_helper_waddr,
                rfi_wdata   => s_link_helper_wdata,
                rfi_reset   => p_reset,
                rfi_CLK     => p_clk,
                rfo_rdata1  => s_reg_data1,
                rfo_rdata2  => s_reg_data2
                );
  alu: alu_32bit
    port MAP (  ian_op_sel    => s_alu_op,
                ian_A         => s_reg_data1,
                ian_B         => s_alu_input_b,
                oan_result    => s_alu_result,
                oan_overflow  => s_overflow_trap, -- not sure
                oan_zero      => s_alu_zero );
                
  barrel_shifter_component : barrel_shifter
    port MAP (  i_input        => s_alu_input_b,
                i_shiftAmount  => s_shamt,
                i_control_L_R  => s_left_right_shift,
                i_logical_arth => s_logic_arith_shift,
                o_F            => s_barrel_shifter_out );
      
  multiplier_component : multiplier
    port MAP( i_A       => s_reg_data1,
              i_B       => s_alu_input_b,
              o_Result  => s_multiplier_out );
  
  store_helper_component : store_helper
    port MAP( byte_addr => s_alu_result,
              wdata_in => s_reg_data2,   
              store_type => s_store_type,
              word_address => s_mem_word_address,
              byteena       => s_mem_byte_enable,
              wdata         => s_mem_wdata );
          
  load_helper_component : load_helper
    port MAP( load_type => s_load_type,
              is_signed => s_load_sign_en,
              alu_out   => s_alu_result, -- Why does the load helper need the alu result?
              mem_out   => s_mem_out,
              o_load_out => s_load_helper_out ); 
  
  mem_unit : mem
    generic MAP ( depth_exp_of_2 => 10,
                  mif_filename => "dmem.mif")
    port MAP( address => s_mem_word_address,
              byteena => s_mem_byte_enable,
              clock   => p_clk,
              data    => s_mem_wdata,
              wren    => s_mem_write,
              q       => s_mem_out
      );
      
  ------------------------------
  ----- With/Select Muxes ------
  ------------------------------
  
  -- mux for memtoreg
  with s_mem_to_reg select
    s_mem_to_reg_data <= s_load_helper_out when '1',
                         s_alu_shift_mul_selection when '0',
                         x"00000000" when others;
  
  -- mux for alu_shift_mul_sel
  with s_alu_shift_mul_sel select
    s_alu_shift_mul_selection <=  s_alu_result when "00",
                                  s_barrel_shifter_out when "01",
                                  s_multiplier_out when "10",
                                  x"00000000" when others;
  -- mux for RegDst (before the register file)
  with s_reg_dst select
    s_rt_rd_choice <= s_rt when '0',
                      s_rd when '1',
                      "00000" when others;
                      
  -- selects the proper value for s_reg_data2_or_branch_const 
  -- based on control signals branch_const and branch_const_en
  with s_br_const_en select
    s_reg_data2_or_branch_const <=  s_reg_data2 when '0',
                                    x"0000000" & "000" & s_br_const when '1',
                                    x"00000000" when others;
                                 
  -- mux that sets s_alu_input_b using ALUSrc
  -- 0 = register
  -- 1 = immediate
  with s_alu_src select
    s_alu_input_b <= s_reg_data2_or_branch_const when '0',
                     s_imm_sign_extended when '1',
                      x"00000000" when others;
  
end architecture ; -- structure