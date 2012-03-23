library ieee ;
  use ieee.std_logic_1164.all ;
  use ieee.numeric_std.all ;

entity link_helper is
  port (  wdata_out : out std_logic_vector(31 downto 0);
          waddr_out : out std_logic_vector(4 downto 0);
          wdata_in : in std_logic_vector(31 downto 0);
          waddr_in : in std_logic_vector(4 downto 0);
          pc : in std_logic_vector(31 downto 0);
          and_link : in std_logic;
  ) ;
end entity ; -- link_helper

architecture arch of link_helper is

begin
  -- If and_link = 1, 
    --output pc to wdata_out and set waddr_in to $ra (r31)
  -- If and_link = 0
    -- output wdata_in to wdata_out and waddr_in to waddr_out
    
  with and_link select
    wdata_out <= pc when '1',
              <= wdata_in when others;
              
  with and_link select
    waddr_out <= "11111" when '1',
              <= waddr_in when others;

end architecture ; -- arch