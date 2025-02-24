library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity immGen is
    Port ( instruction : in  STD_LOGIC_VECTOR (31 downto 0);
           imm : out  std_logic_vector (31 downto 0));
end immGen;

architecture immGenArch of immGen is
begin
    process(instruction)
    begin
        -- cada opcode tem 7 bits
        case instruction(6 downto 0) is
            when "0110011" =>  -- R-type
                imm <= (others => '0');  -- Zero para R-type

            when "0000011" | "0010011" | "1100111" =>  -- I-type
                imm <= std_logic_vector(resize(signed(instruction(31 downto 20)), 32));

            when "0100011" =>  -- S-type
                imm <= std_logic_vector(resize(signed(instruction(31 downto 25) & instruction(11 downto 7)), 32));

            when "1100011" =>  -- SB-type
                imm <= std_logic_vector(resize(signed(instruction(31) & instruction(7) & instruction(30 downto 25) & instruction(11 downto 8) & "0"), 32));

            when "1101111" =>  -- UJ-type
                imm <= std_logic_vector(resize(signed(instruction(31) & instruction(19 downto 12) & instruction(20) & instruction(30 downto 21) & "0"), 32));

            when "0110111" =>  -- U-type
                imm <= std_logic_vector(resize(signed(instruction(31 downto 12) & "000000000000"), 32));

            when others =>  -- zerar em todos os casos não mapeados
                imm <= (others => '0');  -- Zero para casos não mapeados
            
        end case;
    end process;
end immGenArch;
