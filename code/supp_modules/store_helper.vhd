library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity store_helper is
  port(
      byte_addr   : in std_logic_vector(31 downto 0);
      wdata_in    : in std_logic_vector(31 downto 0);
      store_type  : in std_logic_vector(1 downto 0);
      word_address: out std_logic_vector(9 downto 0);
      byteena     : out std_logic_vector(3 downto 0);
      wdata       : out std_logic_vector(31 downto 0)
    );  
end store_helper;

architecture help_stuff of store_helper is

signal sbyte_index   : std_logic_vector(1 downto 0);
signal sword_addr     : std_logic_vector(9 downto 0);

signal sdata1       : std_logic_vector(31 downto 0);

begin
  word_address <= byte_addr(11 downto 2);
  sbyte_index <= byte_addr(1 downto 0);
  sdata1 <= x"000000"& wdata_in(7 downto 0);
  
  with(store_type & sbyte_index) select
    byteena <= "0001" when "0000",
               "0010" when "0001",
               "0100" when "0010",
               "1000" when "0011",
               "0011" when "0100" | "0101",
               "1100" when "0110" | "0111",
               "1111" when "1000" | "1001" | "1010" | "1011",
               "0000" when others;
  with(store_type & sbyte_index) select
    wdata <= x"000000"  &   wdata_in(7 downto 0)            when "0000",
             x"0000"    &   wdata_in(7 downto 0) & x"00"    when "0001",
             x"00"      &   wdata_in(7 downto 0) & x"0000"  when "0010",
                            wdata_in(7 downto 0) & x"000000"when "0011",
             x"0000"    &   wdata_in(15 downto 0)           when "0100" | "0101",
             wdata_in(15 downto 0)               & x"0000"  when "0110" | "0111",
             wdata_in(31 downto 0) when "1000" | "1001" | "1010" | "1011",
            x"00000000" when others;
end help_stuff;