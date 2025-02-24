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

architecture xreg_arch of XREGS is
    type reg_array is array (0 to 31) of std_logic_vector(31 downto 0);
    signal regs: reg_array;

begin
    process(clk)
        begin
            if rising_edge(clk) then
                if (to_integer(unsigned(rs1)) = 0) then
                    ro1 <= (others => '0');
                elsif (to_integer(unsigned(rs1)) /= 0) then
                    ro1 <= regs(to_integer(unsigned(rs1)));
                end if;
                if (to_integer(unsigned(rs2)) = 0) then
                    ro2 <= (others => '0');
                elsif (to_integer(unsigned(rs2)) /= 0) then
                    ro2 <= regs(to_integer(unsigned(rs2)));
                end if;
                if wren = '1' then
                    if (to_integer(unsigned(rd)) = 0) then
                        regs(to_integer(unsigned(rd))) <= (others => '0');
                    else
                        regs(to_integer(unsigned(rd))) <= data;
                    end if; 
                end if;
            end if;
	end process;
end xreg_arch ;