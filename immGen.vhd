library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity immGen is
    Port ( instruction : in  STD_LOGIC_VECTOR (31 downto 0);
           imm : out  SIGNED (31 downto 0));
end immGen;

architecture immGenArch of immGen is

    begin 
        process(instruction)
        begin
            -- cada opcode tem 7 bits
            case instruction (6 downto 0) is
            when "0110011" =>  -- R-type instructions
            imm <= resize(X"0", 32);
        end case;
    end process;
end immGenArch;
