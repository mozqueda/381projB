library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_ARITH.ALL;
use IEEE.std_logic_unsigned.ALL;

entity mux_nbit is
  generic(N : integer := 32);
  port(
     imux_SW : in std_logic;
     imux_A  : in std_logic_vector(N-1 downto 0);
     imux_B  : in std_logic_vector(N-1 downto 0);
     omux_E  : out std_logic_vector(N-1 downto 0)
      );

end mux_nbit;

architecture structure of mux_nbit is
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
  
  signal sNOT_SW  : std_logic_vector(N-1 downto 0);
  signal sAND1    : std_logic_vector(N-1 downto 0);
  signal sAND2    : std_logic_vector(N-1 downto 0);
  
  begin
    G1: for i in 0 to N-1 generate
    mux_not1: inv
      port MAP(
            i_A => imux_SW,
            o_F => sNOT_SW(i) );
    mux_and1: and2
      port MAP(
          i_A => sNOT_SW(i),
          i_B => imux_A(i),
          o_F => sAND1(i) );
    mux_and2: and2
      port MAP(
          i_A => imux_SW,
          i_B => imux_B(i),
          o_F => sAND2(i) );
    mux_or2: or2
      port MAP(
          i_A => sAND1(i),
          i_B => sAND2(i),
          o_F => omux_E(i) );
   end generate;

end structure;

