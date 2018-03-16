library ieee;
    use ieee.std_logic_1164.all;
    use ieee.NUMERIC_STD.all;

library work;
    use work.Types.all;

library std;
    use std.textio.all;

entity tb_MAC is
end entity;

architecture rtl_sim of tb_MAC is

    constant CLK_PERIOD: time := 10 ns;
    constant RST_HOLD_DURATION: time := 200 ns;
    signal clk: std_logic;
    signal rst: std_logic;
    signal weight: MAC_weights;
    signal neurons: MAC_inputs;
    signal results: MAC_result;
    
    signal testResult: MAC_result;
    

begin

    MAC_inst: entity work.MAC
        port map (
            clk     => clk,
            rst     => rst,
            weight  => weight,
            neurons => neurons,
            results => results
        );

    
    
    
    stimuli_p: process is
    variable sum: integer:=0;
    begin

        wait until rst = '0';
        wait until clk = '0';
        wait until rising_edge(clk);
        
        for counter in 0 to 1000 loop
            for I in 0 to 24 loop
                neurons(I) <=to_signed(counter + I,16);
                weight(I) <= to_signed(counter + I*2,8);
            end loop;
            
            
            wait until rising_edge(clk);

            sum := 0;
            
            for I in 0 to 24 loop
                sum := sum + to_integer(neurons(I) * weight(I));
            end loop;
            
            testResult <= to_signed(sum,16);
            
            wait until rising_edge(clk);
            
            report ("Loop " & integer'image(counter) & " Finished. Results:");
            
            report integer'image(sum);
            
            report integer'image(to_integer(results));
            
            
            assert to_signed(sum,16) = results report "RESULTS NOT EQUAL!: " & integer'image(counter) severity failure;
                
            
            
        end loop;
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
        wait for RST_HOLD_DURATION;
        wait until rising_edge(clk);
        rst <= '0';
        wait;
    end process;

end architecture;

