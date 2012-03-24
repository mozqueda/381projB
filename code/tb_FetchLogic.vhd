library IEEE;
use IEEE.std_logic_1164.all;

entity tb_FetchLogic is
    
end tb_FetchLogic;


architecture behavior of tb_FetchLogic is

  component fetch_logic
      port(i_CLK            : in std_logic;
           i_reset          : in std_logic;
           i_jump_rslt      : in std_logic_vector(31 downto 0);
           o_PC_ALU_rslt    : out std_logic_vector(31 downto 0);
           o_instruction    : out std_logic_vector(31 downto 0));
  end component;
  
  signal t_CLK, t_reset : std_logic;
  signal t_jump_rslt, t_instruction, t_PC_ALU_rslt    : std_logic_vector(31 downto 0);
  
  begin
    d_tb: fetch_logic
    port map(i_CLK => t_CLK,
             i_reset => t_reset,
             i_jump_rslt => t_jump_rslt,
             o_PC_ALU_rslt => t_PC_ALU_rslt,
             o_instruction => t_instruction);
             
    
    process begin
      
      ---Initial Reset --------
      
      t_CLK <= '0';
      t_reset <= '1';
      t_jump_rslt <= x"00000000";
      wait for 100 ns;
      
      t_CLK <= '0';
      t_reset <= '0';
      t_jump_rslt <= x"00000000";
      wait for 100 ns;
            
      -------------------------      
            
      t_CLK <= '0';
      t_jump_rslt <= x"00000000";
      wait for 100 ns;
        
      t_CLK <= '1';
      t_jump_rslt <= x"00000000";
      wait for 100 ns;      
      
      --------------------------
      
      t_CLK <= '0'; 
      t_jump_rslt <= x"00000004";
      wait for 100 ns;
        
      t_CLK <= '1';
      t_jump_rslt <= x"00000004";
      wait for 100 ns;     
      
      --------------------------
      
      t_CLK <= '0';
      t_jump_rslt <= x"00000008";
      wait for 100 ns;
        
      t_CLK <= '1';
      t_jump_rslt <= x"00000008";
      wait for 100 ns;   
      
      --------------------------
      
      t_CLK <= '0';
      t_jump_rslt <= x"0000000c";
      wait for 100 ns;
        
      t_CLK <= '1';
      t_jump_rslt <= x"0000000c";
      wait for 100 ns;
    
    end process; 
end behavior;