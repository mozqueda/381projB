library IEEE;
use IEEE.std_logic_1164.all;
use work.arr_32.all;

entity reg_file_32 is
  generic(N : integer := 32);
  port(
      rfi_WEN : in std_logic;
      rfi_raddr1 : in std_logic_vector(4 downto 0);
      rfi_raddr2 : in std_logic_vector(4 downto 0);
      rfi_waddr : in std_logic_vector(4 downto 0);
      rfi_wdata : in std_logic_vector(31 downto 0);
      rfi_reset : in std_logic;
      rfi_CLK : in std_logic;
      rfo_rdata1 : out std_logic_vector(31 downto 0);
      rfo_rdata2 : out std_logic_vector(31 downto 0)     
    );
end reg_file_32;
architecture structure of reg_file_32 is
  component mux_32_1
    port(
      imux_SW : in std_logic_vector(4 downto 0);
      i_D : in array32_bit(31 downto 0);
      omux_E  : out std_logic_vector(N-1 downto 0)
      );
  end component;
  
  component dec_5_32 is
    port(
        D_IN :  in std_logic_vector(4 downto 0);
        SX_OUT: out std_logic_vector(31 downto 0)
    );
  end component;
  
  component reg
      port (
        ireg_CLK     : in std_logic;
        ireg_RST     : in std_logic;
        ireg_WE      : in std_logic;
        ireg_D       : in std_logic_vector(N-1 downto 0);
        oreg_Q       : out std_logic_vector(N-1 downto 0)
        );
  end component;
  
  component and2
      port(i_A      : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
  end component;
  
  signal sAND_WE  : std_logic_vector(31 downto 0);
  
  signal sAND_WE_IN : std_logic_vector(31 downto 0);
  
  signal sREG : array32_bit(31 downto 0);
  
  
  begin
    reg_0 : reg
      port MAP(
        ireg_CLK => rfi_CLK,
        ireg_RST => '1',
        ireg_WE => sAND_WE(0),
        ireg_D => rfi_wdata,
        oreg_Q => sREG(0) );
        
    G1: for i in 1 to N-1 generate
      reg_i : reg
        port MAP(
          ireg_CLK => rfi_CLK,
          ireg_RST => rfi_reset,
          ireg_WE => sAND_WE(i),
          ireg_D => rfi_wdata,
          oreg_Q => sREG(i) );
    end generate;
    
    decdr_WADDR : dec_5_32
      port MAP(
        D_IN => rfi_waddr,
        SX_OUT => sAND_WE_IN );
          
    G2: for i in 0 to N-1 generate
      sAND_WE(i) <= rfi_WEN AND sAND_WE_IN(i);
    end generate;
    
    mux_rdata1 : mux_32_1
      port MAP(
        imux_SW => rfi_raddr1,
        i_D => sREG,
        omux_E => rfo_rdata1 );
    mux_rdata2 : mux_32_1
      port MAP(
        imux_SW => rfi_raddr2,
        i_D => sREG,
        omux_E => rfo_rdata2 );
end structure;
