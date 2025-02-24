library ieee;
use ieee.std_logic_1164.all;

entity mux is
  port (
    mux_input1, mux_input2 : in std_logic_vector(31 downto 0);
    sel : in std_logic;
    mux_out : out std_logic_vector(31 downto 0)
  );
end mux;

architecture mux_arch of mux is   
begin
    mux_out <= mux_input1 when sel = '1' else mux_input2;
end mux_arch ;