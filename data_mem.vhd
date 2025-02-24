library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity data_mem is
    port (
        address	    : in std_logic_vector (9 downto 0);
        clk	        : in std_logic;
        data	    : in std_logic_vector (31 downto 0);
        wren	    : in std_logic;
        mem_read    : in std_logic;
        Q		    : out std_logic_vector (31 downto 0) := (others => '0'));
end entity data_mem;

architecture data_mem_arch of data_mem is
    type data_mem_type is array (0 to (2**address'length) - 1) of std_logic_vector(data'range);

    impure function init_ram_hex return data_mem_type is
        file text_file : text open read_mode is "data_memory.txt";
        variable text_line : line;
        variable ram_content : data_mem_type := (others => (others => '0'));
        begin
        for i in 0 to (2**address'length) - 1 loop
            if (not endfile(text_file)) then
                readline(text_file, text_line);
                hread(text_line, ram_content(i));
            end if;
        end loop;
        return ram_content;
    end function;

    signal mem : data_mem_type := init_ram_hex;

begin
    Q <= mem(to_integer(unsigned(address))) when mem_read = '1' else (others => '0');
    process(clk)
    begin
        if rising_edge(clk) then
            if wren = '1' then 
                mem(to_integer(unsigned(address))) <= data;
            end if;
        end if;
    end process;
end architecture data_mem_arch;


