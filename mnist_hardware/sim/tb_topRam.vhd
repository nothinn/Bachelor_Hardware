library ieee;
    use ieee.std_logic_1164.all;
    use ieee.NUMERIC_STD.all;

library work;
    use work.Types.all;

library std;
    use std.textio.all;


entity tb_topRam is
end entity;

architecture rtl_sim of tb_topRam is

    constant depth_size: integer := 64;
    constant size: integer := 5;
    constant ram_size: integer := 28;
    constant NrOfInputs: integer := 8;

    constant CLK_PERIOD: time := 10 ns;
    constant RST_HOLD_DURATION: time := 200 ns;
    signal clk: std_logic;
    signal rst: std_logic;
    signal ena: std_logic;
    signal wea: std_logic;
    signal depth: integer range 0 to depth_size - 1;
    signal addressX: integer range 0 to ram_size - 1;
    signal addressY: integer range 0 to ram_size - 1;
    signal dia: ram_input(NrOfINputs - 1 downto 0);
    signal doa: MAC_inputs;
    signal ready: std_logic;


    
begin



    topRam_inst: entity work.topRam
        generic map (
            depth_size => depth_size,
            size       => size,
            ram_size   => ram_size,
            NrOfInputs => NrOfInputs
        )
        port map (
            clk        => clk,
            rst        => rst,
            ena        => ena,
            wea        => wea,
            depth      => depth,
            addressX   => addressX,
            addressY   => addressY,
            dia        => dia,
            doa        => doa,
            ready      => ready
        );
        
    --mem_in := <<signal .tb_topram.topram_inst.ramGen(0).ram_inst.ram : mem_block>>;

    stimuli_p: process is
    begin
        ena <= '0';
        wea <= '0';
        depth <= 0;
        addressX <= 0;
        addressY <= 0;
        dia <= (others => (others => '0'));
        
        wait until rst = '0';
        
        wait until rising_edge(clk);
        
        wait until rising_edge(clk);

        ena <= '1';
        
        for y in 0 to 27 loop
            for x in 0 to 27 loop
                for d in 0 to 64/8-1 loop
                    addressX <= x;
                    addressY <= y;
                    depth <= d*8;
                
                    wea <= '1';
                    
        
                    for i in 0 to 7 loop
                        dia(i) <= to_unsigned( x * 2**4 + y * 2**8 + (d*8 + i),dia(i)'length);
                    end loop;
        
                    wait until rising_edge(clk);
        
                    dia <= (others => (others => '0'));
        
                    wea <= '0';
            
                    wait until ready = '1';
                    
                end loop;
            end loop;
        end loop;
        
        
        
        
        for y in 0 to 27 loop
            for x in 0 to 27 loop
                for d in 0 to 64/8-1 loop
                    addressX <= x;
                    addressY <= y;
                    depth <= d*8;
                    
                    for i in 0 to 7 loop
                        depth <= d*8+i;
                        
                        wait until rising_edge(clk);
                        
                        wait for 1ps;

                        report "result: " &  integer'image(to_integer(doa(12))) & " " & integer'image( x * 2**4 + y * 2**8 + (depth));
                        assert to_integer(doa(12)) =  x * 2**4 + y * 2**8 + (depth) report integer'image(x)&" " & integer'image(y)&" " & integer'image(i)  severity failure;
                       
                    end loop;
                end loop;
            end loop;
        end loop;
        
        for i in 0 to 8 loop
            wait until rising_edge(clk);
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

    reset_p: process is
    begin
        rst <= '1';
        wait for RST_HOLD_DURATION;
        wait until rising_edge(clk);
        rst <= '0';
        wait;
    end process;

end architecture;

