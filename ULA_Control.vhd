library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ula_control is
    port (
        aluOp   : in std_logic_vector(1 downto 0);
        funct3  : in std_logic_vector(2 downto 0); -- op dentro do opcode
        funct7  : in std_logic; -- determina se e add/sub ou sra/srl
        aluCtrl : out std_logic_vector(3 downto 0));
end ula_control;

architecture behavioral of ula_control is
begin
    process(aluOp, funct7, funct3)
    begin
        case aluOp is
            when "00" => -- acesso memoria
                aluCtrl <= "0000"; -- add
            when "01" => -- branch
                case funct3 is
                    when "000" => -- beq
                        aluCtrl <= "0001"; -- seq
                    when "001" => -- bne
                        aluCtrl <= "0010"; -- sne
                    when "100" => -- blt
                        aluCtrl <= "0011"; -- slt
                    when "101" => -- bge
                        aluCtrl <= "0100"; -- sge
                    when "110" => -- bltu
                        aluCtrl <= "0101"; -- sltu
                    when "111" => -- bgeu
                        aluCtrl <= "0110"; -- sgeu
                    when others => aluCtrl <= "0000"; -- default case
                end case;
            when "10" => -- R-Type
                case funct3 is
                    when "000" => -- add or sub
                        if (funct7 = '1') then
                            aluCtrl <= "1000"; -- sub
                        else
                            aluCtrl <= "0000"; -- add
                        end if;
                    when "001" => -- sll
                        aluCtrl <= "1001"; -- sll
                    when "010" => -- slt
                        aluCtrl <= "1010"; -- slt
                    when "011" => -- sltu
                        aluCtrl <= "1011"; -- sltu
                    when "100" => -- xor
                        aluCtrl <= "1100"; -- xor
                    when "101" => -- srl or sra
                        if (funct7 = '1') then
                            aluCtrl <= "1101"; -- sra
                        else
                            aluCtrl <= "1110"; -- srl
                        end if;
                    when "110" => -- or
                        aluCtrl <= "1111"; -- or
                    when "111" => -- and
                        aluCtrl <= "0111"; -- and
                    when others => aluCtrl <= "0000"; -- default case
                end case;
            when others => aluCtrl <= "0000"; -- default case
        end case;
    end process;
end architecture behavioral;
