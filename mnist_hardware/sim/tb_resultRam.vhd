library ieee;
    use ieee.std_logic_1164.all;
    use ieee.NUMERIC_STD.all;
    use IEEE.std_logic_unsigned.ALL;
	
library work;
    use work.Types.all;
	
library std;
    use std.textio.all;

entity tb_resultRam is
end entity;

architecture rtl_sim of tb_resultRam is

    constant depth_size: integer := 32;
    constant size: integer := 5;
    constant ram_size: integer := 28;
	
    constant NrOfInputs: integer := 8;

    constant CLK_PERIOD: time := 10 ns;
    signal clk: std_logic;
    signal ena: std_logic;
    signal wea: std_logic;
    signal depth: integer range 0 to depth_size - 1;
    signal addressX: integer range 0 to size - 1;
    signal addressY: integer range 0 to size - 1;
    signal dia: ram_input(nrOfInputs-1 downto 0);
    signal doa: MAC_inputs;

begin

    resultRam_inst: entity work.resultRam
        generic map (
            depth_size => depth_size,
            size       => size,
	        ram_size   => ram_size,
            NrOfInputs => NrOfInputs
        )
        port map (
            clk        => clk,
            ena        => ena,
            wea        => wea,
            depth      => depth,
            addressX   => addressX,
            addressY   => addressY,
            dia        => dia,
            doa        => doa
        );

    stimuli_p: process is
    
    begin
        ena <= '0';
        wea <= '0';
        depth <= 0;
        addressX <= 0;
        addressY <= 0;
        dia <= (others => (others => '0'));
        
        wait until falling_edge(clk);
        
        ena <= '1';
        wea <= '1';
        
        for k in 0 to 20 loop
            for j in 0 to 20 loop
                for I in 0 to NrOfInputs - 1 loop
                    dia(I) <= std_logic_vector(to_unsigned(I + j + k,16));
                end loop;
                
                wait until rising_edge(clk);
                
                for I in 0 to NrOfInputs - 1 loop
                    assert (resultRam_inst.mem(depth)(addressX)(addressY) = std_logic_vector(to_unsigned(I + j + k,16))) report "SAVED NOT EQUAL TO EXPECTED" severity failure;
                end loop;
                
                addressX <= addressX + 1;
            end loop;
                addressX <= 0;
                addressY <= addressY + 1;
         end loop;
        
        report "Done" severity failure;
        
        wait;
        
    end process;

    clock_p: process is
    begin
        clk <= '0';
        wait for CLK_PERIOD / 2;
        clk <= '1';
        wait for CLK_PERIOD / 2;
    end process;

end architecture;

