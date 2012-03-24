library IEEE;
use IEEE.std_logic_1164.all;

entity tb_processor is
  generic(gCLK_HPER : time :=50ns);
end tb_processor;

architecture behavior of tb_processor is

  constant cCLK_PER : time := gCLK_HPER * 2;
  component processor
    port(p_CLK : in std_logic;
         reset : in std_logic);
  end component;       

  signal s_clk      : std_logic;

  begin
      DUT: processor
      port map(p_CLK => s_clk,
               reset => '0');

             
                      
  -- This process sets the clock value (low for gCLK_HPER, then high
  -- for gCLK_HPER). Absent a "wait" command, processes restart 
  -- at the beginning once they have reached the final statement.
  P_CLK: process
    begin
      s_CLK <= '0';
      wait for gCLK_HPER;
      s_CLK <= '1';
      wait for gCLK_HPER;
  end process;    
  
  
  
  processor_tb: process
    begin
    
  end process;


end behavior;
     