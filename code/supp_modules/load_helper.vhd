library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity load_helper is
  port(
      load_type : in std_logic_vector(1 downto 0);
      is_signed : in std_logic;
      alu_out   : in std_logic_vector(31 downto 0);
      mem_out   : in std_logic_vector(31 downto 0);
      o_load_out   : out std_logic_vector(31 downto 0)
    );  
end load_helper;

architecture load_help of load_helper is
  component ext_16_32
    port(
        sign_en : in std_logic;
        i_16bit  : in std_logic_vector(15 downto 0);
        o_32bit : out std_logic_vector(31 downto 0)
      );
  end component;
  
  component ext_8_32
    port(
        sign_en : in std_logic;
        i_8bit  : in std_logic_vector(7 downto 0);
        o_32bit : out std_logic_vector(31 downto 0)
      );
  end component;
  
  
  signal sbyte_index : std_logic_vector(1 downto 0);
  signal post_shift_op: std_logic_vector(31 downto 0);
  signal pre_sign_ext: std_logic_vector(31 downto 0);
  signal s_ext_size_16: std_logic_vector(31 downto 0);
  signal s_ext_size_8: std_logic_vector(31 downto 0);

begin
  sbyte_index <= alu_out(1 downto 0);
  
  -- Selects the appropriate bits from mem_out and aligns them right.
  with(load_type & sbyte_index) select
    pre_sign_ext <= x"000000" & mem_out(7 downto 0) when "0000",
                    x"000000" & mem_out(15 downto 8) when "0001",
                    x"000000" & mem_out(23 downto 16) when "0010",
                    x"000000" & mem_out(31 downto 24) when "0011",
                    x"0000" & mem_out(15 downto 0) when "0100" | "0101",
                    x"0000" & mem_out(31 downto 16) when "0110" | "0111",
                    mem_out(31 downto 0) when "1000" | "1001" | "1010" | "1011", -- NOT necessary
              x"00000000" when others;
  -- extends the aligned-right bits.
  -- We don't know which signal we will use.
  ext16: ext_16_32
    port MAP(
      sign_en => is_signed,
      i_16bit => pre_sign_ext(15 downto 0),
      o_32bit => s_ext_size_16
      );
  ext8: ext_8_32
    port MAP(
      sign_en => is_signed,
      i_8bit => pre_sign_ext(7 downto 0),
      o_32bit => s_ext_size_8
    );
    
    -- selects the appropriate signal based on 
    -- the load_type (Word, Half-word or Byte)
    with(load_type) select
      o_load_out <= mem_out when "10",
                  s_ext_size_16 when "01",
                  s_ext_size_8 when "00",
                  x"00000000" when others;
end load_help;