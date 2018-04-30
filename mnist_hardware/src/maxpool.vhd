library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.types.all;

entity maxpool is
	port(
		clk        : in  std_logic;
		rst        : in  std_logic;
		convResult : in  MAC_result;
		newMax     : in  std_logic;
		calcMax    : in  std_logic;
		MaxResult  : out MAC_result
	);
end entity maxpool;

architecture RTL of maxpool is

	signal maxReg, maxRegNext, newMaxMux : MAC_result;
    signal calcMax_reg, calcMax_reg1 : std_logic;
    signal newMax_reg, newMax_reg1: std_logic;
begin
	Logic : process(all)
	begin
		case newMax_reg1 is
			when '1' =>
				newMaxMux <= (others => '0');
			when others =>
				newMaxMux <= maxReg;
		end case;

		maxRegNext <= MAXIMUM(newMaxMux, convResult);

		MaxResult <= maxReg;
	end process Logic;

	RegisterTransfer : process(all)
	begin
		if rst = '1' then
			maxReg <= (others => '0');
		elsif rising_edge(clk) then
		  calcMax_reg <= calcMax;
		  calcMax_reg1 <= calcMax_reg;
          newMax_reg <= newMax;
          newMax_reg1 <= newMax_reg;
		
			if calcMax_reg1 = '1' then
				maxReg <= maxRegNext;
			else
				null;
			end if;
		end if;

	end process RegisterTransfer;

end architecture RTL;
