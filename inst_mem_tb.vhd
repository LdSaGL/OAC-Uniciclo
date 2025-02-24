library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity inst_mem_tb is
end entity inst_mem_tb;

architecture tb_arch of inst_mem_tb is
    -- Componente da memória de instruções
    component inst_mem
        port (
            address : in std_logic_vector(10 downto 0);
            Q       : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Sinais
    signal address : std_logic_vector(10 downto 0) := (others => '0');
    signal Q       : std_logic_vector(31 downto 0);

begin
    -- Instancia a memória de instruções
    uut: inst_mem
        port map (
            address => address,
            Q       => Q
        );

    -- Processo de estímulo
    stim_proc: process
    begin
        -- Testa os primeiros 10 endereços
        for i in 0 to 9 loop
            address <= std_logic_vector(to_unsigned(i, WADDR));
            wait for 10 ns;
        end loop;
        
        -- Finaliza a simulação
        wait;
    end process;

end architecture tb_arch;
