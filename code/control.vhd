library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

--------------------------
-- Control Logic Module --
--------------------------
-- John Ryan and Juan Mozqueda

entity control is
  --port(
  --  );
end control;

architecture structure of control is
----------------
-- Components --
----------------
  component alu_32bit
    port( ian_op_sel : in std_logic_vector(2 downto 0);
          ian_A : in std_logic_vector(31 downto 0);
          ian_B : in std_logic_vector(31 downto 0);
          oan_result : out std_logic_vector(31 downto 0);
          oan_overflow : out std_logic );
  end component;

-------------
-- Signals --
-------------

---------------
-- Structure --
---------------
begin
end structure;