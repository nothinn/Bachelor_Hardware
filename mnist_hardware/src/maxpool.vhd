library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.types.all;

entity maxpool is
	port(
		clk        : in  std_logic;
		rst        : in  std_logic;
		convResult : in  ram_input(NrOfINputs - 1 downto 0);
		newMax     : in  std_logic;
		calcMax    : in  std_logic;
		MaxResult  : out ram_input(NrOfInputs - 1 downto 0)
	);
end entity maxpool;

architecture RTL of maxpool is

	signal maxReg, maxRegNext, newMaxMux : ram_input(NrOfInputs - 1 downto 0);

begin
	Logic : process(all)
	begin
		for I in 0 to (NrOfInputs - 1) loop
			case newMax is
				when '1' =>
					newMaxMux(I) <= (others => '0');
				when others =>
					newMaxMux(I) <= maxReg(I);
			end case;

			maxRegNext(I) <= MAXIMUM(newMaxMux(I), convResult(I));

			MaxResult(I) <= maxReg(I);
		end loop;
	end process Logic;

	RegisterTransfer : process(all)
	begin
		for I in 0 to (NrOfInputs - 1) loop
			if rst = '1' then
				maxReg(I) <= (others => '0');
			elsif rising_edge(clk) then
				if calcMax = '1' then
					maxReg(I) <= maxRegNext(I);
				else
					null;
				end if;
			end if;
		end loop;
	end process RegisterTransfer;

end architecture RTL;
