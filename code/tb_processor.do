vcom -work work processor.vhd
vcom -work work tb_processor.vhd
vcom -work work control.vhd

vsim -novopt work.tb_processor

add wave \
{sim:/tb_processor/processor_unit/control_component/shelper }

add wave \
{sim:/tb_processor/processor_unit/s_alu_input_b } \
{sim:/tb_processor/processor_unit/s_alu_op } \
{sim:/tb_processor/processor_unit/s_alu_result } \
{sim:/tb_processor/processor_unit/s_alu_shift_mul_sel } \
{sim:/tb_processor/processor_unit/s_alu_shift_mul_selection } \
{sim:/tb_processor/processor_unit/s_alu_src } \
{sim:/tb_processor/processor_unit/s_alu_zero } \
{sim:/tb_processor/processor_unit/s_and_link } \
{sim:/tb_processor/processor_unit/s_barrel_shifter_out } \
{sim:/tb_processor/processor_unit/s_br_const } \
{sim:/tb_processor/processor_unit/s_br_const_en } \
{sim:/tb_processor/processor_unit/s_br_zero_should_be } \
{sim:/tb_processor/processor_unit/s_branch } \
{sim:/tb_processor/processor_unit/s_branch_help_result } \
{sim:/tb_processor/processor_unit/s_imm } \
{sim:/tb_processor/processor_unit/s_imm_sign_extended } \
{sim:/tb_processor/processor_unit/s_instruction } \
{sim:/tb_processor/processor_unit/s_jump } \
{sim:/tb_processor/processor_unit/s_jump_reg_en } \
{sim:/tb_processor/processor_unit/s_left_right_shift } \
{sim:/tb_processor/processor_unit/s_link_helper_waddr } \
{sim:/tb_processor/processor_unit/s_link_helper_wdata } \
{sim:/tb_processor/processor_unit/s_load_helper_out } \
{sim:/tb_processor/processor_unit/s_load_sign_en } \
{sim:/tb_processor/processor_unit/s_load_type } \
{sim:/tb_processor/processor_unit/s_logic_arith_shift } \
{sim:/tb_processor/processor_unit/s_mem_byte_enable } \
{sim:/tb_processor/processor_unit/s_mem_out } \
{sim:/tb_processor/processor_unit/s_mem_read } \
{sim:/tb_processor/processor_unit/s_mem_to_reg } \
{sim:/tb_processor/processor_unit/s_mem_to_reg_data } \
{sim:/tb_processor/processor_unit/s_mem_wdata } \
{sim:/tb_processor/processor_unit/s_mem_word_address } \
{sim:/tb_processor/processor_unit/s_mem_write } \
{sim:/tb_processor/processor_unit/s_multiplier_out } \
{sim:/tb_processor/processor_unit/s_next_pc } \
{sim:/tb_processor/processor_unit/s_overflow_trap } \
{sim:/tb_processor/processor_unit/s_pc_plus_4 } \
{sim:/tb_processor/processor_unit/s_rd } \
{sim:/tb_processor/processor_unit/s_reg_data1 } \
{sim:/tb_processor/processor_unit/s_reg_data2 } \
{sim:/tb_processor/processor_unit/s_reg_data2_or_branch_const } \
{sim:/tb_processor/processor_unit/s_reg_dst } \
{sim:/tb_processor/processor_unit/s_reg_write } \
{sim:/tb_processor/processor_unit/s_rs } \
{sim:/tb_processor/processor_unit/s_rt } \
{sim:/tb_processor/processor_unit/s_rt_rd_choice } \
{sim:/tb_processor/processor_unit/s_shamt } \
{sim:/tb_processor/processor_unit/s_shift_source } \
{sim:/tb_processor/processor_unit/s_slt_unsigned } \
{sim:/tb_processor/processor_unit/s_store_type } 

add wave \
{sim:/tb_processor/processor_unit/fetch_logic_unit/i_clk } \
{sim:/tb_processor/processor_unit/fetch_logic_unit/i_jump_rslt } \
{sim:/tb_processor/processor_unit/fetch_logic_unit/i_reset } \
{sim:/tb_processor/processor_unit/fetch_logic_unit/o_instruction } \
{sim:/tb_processor/processor_unit/fetch_logic_unit/o_pc_alu_rslt } \
{sim:/tb_processor/processor_unit/fetch_logic_unit/s_address } \
{sim:/tb_processor/processor_unit/fetch_logic_unit/s_byteena } \
{sim:/tb_processor/processor_unit/fetch_logic_unit/s_pc_alu_ovfl } \
{sim:/tb_processor/processor_unit/fetch_logic_unit/s_pc_out } \
{sim:/tb_processor/processor_unit/fetch_logic_unit/s_wdata } 

