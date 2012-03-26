library IEEE;
use IEEE.std_logic_1164.all;

entity ext_16_32 is
  port(
    sign_en : in std_logic;
    i_16bit  : in std_logic_vector(15 downto 0);
    o_32bit : out std_logic_vector(31 downto 0) );
end ext_16_32;

architecture structure of ext_16_32 is
begin
  detrmn_func: process(sign_en,i_16bit)
  begin
    -- Check sign enable off
    if(sign_en = '0') then
      o_32bit <= x"0000" & i_16bit;
    elsif (sign_en = '1') then
      if(i_16bit(15) = '1') then
        o_32bit <= x"ffff" & i_16bit;  
      elsif(i_16bit(15) = '0') then
        o_32bit <= x"0000" & i_16bit;  
      else      -- Cant determine sign
        o_32bit <= x"00000000";
      end if;
    else -- sign enable neither on or off
      o_32bit <= x"00000000";
    end if;
  end process detrmn_func;
end structure;