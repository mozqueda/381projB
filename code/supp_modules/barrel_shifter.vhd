library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all ;


-------------------------------
-- The 32-bit Barrel Shifter --
-------------------------------
-- By Juan Mozqueda and John Ryan


----------------------------------------------------------
-- if "i_control_L_R" is '0', a left shift is done --

-- if "i_logical_arth is '0', a logical shift is done -- 
----------------------------------------------------------

entity barrel_shifter is
  port(i_input        : in std_logic_vector(31 downto 0);
       i_shiftAmount  : in std_logic_vector(4 downto 0);
       i_control_L_R  : in std_logic;
       i_logical_arth : in std_logic;
       o_F            : out std_logic_vector(31 downto 0));
end barrel_shifter;       
       
architecture structure of barrel_shifter is
  
  component mux_nbit
  generic(N : integer := 32);
  port(
     imux_SW : in std_logic;
     imux_A  : in std_logic_vector(N-1 downto 0);
     imux_B  : in std_logic_vector(N-1 downto 0);
     omux_E  : out std_logic_vector(N-1 downto 0)
      );
  end component;
  
  component ones_complement is
    generic(N : integer := 5);
       port(i_A  : in std_logic_vector(N-1 downto 0);
            o_F  : out std_logic_vector(N-1 downto 0));
  end component;               
                
---Input signals for the muxes---
signal s_A_first_mux  : std_logic_vector(31 downto 0);
signal s_A_second_mux : std_logic_vector(31 downto 0);
signal s_A_third_mux  : std_logic_vector(31 downto 0);
signal s_A_fourth_mux : std_logic_vector(31 downto 0);
signal s_A_fifth_mux  : std_logic_vector(31 downto 0);


---Output signals for the muxes---
signal s_O_first_mux : std_logic_vector(31 downto 0);
signal s_O_second_mux : std_logic_vector(31 downto 0);
signal s_O_third_mux : std_logic_vector(31 downto 0);
signal s_O_fourth_mux : std_logic_vector(31 downto 0);
signal s_O_fifth_mux : std_logic_vector(31 downto 0);

signal s_shiftAmount : std_logic_vector(4 downto 0);
signal i_inputhelper : std_logic_vector(31 downto 0);  

signal input_integer : integer range 0 to 31;
  
begin
    
  inv: ones_complement
    port MAP(i_A => i_shiftAmount,
             o_F => s_shiftAmount);
  
  ----------------------
  input_integer <= to_integer(unsigned( i_shiftAmount ));
  
  
  proc1: process(i_input, i_control_L_R)
  begin
    if(i_control_L_R = '1') then
       
       reverse: for i in 0 to 31 loop
        i_inputhelper(i) <= i_input(31-i);
       end loop;
          
    else    
       i_inputhelper <= i_input;
    end if;  
  end process proc1;  
  
  ----------------------
  
  s_A_first_mux(31 downto 1) <= i_inputhelper(30 downto 0);
  s_A_first_mux(0) <= '0';
      
  mux_1: mux_nbit
    port MAP(imux_SW    => s_shiftAmount(0),
             imux_A     => s_A_first_mux,
             imux_B     => i_inputhelper,
             omux_E     => s_O_first_mux);
  
  ----------------------
     
  s_A_second_mux(31 downto 2) <= s_O_first_mux(29 downto 0);
  s_A_second_mux(1 downto 0) <= "00";   
  
  mux_2: mux_nbit
      port MAP(imux_SW => s_shiftAmount(1),
               imux_A  => s_A_second_mux,
               imux_B  => s_O_first_mux,
               omux_E  => s_O_second_mux);
 
    
  ----------------------
     
  s_A_third_mux(31 downto 4) <= s_O_second_mux(27 downto 0);
  s_A_third_mux(3 downto 0) <= "0000";   
  
  mux_3: mux_nbit
      port MAP(imux_SW => s_shiftAmount(2),
               imux_A  => s_A_third_mux,
               imux_B  => s_O_second_mux,
               omux_E  => s_O_third_mux); 

  ----------------------
     
  s_A_fourth_mux(31 downto 8) <= s_O_third_mux(23 downto 0);
  s_A_fourth_mux(7 downto 0) <= x"00";   
  
  mux_4: mux_nbit
      port MAP(imux_SW => s_shiftAmount(3),
               imux_A  => s_A_fourth_mux,
               imux_B  => s_O_third_mux,
               omux_E  => s_O_fourth_mux); 
               
  ----------------------
     
  s_A_fifth_mux(31 downto 16) <= s_O_fourth_mux(15 downto 0);
  s_A_fifth_mux(15 downto 0) <= x"0000";   
  
  mux_5: mux_nbit
      port MAP(imux_SW => s_shiftAmount(4),
               imux_A  => s_A_fifth_mux,
               imux_B  => s_O_fourth_mux,
               omux_E  => s_O_fifth_mux);                
               
  ----------------------
   
  proc2: process(i_input, i_logical_arth, i_control_L_R, s_O_fifth_mux)
  begin
    if(i_control_L_R = '1') then
       
       if(i_logical_arth = '1') then
            
            keep_msb: for i in 0 to 31-input_integer loop
              o_F(i) <= s_O_fifth_mux(31-i); 
                end loop; 
            
            keep_msb2: for i in 0 to input_integer loop                
                o_F(31-i) <= i_input(31); 
                end loop;
                          
       else 
            reverse: for i in 0 to 31 loop
              o_F(i) <= s_O_fifth_mux(31-i);
            end loop;
       end if;

         
    else    
       o_F <= s_O_fifth_mux;
    end if;  
  end process proc2;            
 
end structure; 
             