library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

---------------------------------------
-- Array Multiplier Helper Component --
---------------------------------------
-- Represents a 'Row' in an array multiplier.
-- By Juan Mozqueda and John Ryan

entity arr_mult_hpr is
  port( i_A : in std_logic_vector(31 downto 0);
        i_B : in std_logic_vector(31 downto 0);
        i_prev : in std_logic_vector(31 downto 0); 
        o_F : out std_logic_vector(31 downto 0);
        o_cout : out std_logic );
end arr_mult_hpr;

architecture mixed of arr_mult_hpr is

----------------
-- Components --
----------------
  component full_adder_nbit is
    generic(N : integer := 32);
    port( ifna_A   : in std_logic_vector(N-1 downto 0);
          ifna_B   : in std_logic_vector(N-1 downto 0);
          ifna_Cin : in std_logic;
          ofna_Cout: out std_logic;
          ofna_S   : out std_logic_vector(N-1 downto 0) );
  end component;

-------------
-- Signals --
-------------
signal sAND : std_logic_vector(31 downto 0);
---------------
-- Structure --
---------------
begin
  sAND <= i_A AND i_B;
  
  adder: full_adder_nbit
    port MAP( ifna_A => i_prev,
              ifna_B => sAND,
              ifna_Cin => '0',
              ofna_Cout => o_cout,
              ofna_S => o_F );
end mixed;