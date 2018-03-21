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


	type MAC_DSP_outputs is array (24 downto 0) of signed(15 downto 0);

    

    --signal weightI : MAC_weights;
    --signal neuronsI : mac_inputs;


	signal DSP_outputs : MAC_DSP_outputs;

	signal result : signed(15 downto 0);


begin


	process(all)
	begin
		if rising_edge(clk) then
			mult : for I in 0 to 24 loop
                

		    DSP_outputs(I) <= --below pramga is added to let simulation work the same as synthesis. 
                --pragma synthesis_off
                RESIZE(
                --pragma synthesis_on
                    weight(I) * neurons(i)
                    
                --pragma synthesis_off
                    ,16)
                --pragma synthesis_on
                ;

                
                
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
		result  <= to_signed(tempAdd, 16);
	end process;
	results <= result;

end architecture RTL;
