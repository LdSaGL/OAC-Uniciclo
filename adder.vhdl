library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
    generic (
        SIZE : natural := 32);
    port (
        a   : in std_logic_vector (SIZE - 1 downto 0);
        b   : in std_logic_vector (SIZE - 1 downto 0);
        sum : out std_logic_vector (SIZE - 1 downto 0));
end adder;

architecture behavioral of adder is
begin
    sum <= std_logic_vector(signed(a) + signed(b));
end architecture behavioral;
