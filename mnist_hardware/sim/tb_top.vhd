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
    component weightsRom is
        generic (
            addressX :  integer range 0 to 4;
            addressY :  integer range 0 to 4
        );
        port (
            clk      : in std_logic;
            rst      : in std_logic;
            filter   : in integer range 0 to 31;
            addressZ : in integer range 0 to 2;
            output   : out signed(7 downto 0)
        );
    end component;
   
    component MAC is
        port (
            clk     : in std_logic;
            rst     : in std_logic;
            weight  : in MAC_weights;
            neurons : in MAC_inputs;
            results : out MAC_result
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
    
begin
    
    
    GEN_ROM_X: for X in 0 to 4 generate
        GEN_ROM_Y: for Y in 0 to 4 generate
            
            weightsRom_inst: weightsRom
                generic map (
                    addressX => X,
                    addressY => Y
                )
                port map (
                    clk      => clk,
                    rst      => rst,
                    filter   => filter,
                    addressZ => addressZ,
                    output   => input_weight_mac(x*5+y)
                );
        end generate;
    end generate;
    
    GEN_MAC: for I in 0 to 24 generate
        MAC_inst: MAC
            port map (
                clk     => clk,
                rst     => rst,
                weight  => input_weight_mac,
                neurons => input_mac,
                results => output_mac(I)
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