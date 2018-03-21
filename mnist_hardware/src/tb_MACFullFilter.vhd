
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
	signal computed      : std_logic;
	signal result        : MAC_result;

begin
	clock_driver : process
	begin
		clk <= '0';
		wait for period / 2;
		clk <= '1';
		wait for period / 2;
	end process clock_driver;

	inst : entity work.MACFullFilter
		port map(
			clk           => clk,
			rst           => rst,
			start         => start,
			filtersLayers => filtersLayers,
			Filter        => Filter,
			computed      => computed,
			result        => result
		);

	stim : process
	begin
		start         <= '1';
		filterslayers <= "10";
		Filter        <= "00000";
		rst           <= '1';
		
		wait for 20 ns;

		wait until rising_edge(clk);
		
		rst <= '0';
		
		wait for 100 ns;
		
		wait until rising_edge(clk);
		start <= '0';
		wait;
		
	end process stim;
end architecture RTL;
