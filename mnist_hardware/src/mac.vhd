library ieee;
use work.Types.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

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

	type MAC_DSP_outputs is array (24 downto 0) of signed((fixWeightleft + fixWeightright + fixInputleft + fixInputright + inferredWeightBits - 1) downto 0); -- the size of a product is is the size of the sum of the multiplier and the multiplicant 
	type Weight_w_inferedbits_resized is array (24 downto 0) of signed((fixWeightleft + fixWeightright +  inferredWeightBits - 1) downto 0);
	--signal weightI : MAC_weights;
	--signal neuronsI : mac_inputs;

	signal fullWeights     : Weight_w_inferedbits_resized;
	signal inferredBitsPos : signed(inferredWeightBits - 1 downto 0);
	signal inferredBitsNeg : signed(inferredWeightBits - 1 downto 0);
	signal DSP_outputs     : MAC_DSP_outputs;
	

	--signal result : signed((fixWeightleft + fixWeightright + fixInputleft + fixInputright + 5 - 1) downto 0);

begin

	--	process(all)
	--	begin
	--		if rising_edge(clk) then
	--			mult : for I in 0 to 24 loop
	--                
	--
	--		    DSP_outputs(I) <= --below pramga is added to let simulation work the same as synthesis. 
	--                --pragma synthesis_off
	--                RESIZE(
	--                --pragma synthesis_on
	--                    weight(I) * neurons(i)
	--                    
	--                --pragma synthesis_off
	--                    ,16)
	--                --pragma synthesis_on
	--                ;
	--
	--                
	--                
	--			end loop mult;
	--		end if;
	--	end process;

	process(all)
	begin
		inferredBitsPos <= (others => '0');
		inferredBitsNeg <= (others => '1');
		

		infferBits : for I in 0 to 24 loop

			if weight(I)(fixWeightleft + fixWeightright - 1) = '0' then
				fullWeights(I) <= weight(I)(fixWeightleft + fixWeightright - 1 downto fixWeightright) & inferredBitsPos & weight(I)(fixWeightright - 1 downto 0);
			else
				fullWeights(I) <= weight(I)(fixWeightleft + fixWeightright - 1 downto fixWeightright) & inferredBitsNeg & weight(I)(fixWeightright - 1 downto 0);
			end if;
		end loop infferBits;

		if rising_edge(clk) then
			mult : for I in 0 to 24 loop -- the multiplication signals know support the full width of the greatest possiple result

				DSP_outputs(I) <= fullWeights(I) * neurons(i);
			end loop mult;
		end if;
	end process;

	process(all)
		variable tempAdd : integer;
	begin
		tempAdd := 0;
		add : for I in 0 to 24 loop
			tempAdd := tempAdd + to_integer(dsp_outputs(i));
		end loop add;

		results <= to_signed(tempAdd, DSP_outputs(1)'length + 5); -- +5: 25 additions can lead to a binary number that needs 5 more bit to be represented (LOG2(5))

	end process;

end architecture RTL;
