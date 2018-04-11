library ieee;
    use ieee.std_logic_1164.all;
    use ieee.NUMERIC_STD.all;
    
        use IEEE.math_real.all;

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
    constant RST_HOLD_DURATION: time := 200 ns;
    signal clk: std_logic;
    signal ena: std_logic;
    signal wea: std_logic;
    signal depth: integer range 0 to depth_size - 1;
    signal addressX: integer range 0 to ram_size - 1;
    signal addressY: integer range 0 to ram_size - 1;
    signal dia: ram_input(NrOfINputs - 1 downto 0);
    signal doa: MAC_inputs;




    
    signal mem_in : mem_ram;


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
        

    mem_in <= <<signal .tb_resultram.resultram_inst.memory : mem_ram>>;
    stimuli_p: process is
    begin
        
        ena <= '0';
        wea <= '0';
        depth <= 0;
        addressX <= 0;
        addressY <= 0;
        dia <= (others => (others => '0'));
        
        wait until rising_edge(clk);
        
        ena <= '1';
        
        wait until rising_edge(clk);
        
        wea <= '1';
        
        for d in 0 to 3 loop
            for Y in 0 to 27 loop
                for X in 0 to 27 loop
                    
                    for i in 1 to NrOfInputs loop
                        
                        dia(i - 1) <= to_signed(integer(i + X + d + y),16);
                        
                    end loop;
                    
                    wait until rising_edge(clk);

                    assert mem_in(0)(0)(0) = "0001" report "WORKS" severity note;
                    
                    addressX <= addressX + 1;
                end loop;
                addressy <= addressY + 1;
                addressX <= 0;
            end loop;
            depth <= depth + 8;
            addressY <= 0;
        end loop;
        wait until rising_edge(clk);
        
        wea <= '0';
        wait until rising_edge(clk);
        
        for d in 0 to 3 loop
            for Y in 0 to 27 loop
                for X in 0 to 27 loop
                    
                    for i in 1 to NrOfInputs loop
                        
                        dia(i - 1) <= to_signed(integer(i + X + d + y),16);
                        
                    end loop;
                    
                    wait until rising_edge(clk);
                    addressX <= addressX + 1;
                end loop;
                addressy <= addressY + 1;
                addressX <= 0;
            end loop;
            depth <= depth + 1;
            addressY <= 0;
        end loop;
        
        
        
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

