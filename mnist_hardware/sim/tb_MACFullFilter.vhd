
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.types.all;

entity tb_MACFullFilter is
end entity tb_MACFullFilter;

architecture RTL of tb_MACFullFilter is
	signal clk      : std_logic;
	constant period : time                 := 10 ns;
	signal rst      : std_logic            := '0';
	signal Filter   : unsigned(4 downto 0) := "00000";
	signal input    : MAC_inputs;
	signal result   : MAC_result;
	signal depth    : unsigned(1 downto 0);
	signal hold     : std_logic;
	signal newCalc  : std_logic;

begin
	clock_driver : process
	begin
		clk <= '0';
		wait for period / 2;
		clk <= '1';
		wait for period / 2;
	end process clock_driver;

	instMACFF : entity work.MACFullFilter
		port map(
			clk     => clk,
			rst     => rst,
			depth   => depth,
			Filter  => Filter,
			input   => input,
			hold    => hold,
			newCalc => newCalc,
			result  => result
		);

	
	testProcess : process
	begin
		wait for 20 ns;
		depth   <= "00";
		hold    <= '0';
		newCalc <= '0';
		rst <= '1';
		
		wait for 20ns;
		
		rst <= '0';

		wait until rising_edge(clk);
		for I in 0 to 24 loop
			input(I) <= "0000000000000000"; -- a input of 0 should give 0 as output
		end loop;
		
		wait for 50 ns;
		
		rst <= '1';
		
		wait for 10 ns;
		
		rst <= '0';
		
		wait until rising_edge(clk);
		for I in 0 to 24 loop
			input(I) <= "0000001000000000"; -- 0.5 We should not have hit saturation
		end loop;
		
		
		wait for 50 ns;
		
		rst <= '1';
		
		wait for 10 ns;
		
		rst <= '0';
		
		wait until rising_edge(clk);
		for I in 0 to 24 loop
			input(I) <= "0111111111111111"; -- 32.99xxx We should hit saturation
		end loop;
		
		wait for 50 ns;
		
		rst <= '1';
		
		wait for 10 ns;
		
		rst <= '0';
		
		wait until rising_edge(clk);
		for I in 0 to 24 loop
			input(I) <= "1000000000000000"; -- -32.99xxx We should hit saturation
		end loop;
		
		wait for 50 ns;
	end process testProcess;

end architecture RTL;
