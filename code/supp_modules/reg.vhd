library IEEE;
use IEEE.std_logic_1164.all;

entity reg is
  generic(N : integer := 32);
  port (
        ireg_CLK     : in std_logic;
        ireg_RST     : in std_logic;
        ireg_WE      : in std_logic;
        ireg_D       : in std_logic_vector(N-1 downto 0);
        oreg_Q       : out std_logic_vector(N-1 downto 0)
        );
end reg;

architecture structure of reg is
  component dff
    port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic );   -- Data value output
  end component;
  
  begin
    G1: for i in 0 to N-1 generate
      dff_i: dff
        port MAP(
          i_CLK => ireg_CLK,
          i_RST => ireg_RST,
          i_WE => ireg_WE,
          i_D => ireg_D(i),
          o_Q => oreg_Q(i) );
    end generate;
end structure;
