library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity inst_mem is
    port (
        address : in std_logic_vector(10 downto 0);
        Q       : out std_logic_vector(31 downto 0)
    );
end entity inst_mem;

architecture inst_mem_arch of inst_mem is
    type rom_type is array (0 to (2**address'length) - 1) of std_logic_vector(q'range);

    impure function init_rom_hex return rom_type is
        file text_file : text open read_mode is "instruction_memory.txt";
        variable text_line : line;
        variable rom_content : rom_type := (others => (others => '0'));
        begin
        for i in 0 to (2**address'length) - 1 loop
            if (not endfile(text_file)) then
                readline(text_file, text_line);
                hread(text_line, rom_content(i));
            end if;
        end loop;
        return rom_content;
    end function;


    signal rom : rom_type := init_rom_hex;

begin
    process(address)
    begin
        Q <= rom(to_integer(unsigned(address)));
    end process;
end architecture inst_mem_arch;