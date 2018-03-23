library ieee;
    use ieee.std_logic_1164.all;
    use ieee.NUMERIC_STD.all;

library work;
    use work.Types.all;

library std;
    use std.textio.all;



entity tb_top is 
end entity;

architecture rtl of tb_top is
    
    component FirstRom is
        port (
            clk      : in std_logic;
            addressX : in integer range 0 to 27;
            addressY : in integer range 0 to 27;
            addressZ : in integer range 0 to 2;
            output   : out unsigned(15 downto 0)
        );
    end component;
    
    component MACFullFilter is
        port (
            clk           : in std_logic;
            rst           : in std_logic;
            start         : in std_logic;
            filtersLayers : in unsigned(1 downto 0);
            Filter        : in unsigned(4 downto 0);
            input         : in MAC_inputs;
            computed      : out std_logic;
            result        : out MAC_result
        );
    end component;
    
    component resultRam is
        generic (
            depth_size :  integer := 32;
            size       :  integer := 5;
            ram_size   :  integer := 28;
            NrOfInputs :  integer := 8
        );
        port (
            clk        : in std_logic;
            ena        : in std_logic;
            wea        : in std_logic;
            depth      : in integer range 0 to depth_size - 1;
            addressX   : in integer range 0 to ram_size - 1;
            addressY   : in integer range 0 to ram_size - 1;
            dia        : in ram_input(NrOfINputs - 1 downto 0);
            doa        : out MAC_inputs
        );
    end component;
    
    
    constant CLK_PERIOD: time := 10 ns;
    signal clk: std_logic;
    signal rst: std_logic:='0';
    
    
    variable input_mac: MAC_inputs;
    variable input_weight_mac: MAC_weights;
    variable output_mac: ram_input(7 downto 0);
    
    variable filter: integer range 0 to 31;
    variable addressZ: integer range 0 to 2;
    
    
    signal start: std_logic := '0'; 
    
begin
    
    
   
    GEN_MACFull: for I in 0 to 24 generate
        MACFullFilter_inst: MACFullFilter
            port map (
                clk           => clk,
                rst           => rst,
                start         => start,
                filtersLayers => filtersLayers,
                Filter        => Filter,
                input         => input,
                computed      => computed,
                result        => result
            );

    end generate;
    
    
    

        

    stimuli_p: process is
    begin
        
        
        
        wait until rising_edge(clk);
        
        
        
        
    end process;
    
    
    clock_p: process is
    begin
        clk <= '0';
        wait for CLK_PERIOD / 2;
        clk <= '1';
        wait for CLK_PERIOD / 2;
    end process;
    
    reset_p: process is
    begin
        rst <= '1';
        wait for 4 * CLK_PERIOD;
        rst <= '0';
        wait;
    end process;
end architecture;