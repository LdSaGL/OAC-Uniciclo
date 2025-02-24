library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rv_uniciclo_tb is
end entity rv_uniciclo_tb;

architecture tb_arch of rv_uniciclo_tb is

component rv_uniciclo is
    port (
        clk		: in std_logic;
        rst	    : in std_logic;
        data  	: out std_logic_vector(31 downto 0));
end component;

signal clock_in : std_logic;
signal rst : std_logic;
signal data_out : std_logic_vector(31 downto 0);

begin
    rv_uniciclo_i: rv_uniciclo port map(clock_in, rst, data_out);

    clk_gen: process begin
        clock_in <= '1'; wait for 100 ns;
        clock_in <= '0'; wait for 100 ns;
    end process clk_gen;

    drive: process begin
        rst <= '0';
   		wait;
   end process drive;
end architecture tb_arch;
