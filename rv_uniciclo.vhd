library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rv_uniciclo is
    port (
        clk		: in std_logic;
        rst	    : in std_logic := '0';
        data  	: out std_logic_vector(31 downto 0)
    );
end rv_uniciclo;

architecture rtl of rv_uniciclo is

    -- Declaracao de componentes

    component PC is
        port (
            clk	    : in  std_logic;
            rst	    : in  std_logic;
            pc_in	: in  std_logic_vector(31 downto 0);
            pc_out	: out std_logic_vector(31 downto 0)
        );
    end component;

    component mux is
        port (
            mux_input1, mux_input2  : in  std_logic_vector(31 downto 0);
            sel		        : in  std_logic;
            mux_out		    : out std_logic_vector(31 downto 0)
        );
    end component;

    component adder is
        port (
            a	    : in  std_logic_vector(31 downto 0);
            b	    : in  std_logic_vector(31 downto 0);
            sum     : out std_logic_vector(31 downto 0)
        );
    end component;

    component inst_mem is
        port (
            address : in  std_logic_vector(10 downto 0);
            Q 	    : out std_logic_vector(31 downto 0)
        );
    end component;

    component ulaRV is
        port (
            opcode  : in  std_logic_vector(3 downto 0);
            A, B    : in  std_logic_vector(31 downto 0);
            Z       : out std_logic_vector(31 downto 0);
            zero    : out std_logic
        );
    end component;

    component xregs is
        port (
            clk		: in  std_logic;
            wren  	: in  std_logic;
            rs1		: in  std_logic_vector(4 downto 0);
            rs2		: in  std_logic_vector(4 downto 0);
            rd      : in  std_logic_vector(4 downto 0);
            data	: in  std_logic_vector(31 downto 0);
            ro1 	: out std_logic_vector(31 downto 0);
            ro2	 	: out std_logic_vector(31 downto 0)
        );
    end component;

    component ula_control is
        port (
            aluOp	: in  std_logic_vector(1 downto 0);
            funct3	: in  std_logic_vector(2 downto 0);
            funct7	: in  std_logic;
            aluCtrl	: out std_logic_vector(3 downto 0)
        );
    end component;

    component control is
        port (
            opcode     : in  std_logic_vector(6 downto 0);
            branch     : out std_logic;
            memRead    : out std_logic;
            memToReg   : out std_logic;
            aluOp      : out std_logic_vector(1 downto 0);
            memWrite   : out std_logic;
            aluSrc     : out std_logic;
            regWrite   : out std_logic;
        );
    end component;

    component data_mem is
        port (
            address	    : in std_logic_vector (12 downto 0);
            clk	        : in std_logic;
            data	    : in std_logic_vector (31 downto 0);
            wren	    : in std_logic;
            mem_read    : in std_logic;
            Q		    : out std_logic_vector (31 downto 0)
        );
    end component;

    -- Sinais internos
    signal PCout        : std_logic_vector(31 downto 0) := (others => '0');
    signal PCin         : std_logic_vector(31 downto 0) := (others => '0');
    signal instruction  : std_logic_vector(31 downto 0);
    signal PCplus4      : std_logic_vector(31 downto 0);
    signal PCcond       : std_logic_vector(31 downto 0);
    signal regData      : std_logic_vector(31 downto 0);
    signal rd_data      : std_logic_vector(31 downto 0);
    signal data_mem_ou  : std_logic_vector(31 downto 0);
    signal ulaA, ulaB   : std_logic_vector(31 downto 0);
    signal ulaResult    : std_logic_vector(31 downto 0);
    signal regA, regB   : std_logic_vector(31 downto 0);
    signal imm32        : std_logic_vector(31 downto 0);

    signal ulaCtrl     : std_logic_vector(3 downto 0);
    signal ulaOp       : std_logic_vector(1 downto 0);

    signal branch      : std_logic;
    signal memRead     : std_logic;
    signal memToReg    : std_logic;
    signal memWrite    : std_logic;
    signal aluSrc      : std_logic;
    signal regWrite    : std_logic;

    -- Alias dos campos da instrucao
    alias opcode_field   : std_logic_vector(6 downto 0) is instruction(6 downto 0);
    alias rs1_field      : std_logic_vector(4 downto 0) is instruction(19 downto 15);
    alias rs2_field      : std_logic_vector(4 downto 0) is instruction(24 downto 20);
    alias rd_field       : std_logic_vector(4 downto 0) is instruction(11 downto 7);
    alias funct3_field   : std_logic_vector(2 downto 0) is instruction(14 downto 12);
    alias funct7_field   : std_logic is instruction(30);
    alias instr_mem_addr : std_logic_vector(10 downto 0) is PCout(11 downto 02);
    alias data_mem_addr  : std_logic_vector(12 downto 0) is ulaResult(11 downto 02);

begin

    data <= PCout;  -- Saida do PC

    -- Instanciacao dos componentes

end architecture rtl;