add wave \
{sim:/tb_processor/s_reset }

add wave \
{sim:/tb_processor/processor_unit/link_help_component/waddr_in } \
{sim:/tb_processor/processor_unit/link_help_component/waddr_out } \
{sim:/tb_processor/processor_unit/link_help_component/wdata_in } \
{sim:/tb_processor/processor_unit/link_help_component/wdata_out } 

add wave \
{sim:/tb_processor/processor_unit/register_file/rfi_clk } \
{sim:/tb_processor/processor_unit/register_file/rfi_raddr1 } \
{sim:/tb_processor/processor_unit/register_file/rfi_raddr2 } \
{sim:/tb_processor/processor_unit/register_file/rfi_reset } \
{sim:/tb_processor/processor_unit/register_file/rfi_waddr } \
{sim:/tb_processor/processor_unit/register_file/rfi_wdata } \
{sim:/tb_processor/processor_unit/register_file/rfi_wen } \
{sim:/tb_processor/processor_unit/register_file/rfo_rdata1 } \
{sim:/tb_processor/processor_unit/register_file/rfo_rdata2 } \
{sim:/tb_processor/processor_unit/register_file/sand_we } \
{sim:/tb_processor/processor_unit/register_file/sand_we_in }


add wave \
{sim:/tb_processor/processor_unit/register_file/sreg(0) } \
{sim:/tb_processor/processor_unit/register_file/sreg(1) } \
{sim:/tb_processor/processor_unit/register_file/sreg(2) } \
{sim:/tb_processor/processor_unit/register_file/sreg(3) } \
{sim:/tb_processor/processor_unit/register_file/sreg(4) } \
{sim:/tb_processor/processor_unit/register_file/sreg(5) } \
{sim:/tb_processor/processor_unit/register_file/sreg(6) } \
{sim:/tb_processor/processor_unit/register_file/sreg(7) } \
{sim:/tb_processor/processor_unit/register_file/sreg(8) } \
{sim:/tb_processor/processor_unit/register_file/sreg(9) } \
{sim:/tb_processor/processor_unit/register_file/sreg(10) } \
{sim:/tb_processor/processor_unit/register_file/sreg(11) } \
{sim:/tb_processor/processor_unit/register_file/sreg(12) } \
{sim:/tb_processor/processor_unit/register_file/sreg(13) } \
{sim:/tb_processor/processor_unit/register_file/sreg(14) } \
{sim:/tb_processor/processor_unit/register_file/sreg(15) } \
{sim:/tb_processor/processor_unit/register_file/sreg(16) } \
{sim:/tb_processor/processor_unit/register_file/sreg(17) } \
{sim:/tb_processor/processor_unit/register_file/sreg(18) } \
{sim:/tb_processor/processor_unit/register_file/sreg(19) } \
{sim:/tb_processor/processor_unit/register_file/sreg(20) } \
{sim:/tb_processor/processor_unit/register_file/sreg(21) } \
{sim:/tb_processor/processor_unit/register_file/sreg(22) } \
{sim:/tb_processor/processor_unit/register_file/sreg(23) } \
{sim:/tb_processor/processor_unit/register_file/sreg(24) } \
{sim:/tb_processor/processor_unit/register_file/sreg(25) } \
{sim:/tb_processor/processor_unit/register_file/sreg(26) } \
{sim:/tb_processor/processor_unit/register_file/sreg(27) } \
{sim:/tb_processor/processor_unit/register_file/sreg(28) } \
{sim:/tb_processor/processor_unit/register_file/sreg(29) } \
{sim:/tb_processor/processor_unit/register_file/sreg(30) } \
{sim:/tb_processor/processor_unit/register_file/sreg(31) } 

add wave \
{sim:/tb_processor/processor_unit/mem_unit/mem(0) } \
{sim:/tb_processor/processor_unit/mem_unit/mem(1) } \
{sim:/tb_processor/processor_unit/mem_unit/mem(2) } \
{sim:/tb_processor/processor_unit/mem_unit/mem(3) } \
{sim:/tb_processor/processor_unit/mem_unit/mem(4) } \
{sim:/tb_processor/processor_unit/mem_unit/mem(5) } \
{sim:/tb_processor/processor_unit/mem_unit/mem(6) } \
{sim:/tb_processor/processor_unit/mem_unit/mem(7) } \
{sim:/tb_processor/processor_unit/mem_unit/mem(8) } \
{sim:/tb_processor/processor_unit/mem_unit/mem(9) } 

add wave \
{sim:/tb_processor/s_clk } 

run 800