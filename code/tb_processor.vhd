library IEEE;
use IEEE.std_logic_1164.all;

entity tb_processor is

end tb_processor;

architecture behavior of tb_processor is

  component processor
    port(p_CLK : in std_logic;
         reset : in std_logic);
  end component;       
  
  signal t_CLK : std_logic;
  
  
  begin
    DUT: processor
      port map(p_CLK => t_CLK,
               reset => '0');
                          
    begin process
      
    
    
    
    
    
    end process;
end behavior;
     