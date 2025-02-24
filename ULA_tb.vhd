library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ulaRV_tb is
end entity ulaRV_tb;

architecture ulaRV_tb_arch of ulaRV_tb is

    component ulaRV is
        port (
            opcode : in std_logic_vector(3 downto 0);
            A, B : in std_logic_vector(31 downto 0);
            Z : out std_logic_vector(31 downto 0);
            zero : out std_logic);
    end component ulaRV;

    signal opcode_in : std_logic_vector(3 downto 0);
    signal A_in, B_in : std_logic_vector(31 downto 0);
    signal Z_out : std_logic_vector(31 downto 0);
    signal zero_out : std_logic;

begin
    dut: ulaRV port map(opcode_in, A_in, B_in, Z_out, zero_out);

    process
        begin
            opcode_in <= "0000"; -- ADD

            A_in <= X"CB567843";
            B_in <= X"12BC5678";

            wait for 10 ns;
    
            A_in <= X"78CB5E6D";
            B_in <= X"8734A193";
            
            wait for 10 ns;
        
            opcode_in <= "0001"; -- SUB

            A_in <= X"CB567843";
            B_in <= X"00000001";
            
            wait for 10 ns;
            
            A_in <= X"CB567843";
            B_in <= X"CB567843";
            
            wait for 10 ns;
   
            opcode_in <= "0010"; -- AND

            A_in <= X"CB567843";
            B_in <= X"FFFFFFFF";
            
            wait for 10 ns;
    
            A_in <= X"F0F0F0F0";
            B_in <= X"0F0F0F0F";
            
            wait for 10 ns;
    
            opcode_in <= "0011"; -- OR

            A_in <= X"CB567843";
            B_in <= X"FFFFFFFF";
            
            
            wait for 10 ns;
   
            A_in <= X"CBCBCBCB";
            B_in <= X"BCBCBCBC";
            
            wait for 10 ns;
   
            A_in <= X"00000000";
            B_in <= X"00000000";
            
            wait for 10 ns;
   
            opcode_in <= "0100"; -- XOR

            A_in <= X"CB567843";
            B_in <= X"00000000";
            
            wait for 10 ns;
   
            A_in <= X"F0F0F0F0";
            B_in <= X"0F0F0F0F";
            
            wait for 10 ns;
   
            A_in <= X"FFFFFFFF";
            B_in <= X"FFFFFFFF";
            
            wait for 10 ns;
          
            opcode_in <= "0101"; -- SLL

            A_in <= X"0000000F";
            B_in <= X"00000004";
            
            wait for 10 ns;
           
            opcode_in <= "0110"; -- SRL

            A_in <= X"8000000F";
            B_in <= X"00000004";
            
            wait for 10 ns;
         
            A_in <= X"0000000F";
            B_in <= X"00000004";
            
            wait for 10 ns;
   
            opcode_in <= "0111"; -- SRA

            A_in <= X"000000F0";
            B_in <= X"00000004";
            
            wait for 10 ns;
    
            opcode_in <= "1000"; -- SLT

            A_in <= X"00000005";
            B_in <= X"00000010";
            
            wait for 10 ns;
    
            A_in <= X"FFFFFFE0";
            B_in <= X"00000005";
            
            wait for 10 ns;
   
            opcode_in <= "1001"; -- SLTU

            A_in <= X"FFFFFFE0";
            B_in <= X"FFFFFFC0";
            
            wait for 10 ns;
   
            B_in <= X"FFFFFFE0";
            A_in <= X"FFFFFFC0";
            
            wait for 10 ns;
   
            opcode_in <= "1010"; -- SGE

            A_in <= X"FFFFFFE0";
            B_in <= X"FFFFFFC0";
            
            wait for 10 ns;
    
            A_in <= X"CB567843";
            B_in <= X"CB567843";
            
            wait for 10 ns;
    
            A_in <= X"00000020";
            B_in <= X"FFFFFFE0";
            
            wait for 10 ns;
            
            opcode_in <= "1011"; -- SGEU

            A_in <= X"CB567843";
            B_in <= X"CB567843";
            
            wait for 10 ns;
  
            A_in <= X"00000010";
            B_in <= X"00000020";
            
            wait for 10 ns;
   
            opcode_in <= "1100"; -- SEQ
    
            A_in <= X"00000010";
            B_in <= X"00000020";
            
            wait for 10 ns;
    
            A_in <= X"00000020";
            B_in <= X"00000020";
            
            wait for 10 ns;

            opcode_in <= "1101"; -- SNE

            A_in <= X"00000010";
            B_in <= X"00000020";

            wait for 10 ns;

            A_in <= X"00000020";
            B_in <= X"00000020";

            wait; 
        end process;

end ulaRV_tb_arch ; -- ulaRV_tb_arch