library IEEE;
use IEEE.std_logic_1164.all;
entity ext_8_32 is
  port(
    sign_en : in std_logic;
    i_8bit  : in std_logic_vector(7 downto 0);
    o_32bit : out std_logic_vector(31 downto 0) );
end ext_8_32;

architecture structure of ext_8_32 is
begin
  detrmn_func: process(sign_en,i_8bit)
  begin
    -- Check sign enable off
    if(sign_en = '0') then
      o_32bit <= x"000000" & i_8bit;
    elsif (sign_en = '1') then
      if(i_8bit(7) = '1') then
        o_32bit <= x"ffffff" & i_8bit;  
      elsif(i_8bit(7) = '0') then
        o_32bit <= x"000000" & i_8bit;  
      else
        o_32bit <= x"00000000";
      end if;
    -- sign enable neither on or off
    else
      o_32bit <= x"00000000";
    end if;
  end process detrmn_func;
end structure;