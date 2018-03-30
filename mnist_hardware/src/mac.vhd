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
		results : out MAC_result
	);
end entity MAC;

architecture RTL of MAC is

	type MAC_DSP_outputs is array (24 downto 0) of signed((fixWeightleft + fixWeightright + fixInputleft + fixInputright - 1) downto 0); -- the size of a product is is the size of the sum of the multiplier and the multiplicant 

	--signal weightI : MAC_weights;
	--signal neuronsI : mac_inputs;

	signal DSP_outputs : MAC_DSP_outputs;

	signal result : signed((fixWeightleft + fixWeightright + fixInputleft + fixInputright + 5 - 1) downto 0);

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
		if rising_edge(clk) then
			mult : for I in 0 to 24 loop -- the multiplication signals know support the full width of the greatest possiple result

				DSP_outputs(I) <= weight(I) * neurons(i);
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

		result <= to_signed(tempAdd, DSP_outputs(1)'length + 5); -- +5: 25 additions can lead to a binary number that needs 5 more bit to be represented (LOG2(5))
		
		case result(result'length - 1 downto result'length - 5 - fixWeightleft - 1) is -- -1 To look at the sign aswell
		when (others => '1') => -- the result has not meet negative saturation
			results <= result(result'length - 5 - fixWeightleft - 1 downto fixWeightright);
		when (others => '0') => -- the result has not meet posative saturation
			results <= result(result'length - 5 - fixWeightleft - 1 downto fixWeightright);
		when others => -- saturation detected
			if result(result'length-1) = '0' then -- "overflow" saturation detected
				results <= '0' & "111111111111111" ; -- highest possiple number is passed
			else
				results <= '1' & "000000000000000"; -- lowest possiple number is passed
			end if;
		end case;
			
			
	end process;

end architecture RTL;
