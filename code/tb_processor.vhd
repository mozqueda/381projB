library IEEE;
use IEEE.std_logic_1164.all;

entity tb_processor is
  generic(gCLK_HPER : time :=50ns);
end tb_processor;

architecture behavior of tb_processor is

  constant cCLK_PER : time := gCLK_HPER * 2;
  component processor
    port(p_CLK : in std_logic;
         p_reset : in std_logic);
  end component;       

  signal s_clk      : std_logic;
  signal s_reset : std_logic;

  begin
      processor_unit: processor
      port map(p_CLK => s_clk,
               p_reset => s_reset );

      
                      
  -- This process sets the clock value (low for gCLK_HPER, then high
  -- for gCLK_HPER). Absent a "wait" command, processes restart 
  -- at the beginning once they have reached the final statement.
  P_CLK: process
    begin
      if (s_reset = '0') then
        s_CLK <= '0';
        wait for gCLK_HPER;
        s_CLK <= '1';
        wait for gCLK_HPER;
      else
        wait for gCLK_HPER;
      end if;
  end process;    
  
  
  
  processor_tb: process
    begin
    wait for cCLK_PER;
  end process;

  send_reset_pulse_at_beginning: process
    begin
      s_reset <= '1';
      wait for cCLK_PER;
      s_reset <= '0';
      
      wait for 1000ms;
  end process;

end behavior;
     