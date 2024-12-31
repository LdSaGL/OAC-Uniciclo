library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity immGen_tb is
end immGen_tb;

architecture immGen_tbArch of immGen_tb is

    -- declaração do componente
    component immGen
        Port ( 
            instruction : in  STD_LOGIC_VECTOR (31 downto 0);
            imm : out  SIGNED (31 downto 0)
            );
    end component;
    
    -- declaração de sinais
    signal instruction_tb : STD_LOGIC_VECTOR (31 downto 0);
    signal imm_tb : SIGNED (31 downto 0);

begin

    uut: immGen port map (
        instruction => instruction_tb, 
        imm => imm_tb);

    process
    begin
        -- casos de teste
        instruction_tb <= X"000002B3";
        wait for 10 ns;
        instruction_tb <= X"01002283";
        wait for 10 ns;
        instruction_tb <= X"F9C00313";
        wait for 10 ns;
        instruction_tb <= X"FFF2C293";
        wait for 10 ns;
        instruction_tb <= X"16200313";
        wait for 10 ns;
        instruction_tb <= X"01800067";
        wait for 10 ns;
        instruction_tb <= X"40A3D313";
        wait for 10 ns;
        instruction_tb <= X"00002437";
        wait for 10 ns;
        instruction_tb <= X"02542E23";
        wait for 10 ns;
        instruction_tb <= X"FE5290E3";
        wait for 10 ns;
        instruction_tb <= X"00C000EF";
        wait for 10 ns;

        end process;
end immGen_tbArch;