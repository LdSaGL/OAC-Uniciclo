library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity xregs_tb is
end entity xregs_tb;

architecture xregs_tb_arch of xregs_tb is

    component XREGS is
        port (
            clk, wren: in std_logic; 
            rs1, rs2, rd: in std_logic_vector(4 downto 0);
            data: in std_logic_vector(31 downto 0); 
            ro1, ro2: out std_logic_vector(31 downto 0));
    end component;

    signal clk, wren: std_logic := '0';
    signal rs1, rs2, rd: std_logic_vector(4 downto 0) := (others => '0');
    signal data: std_logic_vector(31 downto 0);
    signal ro1, ro2: std_logic_vector(31 downto 0);

begin

    Dut: XREGS port map (
            clk => clk, wren => wren, 
            rs1 => rs1, rs2 => rs2, rd => rd,
            data => data, 
            ro1 => ro1, ro2 => ro2);
    
    process
        begin
        data <= X"24924927";
        rd <= "00011";
        wren <= '1';
        clk <= '1';
        wait for 10 ns;
        clk <= '0';
        wait for 10 ns;

        data <= X"76b2cd77";
        rd <= "00100";
        wren <= '1';
        clk <= '1';
        wait for 10 ns;
        clk <= '0';
        wait for 10 ns;

        rs1 <= "00011";
        rs2 <= "00100";
        wren <= '0';
        clk <= '1';
        wait for 10 ns;
        clk <= '0';
        wait for 10 ns;

        assert (ro1 = X"24924927") report "IN READ/WRITE: Wrong register 1 content" severity error;
        assert (ro2 = X"76b2cd77") report "IN READ/WRITE: Wrong register 2 content" severity error;

        data <= X"24924927";
        rd <= "00000";
        wren <= '1';
        clk <= '1';
        wait for 10 ns;
        clk <= '0';
        wait for 10 ns;

        rs1 <= "00000";
        wren <= '0';
        clk <= '1';
        wait for 10 ns;
        clk <= '0';
        wait for 10 ns;

        assert (ro1 = X"00000000") report "Content of register 0 modified" severity error;

        clk <= '1';
        wait for 10 ns;
        clk <= '0';
        wait for 10 ns;

        rs1 <= "00011";
        rs2 <= "00100";
        wren <= '0';
        clk <= '1';
        wait for 10 ns;
        clk <= '0';
        wait for 10 ns;

        assert (ro1 = X"00000000") report "IN RESET: Wrong register 1 content" severity error;
        assert (ro2 = X"00000000") report "IN RESET: Wrong register 2 content" severity error;

        assert false report "Test done." severity note;
        wait;
    end process;
    end architecture xregs_tb_arch;
