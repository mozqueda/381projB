-------------------------------------------------------------------------
-- Justin Rilling
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_mem.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a behavioral testbench for the 
-- generic memory component.
-- 
--
--
-- NOTES:
-- 10/10/10 by JRR::Design created.
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use std.textio.all;

entity tb_mem is
       
end entity tb_mem;

architecture behavioral of tb_mem is

	component mem
		generic(depth_exp_of_2 	: integer := 10;
				mif_filename 	: string := "mem.mif");
		port   (address			: IN STD_LOGIC_VECTOR (depth_exp_of_2-1 DOWNTO 0) := (OTHERS => '0');
				byteena			: IN STD_LOGIC_VECTOR (3 DOWNTO 0) := (OTHERS => '1');
				clock			: IN STD_LOGIC := '1';
				data			: IN STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
				wren			: IN STD_LOGIC := '0';
				q				: OUT STD_LOGIC_VECTOR (31 DOWNTO 0));  
	end component;
	
	type slv_1Darray is array (natural range <>) of std_logic_vector(31 downto 0);
	signal s_clk : std_logic := '1';
	signal s_wren : std_logic := '0';
	signal s_addr : std_logic_vector(9 downto 0) :=  (others => '0');
	signal s_data : std_logic_vector(31 downto 0) :=  (others => '0'); 
	signal s_q : std_logic_vector(31 downto 0);
	
begin
	
	dmem : mem
		generic map(depth_exp_of_2 	=> 10,
					mif_filename 	=> "dmem.mif")
		port map   (address			=> s_addr,
					byteena			=> "1111",
					clock			=> s_clk,
					data			=> s_data,
					wren			=> s_wren,
					q				=> s_q); 
					
	clk : process
		begin
			s_clk <= not s_clk;
			wait for 50 ns;
	end process clk;
	
	process
	
		variable i : integer;
		variable tempStorage : slv_1Darray(9 downto 0);
	
		begin
		
			s_wren <= '0';
			
			wait for 50 ns;
			
			for i in 0 to 9 loop
				s_addr <= conv_std_logic_vector(i,10);
				wait for 75 ns;
				tempStorage(i) := s_q;
				wait for 25 ns;
			end loop;
			
			s_wren <= '1';
			
			for i in 0 to 9 loop
				s_addr <= conv_std_logic_vector(i+100,10);
				s_data <= tempStorage(i);
				wait for 100 ns;
			end loop;
		
			wait;
		
	end process;

end architecture behavioral;
