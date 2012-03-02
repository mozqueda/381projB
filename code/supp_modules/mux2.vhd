library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_ARITH.ALL;
use IEEE.std_logic_unsigned.ALL;

entity mux2 is
  
  port(
       imux_SW : in std_logic;
       imux_A  : in std_logic;
       imux_B  : in std_logic;
       omux_E  : out std_logic
       );

end mux2;

architecture structure of mux2 is
  component inv
    port(
      i_A : in std_logic;
      o_F : out std_logic
      );
  end component;
  
  component and2
    port(
      i_A  : in std_logic;
      i_B  : in std_logic;
      o_F  : out std_logic
      
      );
  end component;    
  
  component or2
    port(
      i_A  : in std_logic;
      i_B  : in std_logic;
      o_F  : out std_logic
      );
  end component;
  
  signal sNOT_SW  : std_logic;
  signal sAND1    : std_logic;
  signal sAND2    : std_logic;
  
  begin
    
    mux_not1: inv
      port MAP(
            i_A => imux_SW,
            o_F => sNOT_SW );
    mux_and1: and2
      port MAP(
          i_A => sNOT_SW,
          i_B => imux_A,
          o_F => sAND1);
    mux_and2: and2
      port MAP(
          i_A => imux_SW,
          i_B => imux_B,
          o_F => sAND2 );
    mux_or2: or2
      port MAP(
          i_A => sAND1,
          i_B => sAND2,
          o_F => omux_E);
  
end structure;