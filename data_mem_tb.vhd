library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_data_mem is
end tb_data_mem;

architecture tb_arch of tb_data_mem is
    constant SIZE  : natural := 32;
    constant WADDR : natural := 13;
    
    signal clk      : std_logic := '0';
    signal address  : std_logic_vector(WADDR - 1 downto 0);
    signal data     : std_logic_vector(SIZE - 1 downto 0) := (others => '0');
    signal wren     : std_logic := '0';
    signal mem_read : std_logic := '0';
    signal Q        : std_logic_vector(SIZE - 1 downto 0);

    constant CLK_PERIOD : time := 10 ns;

    -- Instanciando a memória de dados
    component data_mem
        generic (
            SIZE    : natural := 32;
            WADDR   : natural := 13
        );
        port (
            address     : in std_logic_vector (WADDR - 1 downto 0);
            clk         : in std_logic;
            data        : in std_logic_vector (SIZE - 1 downto 0);
            wren        : in std_logic;
            mem_read    : in std_logic;
            Q           : out std_logic_vector (SIZE - 1 downto 0)
        );
    end component;

begin
    -- Instanciação da memória
    uut: data_mem
        generic map (
            SIZE  => SIZE,
            WADDR => WADDR
        )
        port map (
            address  => address,
            clk      => clk,
            data     => data,
            wren     => wren,
            mem_read => mem_read,
            Q        => Q
        );

    -- Clock process
    process
    begin
        while now < 200 ns loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Processo de Leitura (Testando se os valores do arquivo foram carregados)
    process
    begin
        -- Lendo o primeiro endereço (0x0000)
        address  <= std_logic_vector(to_unsigned(0, WADDR));
        mem_read <= '1';
        wait for CLK_PERIOD;

        -- Lendo o segundo endereço (0x0004)
        address  <= std_logic_vector(to_unsigned(4, WADDR));
        wait for CLK_PERIOD;

        -- Lendo o terceiro endereço (0x0008)
        address  <= std_logic_vector(to_unsigned(8, WADDR));
        wait for CLK_PERIOD;

        -- Finalizar simulação
        wait;
    end process;

end tb_arch;
