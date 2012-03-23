library ieee ;
  use ieee.std_logic_1164.all ;
  use ieee.numeric_std.all ;

entity branch_helper is
  port (  out_branch : out std_logic;
          in_branch : in std_logic;
          zero_should_be : in std_logic;
          zero : in std_logic ) ;
end entity ; -- branch_helper

architecture arch of branch_helper is

begin

-- zero zero_should_be need to be the same 
out_branch <= in_branch AND NOT (zero XOR zero_should_be);

end architecture ; -- arch
