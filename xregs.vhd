LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity XREGS is
    port (
        clk, wren: in std_logic; 
        rs1, rs2, rd: in std_logic_vector(4 downto 0);
        data: in std_logic_vector(31 downto 0); 
        ro1, ro2: out std_logic_vector(31 downto 0));
end XREGS;

architecture xregs_arch of XREGS is
    type memory is array (0 to 31) of std_logic_vector (31 downto 0);
    signal xreg : memory := (others => (others => '0'));
begin
    ro1 <=  xreg(to_integer(unsigned(rs1)));
    ro2 <=  xreg(to_integer(unsigned(rs2)));

    process(clk)
    begin
        if rising_edge(clk) then
            if ((wren = '1') and (to_integer(unsigned(rd)) /= 0)) then
                xreg(to_integer(unsigned(rd))) <= data;
            end if;
        end if;
    end process;
end xregs_arch ; 