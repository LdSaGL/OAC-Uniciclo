library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ShiftLeft is
	port(
			imm_in : in std_logic_vector(31 downto 0);
			imm_out : out std_logic_vector(31 downto 0) := (others => '0'));
end ShiftLeft;

architecture arch of ShiftLeft is

begin

	imm_out <= imm_in(30 downto 0) & "0";
	
end arch;