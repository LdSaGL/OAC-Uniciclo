library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ula_control is
    port (
        aluOp   : in std_logic_vector(1 downto 0);
        funct3  : in std_logic_vector(2 downto 0); -- op dentro do opcode
        funct7  : in std_logic; -- determina se e add/sub ou sra/srl
        aluCtrl : out std_logic_vector(3 downto 0) := (others => '0'));
end ula_control;

architecture behavioral of ula_control is
begin
    process(aluOp, funct3, funct7)
    begin
        case aluOp is
            -- load/store usa add para calcular endereço
            when "00" =>
                aluCtrl <= "0000"; -- ADD

            -- B-Type - operaçoes de branch
            when "01" =>
                case funct3 is
                    when "000" => aluCtrl <= "1100"; -- BEQ (SEQ)
                    when "001" => aluCtrl <= "1101"; -- BNE (SNE)
                    when "100" => aluCtrl <= "1000"; -- BLT (SLT)
                    when "101" => aluCtrl <= "1010"; -- BGE (SGE)
                    when "110" => aluCtrl <= "1001"; -- BLTU (SLTU)
                    when "111" => aluCtrl <= "1011"; -- BGEU (SGEU)
                    when others => aluCtrl <= "0000";
                end case;

            -- R-Type - operaçoes com registradores
            when "10" =>
                case funct3 is
                    when "000" => 
                        if funct7 = '1' then
                            aluCtrl <= "0001"; -- SUB
                        else
                            aluCtrl <= "0000"; -- ADD
                        end if;
                    when "111" => aluCtrl <= "0010"; -- AND
                    when "001" => aluCtrl <= "0101"; -- SLL
                    when "010" => aluCtrl <= "1000"; -- SLT
                    when "011" => aluCtrl <= "1001"; -- SLTU
                    when "100" => aluCtrl <= "0100"; -- XOR
                    when "101" => 
                        if funct7 = '1' then
                            aluCtrl <= "0111"; -- SRA
                        else
                            aluCtrl <= "0110"; -- SRL
                        end if;
                    when "110" => aluCtrl <= "0011"; -- OR
                    when others => aluCtrl <= "0000"; -- Caso default (ADD)
                end case;

            -- I-Type - operacoes com imediatos
            when "11" =>
                case funct3 is
                    when "000" => aluCtrl <= "0000"; -- ADDI (ADD)
                    when "001" => aluCtrl <= "0101"; -- SLLI
                    when "010" => aluCtrl <= "1000"; -- SLTI
                    when "011" => aluCtrl <= "1001"; -- SLTIU
                    when "100" => aluCtrl <= "0100"; -- XORI
                    when "101" => 
                        if funct7 = '1' then
                            aluCtrl <= "0111"; -- SRAI
                        else
                            aluCtrl <= "0110"; -- SRLI
                        end if;
                    when "110" => aluCtrl <= "0011"; -- ORI
                    when "111" => aluCtrl <= "0010"; -- ANDI
                    when others => aluCtrl <= "0000";
                end case;

            when others => aluCtrl <= "0000"; 
        end case;
    end process;
end architecture behavioral;
