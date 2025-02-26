library ieee;
use ieee.std_logic_1164.all;

entity muxUtype is
  port (
    mux_input1, mux_input2, mux_input3: in std_logic_vector(31 downto 0);
    sel : in std_logic_vector(1 downto 0);
    mux_out : out std_logic_vector(31 downto 0)
  );
end muxUtype;

architecture muxUtype_arch of muxUtype is   
begin
    mux_out <= mux_input1 when sel = "00" else -- demais instrucoes
               mux_input2 when sel = "01" else -- lui
               mux_input3; -- auipc
end muxUtype_arch ;