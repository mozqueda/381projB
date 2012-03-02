library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity add_sub is
  generic(N : integer :=32);
  port(
        ias_A     : in std_logic_vector(N-1 downto 0);
        ias_B     : in std_logic_vector(N-1 downto 0);
        nAdd_Sub  : in std_logic;
        oas_output: out std_logic_vector(N-1 downto 0);
        ALUSrc    : in std_logic;
        ias_immed : in std_logic_vector(N-1 downto 0)
        );
        
end add_sub;

architecture structure of add_sub is 
  component ones_complement
    generic(N: integer);
    port(
      i_A : in std_logic_vector(N-1 downto 0);
      o_F : out std_logic_vector(N-1 downto 0)
      );
  end component;
  
  component full_adder_nbit is
      generic(N: integer);
      port(
      ifna_A   : in std_logic_vector(N-1 downto 0);
      ifna_B   : in std_logic_vector(N-1 downto 0);
      ifna_Cin : in std_logic;
      ofna_Cout: out std_logic;
      ofna_S   : out std_logic_vector(N-1 downto 0)
      );
  end component;
  
  component mux_nbit is
      generic(N: integer);
      port(
      imux_SW : in std_logic;
      imux_A  : in std_logic_vector(N-1 downto 0);
      imux_B  : in std_logic_vector(N-1 downto 0);
      omux_E  : out std_logic_vector(N-1 downto 0)
      );
  end component;
  
  signal sADD1  : std_logic_vector(N-1 downto 0);
  signal sADD2  : std_logic_vector(N-1 downto 0);
  signal sINV1  : std_logic_vector(N-1 downto 0);
  signal sIMM_mux:std_logic_vector(N-1 downto 0);
  
  begin
    
    imux_immed : mux_nbit
      generic map(N => 32)
      port MAP(
        imux_SW => ALUSrc,
        imux_A => ias_B,
        imux_B => ias_immed,
        omux_E => sIMM_mux );
    
    as_add1: full_adder_nbit
      generic map(N => 32)
      port MAP(
        ifna_A => ias_A,
        ifna_B => sIMM_mux,
        ifna_Cin => '0',
        --ofna_Cout => '0',
        ofna_S => sADD1 );
        
    as_inv1: ones_complement
      generic map(N => 32)
      port MAP(
        i_A => sIMM_MUX,
        o_F => sINV1 );
        
    as_add2: full_adder_nbit
      generic map(N => 32)
      port MAP(
        ifna_A => ias_A,
        ifna_B => sINV1,
        ifna_Cin => nAdd_Sub,
        ofna_S => sADD2 );
    
    as_mux: mux_nbit
      generic map(N => 32)
      port MAP(
        imux_SW => nAdd_Sub,
        imux_A => sADD1,
        imux_B => sADD2,
        omux_E => oas_output );
end structure;