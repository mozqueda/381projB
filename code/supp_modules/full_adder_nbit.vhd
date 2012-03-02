library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_ARITH.ALL;
use IEEE.std_logic_unsigned.ALL;

entity full_adder_nbit is
  generic(N : integer := 32);
    port(
        ifna_A   : in std_logic_vector(N-1 downto 0);
        ifna_B   : in std_logic_vector(N-1 downto 0);
        ifna_Cin : in std_logic;
        ofna_Cout: out std_logic;
        ofna_S   : out std_logic_vector(N-1 downto 0)
        );
end full_adder_nbit;

architecture structure of full_adder_nbit is
  component full_adder
    port(
      ifa_A   : in std_logic;
      ifa_B   : in std_logic;
      ifa_Cin : in std_logic;
      ofa_Cout: out std_logic;
      ofa_S   : out std_logic
      );
  end component;
  
  signal sCARRY   : std_logic_vector(N downto 0);
  begin
    G1: for i in 0 to N-1 generate
      adder_mid: full_adder
      port MAP(
            ifa_A => ifna_A(i),
            ifa_B => ifna_B(i),
            ifa_Cin => sCARRY(i),
            ofa_Cout => sCARRY(i+1),
            ofa_S => ofna_S(i)
            );
   end generate;
   
   sCARRY(0) <= ifna_Cin;
   ofna_Cout <= sCARRY(N);
   
end structure;