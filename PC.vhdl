library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
	port(
			clk : in std_logic;
			rst : in std_logic;
			pc_in : in std_logic_vector(31 downto 0);
			pc_out : out std_logic_vector(31 downto 0));
end PC;

architecture PC_arch of PC is

begin
	process (clk,rst)
	begin
		if rising_edge(clk) then
            if rst = '1' then
                pc_out <= (others => '0');
            else
				pc_out <= pc_in;
            end if;
        end if;
	end process;

end PC_arch;
