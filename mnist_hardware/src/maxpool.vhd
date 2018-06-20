-- -----------------------------------------------------------------------------
--
--  Project    : Hardware Accelerator for Image processing using an FPGA
--             : Bachelor, DTU
--             :
--  Title      :  maxpool
--             :
--  Developers :  Anthon Vincent Riber - s154663@student.dtu.dk
--             :  Simon Thye Andersen  - s154227@student.dtu.dk
--             :
--  Purpose    :  Performs the maxpool operation
--             :
--  Revision   :  1.0   20-06-18     Final version
--             :
-- -----------------------------------------------------------------------------

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

	----------------------------------------------------------
	--             signal declarations                      --
	----------------------------------------------------------

	signal maxReg, maxRegNext, newMaxMux : MAC_result;
	signal calcMax_reg, calcMax_reg1     : std_logic;
	signal newMax_reg, newMax_reg1       : std_logic;

begin

	----------------------------------------------------------
	--                       Logic                          --
	----------------------------------------------------------		

	-- Logic for the multiplexer and the mac operation
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

	----------------------------------------------------------
	--            Register Transfer                         --
	----------------------------------------------------------

	RegisterTransfer : process(all)
	begin
		if rst = '1' then
			maxReg <= (others => '0');
		elsif rising_edge(clk) then
			calcMax_reg  <= calcMax;
			calcMax_reg1 <= calcMax_reg;
			newMax_reg   <= newMax;
			newMax_reg1  <= newMax_reg;

			if calcMax_reg1 = '1' then  -- enable for the register
				maxReg <= maxRegNext;
			else
				null;
			end if;
		end if;

	end process RegisterTransfer;

end architecture RTL;
