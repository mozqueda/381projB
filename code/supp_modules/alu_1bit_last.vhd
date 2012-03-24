library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

-------------------------
-- the last 1-bit ALU  --
-------------------------
-- Overflow logic/output is handled here.
-- By Juan Mozqueda and John Ryan

entity alu_1bit_last is
  port(
      ia1_op_sel  : in std_logic_vector(2 downto 0);
      ia1_A : in std_logic;
      ia1_B : in std_logic;
      ia1_cin : in std_logic;
      ia1_less: in std_logic; -- for slt instr.
      oa1_result  : out std_logic;
      oa1_cout : out std_logic;
      oa1_set  : out std_logic );
end alu_1bit_last;

architecture structure of alu_1bit_last is

----------------
-- Components --
----------------
  component mux2
      port(
       imux_SW : in std_logic;
       imux_A  : in std_logic;
       imux_B  : in std_logic;
       omux_E  : out std_logic );
  end component;
  
  component and2
    port(i_A  : in std_logic;
         i_B  : in std_logic;
         o_F  : out std_logic );
  end component;
  
  component inv
    port(i_A  : in std_logic;
         o_F  : out std_logic );  
  end component;
  
  component or2
    port(i_A  : in std_logic;
         i_B  : in std_logic;
         o_F  : out std_logic );
  end component;
  
  component xor2
    port(i_A  : in std_logic;
         i_B  : in std_logic;
         o_F  : out std_logic );
  end component;
  
  component full_adder
    port(ifa_A  : in std_logic;
         ifa_B  : in std_logic;
         ifa_Cin: in std_logic;
         ofa_Cout: out std_logic;
         ofa_S  : out std_logic );  
  end component;
  
  
-------------
-- Signals --
-------------
  signal sA_inv_sel : std_logic; -- 1 for sA_post_mux to be negative
  signal sB_inv_sel : std_logic; -- 1 for sB_post_mux to be negative
  
  signal sA_not : std_logic;
  signal sB_not : std_logic;
  
  signal sA_post_mux : std_logic;
  signal sB_post_mux : std_logic;
  
  signal sAND : std_logic;
  signal sNAND : std_logic;
  signal sOR : std_logic;
  signal sNOR : std_logic;
  signal sXOR : std_logic;
  signal sADD : std_logic;
 
---------------
-- Structure --
---------------
begin
  sA_not <= NOT ia1_A;
  sB_not <= NOT ia1_B;
  sNAND <= NOT sAND;
  sNOR <= NOT sOR;
  
  mux_Ainv: mux2
  port MAP(
      imux_SW => sA_inv_sel,
      imux_A => ia1_A,
      imux_B => sA_not,
      omux_E => sA_post_mux );
  
  mux_Binv: mux2
  port MAP(
      imux_SW => sB_inv_sel,
      imux_A => ia1_B,
      imux_B => sB_not,
      omux_E => sB_post_mux );

  and_AB: and2
    port MAP(
      i_A => sA_post_mux,
      i_B => sB_post_mux,
      o_F => sAND );

  or_AB: or2
    port MAP(
      i_A => sA_post_mux,
      i_B => sB_post_mux,
      o_F => sOR );

  xor_AB: xor2
    port MAP(
      i_A => sA_post_mux,
      i_B => sB_post_mux,
      o_F => sXOR );

  add_AB: full_adder
    port MAP(ifa_A => sA_post_mux,
         ifa_B => sB_post_mux,
         ifa_Cin => ia1_cin,
         ofa_Cout => oa1_cout,
         ofa_S => sADD );
  
  -- Result Selection --
  with ia1_op_sel select
    oa1_result <= sAND when "000",
                  sNAND when "001",
                  sOR when "010",
                  sNOR when "011",
                  sXOR when "100",
                  sADD when "101",
                  sADD when "110", -- For subtraction
                  ia1_less when "111",
                  '0' when others;
  
  -- Setting B invert for subtraction and slt--
  with ia1_op_sel select
    sB_inv_sel <= '1' when "110",
                  '1' when "111",
                  '0' when others;
                  
  -- Setting A invert to 0 always --
  sA_inv_sel <= '0';
  
  -- Setting the 'set' value to the adder output --
  oa1_set <= sADD;
 
end structure;
