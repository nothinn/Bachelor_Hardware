-- -----------------------------------------------------------------------------
--
--  Project    : Hardware Accelerator for Image processing using an FPGA
--             : Bachelor, DTU
--             :
--  Title      :  MAC
--             :
--  Developers :  Anthon Vincent Riber - s154663@student.dtu.dk
--             :  Simon Thye Andersen  - s154227@student.dtu.dk
--             :
--  Purpose    :  Perform the MAC operation of 25 neurons and wheights
--             :
--  Revision   :  1.0   20-06-18     Final version
--             :
-- -----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.Types.all;

entity MAC is
	port(
		clk     : in  std_logic;
		rst     : in  std_logic;
		weight  : in  MAC_weights;
		neurons : in  MAC_inputs;
		results : out MAC_output
	);
end entity MAC;

architecture RTL of MAC is

	----------------------------------------------------------
	--            type and signal declarations              --
	----------------------------------------------------------

	type MAC_DSP_outputs is array (24 downto 0) of signed((fixWeightleft + fixWeightright + fixInputleft + fixInputright + inferredWeightBits + 1 + 1 - 1) downto 0); -- the size of a product is is the size of the sum of the multiplier and the multiplicant 
	type Weight_w_inferedbits_resized is array (24 downto 0) of signed((fixWeightleft + fixWeightright + inferredWeightBits + 1 - 1) downto 0); -- plus 1 is to pad to match bit significance before mult

	signal fullWeights     : Weight_w_inferedbits_resized;
	signal signedNeruons   : signedNeuronsType;
	signal inferredBitsPos : signed(inferredWeightBits - 1 downto 0);
	signal inferredBitsNeg : signed(inferredWeightBits - 1 downto 0);
	signal DSP_outputs     : MAC_DSP_outputs;

begin

	process(all)
	begin
		inferredBitsPos <= (others => '0');
		inferredBitsNeg <= (others => '1');

		----------------------------------------------------------
		--                       Logic                          --
		----------------------------------------------------------		
		
		-- Inserts inffered bits to weights
		infferBits : for I in 0 to 24 loop

			if weight(I)(fixWeightleft + fixWeightright - 1) = '0' then
				fullWeights(I) <= weight(I)(fixWeightleft + fixWeightright - 1 downto fixWeightright) & inferredBitsPos & weight(I)(fixWeightright - 1 downto 0) & "0";
			else
				fullWeights(I) <= weight(I)(fixWeightleft + fixWeightright - 1 downto fixWeightright) & inferredBitsNeg & weight(I)(fixWeightright - 1 downto 0) & "0";
			end if;
			signedNeruons(I) <= "0" & signed(neurons(I)); --input is allways posative or zero
		end loop infferBits;

		-- Multiplication
		if rst = '1' then
			DSP_outputs <= (others => (others => '0'));
		elsif rising_edge(clk) then
			mult : for I in 0 to 24 loop -- the multiplication signals know support the full width of the greatest possiple result

				DSP_outputs(I) <= fullWeights(I) * signedNeruons(I);
			end loop mult;
		end if;
	end process;

	-- Addition
	process(all)
		variable tempAdd : integer;
	begin
		tempAdd := 0;
		add : for I in 0 to 24 loop
			tempAdd := tempAdd + to_integer(dsp_outputs(i));
		end loop add;

		results <= to_signed(tempAdd, DSP_outputs(1)'length - 1 + 5); -- +5: 25 additions can lead to a binary number that needs 5 more bit to be represented (LOG2(5))

	end process;

end architecture RTL;
