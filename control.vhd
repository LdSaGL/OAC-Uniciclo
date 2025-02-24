library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity control is
    port (
        opcode   : in std_logic_vector(6 downto 0);
        branch   : out std_logic;
        memRead  : out std_logic;
        memToReg : out std_logic;
        aluOp    : out std_logic_vector(1 downto 0);
        memWrite : out std_logic;
        aluSrc   : out std_logic;
        regWrite : out std_logic
    );
end control;

architecture control_arch of control is
    begin
        process(opcode)
        begin
            case opcode is
                when "0110011" => -- R-Type: ADD, SUB, AND, OR, XOR, SLT, SRL, SRA, SLL, SLTU
                    branch      <= '0';
                    memRead     <= '0';
                    memToReg    <= '0';
                    aluOp       <= "10";
                    memWrite    <= '0';
                    aluSrc      <= '0';
                    regWrite    <= '1';
                
                when "0010011" => -- I-Type: ADDI, SLTI, ANDI, ORI, XORI, SLLI, SRLI, SRAI
                    branch      <= '0';
                    memRead     <= '0';
                    memToReg    <= '0';
                    aluOp       <= "11";
                    memWrite    <= '0';
                    aluSrc      <= '1';
                    regWrite    <= '1';

                when "0000011" => -- ILoad-Type: LB, LW, LBU
                    branch      <= '0';
                    memRead     <= '1';
                    memToReg    <= '1';
                    aluOp       <= "00";
                    memWrite    <= '0';
                    aluSrc      <= '1';
                    regWrite    <= '1';

                when "0100011" => -- S-Type: SW, SB
                    branch      <= '0';
                    memRead     <= '0';
                    memToReg    <= '0';
                    aluOp       <= "00";
                    memWrite    <= '1';
                    aluSrc      <= '1';
                    regWrite    <= '0';

                when "1100011" => -- B-Type: BEQ, BNE
                    branch      <= '1';
                    memRead     <= '0';
                    memToReg    <= '0';
                    aluOp       <= "01";
                    memWrite    <= '0';
                    aluSrc      <= '0';
                    regWrite    <= '0';
                    
                when others => null;
            end case ;
        end process;
    end architecture control_arch;
    