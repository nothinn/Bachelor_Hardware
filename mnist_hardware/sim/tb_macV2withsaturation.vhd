library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Types.all;

entity tb_macV2withsaturation is
end entity tb_macV2withsaturation;

architecture RTL of tb_macV2withsaturation is
	constant period : time := 10 ns;

	signal clk     : std_logic;
	signal rst     : std_logic;
	signal weight  : MAC_weights;
	signal neurons : MAC_inputs;
	signal results : MAC_result;
begin

	instMac : entity work.MAC
		port map(
			clk     => clk,
			rst     => rst,
			weight  => weight,
			neurons => neurons,
			results => results
		);

	clock_driver : process
	begin
		clk <= '0';
		wait for period / 2;
		clk <= '1';
		wait for period / 2;
	end process clock_driver;

	setTestValues : process
	begin
		wait for 20 ns;

		wait until rising_edge(clk); -- posative should go through
		for I in 0 to 24 loop
			neurons(I) <= "0000100000000000"; -- 000010.0000000000 = 2.0
			weight(I)  <= "01000000";   --0.1000000 = 0.5
		end loop;
		
		wait for 50 ns;
		
		wait until rising_edge(clk); -- this should activate overflow saturation
		for I in 0 to 24 loop
			neurons(I) <= "0001000000000000"; -- 000100.0000000000 = 4.0
			weight(I)  <= "01000000";   --0.1000000 = 0.5
		end loop;
		

		wait for 50 ns;
		
		wait until rising_edge(clk); -- negative this should go through
		for I in 0 to 24 loop
			neurons(I) <= "0000100000000000"; -- 000010.0000000000 = 2.0
			weight(I)  <= "11000000";   -- 1.100000 = 	-0.5
		end loop;
		

		wait for 50 ns;
		
		wait until rising_edge(clk); -- negative this should activate saturation - underflow
		for I in 0 to 24 loop
			neurons(I) <= "0001000000000000"; -- 000100.0000000000 = 4.0
			weight(I)  <= "11000000";   -- 1.100000 = 	-0.5
		end loop;
		

		wait for 50 ns;
	end process setTestValues;
end architecture RTL;
