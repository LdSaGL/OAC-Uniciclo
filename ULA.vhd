library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ulaRV is
    generic (WSIZE : natural := 32);
    port (
        opcode : in std_logic_vector(3 downto 0);
        A, B : in std_logic_vector(WSIZE-1 downto 0);
        Z : out std_logic_vector(WSIZE-1 downto 0);
        zero : out std_logic
        );
end ulaRV;

architecture ulaRV_arch of ulaRV is

    signal a32 : std_logic_vector(31 downto 0);

begin
    Z<=a32;

    process (opcode, A, B)
    begin
        
    case opcode is
        -- ADD
        when "0000" =>
            a32 <= std_logic_vector(signed(A) + signed(B));
        -- SUB
        when "0001" =>
            a32 <= std_logic_vector(signed(A) - signed(B));
        -- AND
        when "0010" =>
            a32 <= A and B;
        -- OR
        when "0011" =>
            a32 <= A or B;
        -- XOR
        when "0100" =>
            a32 <= A xor B;
        -- SLL
        when "0101" =>
            a32 <= std_logic_vector(shift_left(unsigned(A), to_integer(unsigned(B(4 downto 0)))));
        -- SRL
        when "0110" =>
            a32 <= std_logic_vector(shift_right(unsigned(A), to_integer(unsigned(B(4 downto 0)))));
        -- SRA
        when "0111" =>
            a32 <= std_logic_vector(shift_right(signed(A), to_integer(unsigned(B(4 downto 0)))));
        -- SLT
        when "1000" =>
            if signed(A) < signed(B) then
                a32 <= "00000000000000000000000000000001";
            else
                a32 <= "00000000000000000000000000000000";
            end if;
        -- SLTU
        when "1001" =>
            if unsigned(A) < unsigned(B) then
                a32 <= "00000000000000000000000000000001";
            else
                a32 <= "00000000000000000000000000000000";
            end if;
        -- SGE
        when "1010" =>
            if signed(A) >= signed(B) then
                a32 <= "00000000000000000000000000000001";
            else
                a32 <= "00000000000000000000000000000000";
            end if;
        -- SGEU
        when "1011" =>
            if unsigned(A) >= unsigned(B) then
                a32 <= "00000000000000000000000000000001";
            else
                a32 <= "00000000000000000000000000000000";
            end if;
        -- SEQ
        when "1100" =>
            if A = B then
                a32 <= "00000000000000000000000000000001";
            else
                a32 <= "00000000000000000000000000000000";
            end if;
        -- SNE
        when "1101" =>
            if A /= B then
                a32 <= "00000000000000000000000000000001";
            else
                a32 <= "00000000000000000000000000000000";
            end if;
	when others =>
                a32 <= "00000000000000000000000000000000";

	end case;
    
    if a32 = "00000000000000000000000000000000" then
        zero <= '1';
    else
        zero <= '0';
    end if;

    end process;

end ulaRV_arch;