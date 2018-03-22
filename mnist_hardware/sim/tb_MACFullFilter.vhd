
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.types.all;

entity tb_MACFullFilter is
end entity tb_MACFullFilter;

architecture RTL of tb_MACFullFilter is
	signal clk           : std_logic;
	constant period      : time := 10 ns;
	signal rst           : std_logic := '0';
	signal start         : std_logic := '0';
	signal filtersLayers : unsigned(1 downto 0) := "10";
	signal Filter        : unsigned(4 downto 0) := "00000";
    signal input         : MAC_inputs;
	signal computed      : std_logic;
	signal result        : MAC_result;
    
    signal addressX      : integer range 0 to 27;
    signal addressY      : integer range 0 to 27;
    signal addressZ      : integer range 0 to 2;

begin
	clock_driver : process
	begin
		clk <= '0';
		wait for period / 2;
		clk <= '1';
		wait for period / 2;
	end process clock_driver;
    
    gen_rom: for i in 0 to 24 generate
        FirstRom_inst: entity work.FirstRom
            port map (
                clk      => clk,
                addressX => addressX,
                addressY => addressY,
                addressZ => addressZ,
                output   => input(I)
            );
    end generate;



	inst : entity work.MACFullFilter
		port map(
			clk           => clk,
			rst           => rst,
			start         => start,
			filtersLayers => filtersLayers,
			Filter        => Filter,
            input         => input,
			computed      => computed,
			result        => result
		);

	stim : process
	begin
		start         <= '1';
		filterslayers <= "10";
		Filter        <= "00000";
		rst           <= '1';
        
        addressX <= 0;
        addressY <= 0;
        addressZ <= 0;
		
		wait for 20 ns;

		wait until rising_edge(clk);
		
		rst <= '0';
		
		wait for 100 ns;
		
		wait until rising_edge(clk);
		start <= '0';
		wait;
		
	end process stim;
end architecture RTL;
