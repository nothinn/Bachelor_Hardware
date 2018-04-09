library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

package Types is
	constant fixWeightleft  : Integer := 1;
	constant fixWeightright : integer := 7;

	constant fixInputleft  : integer := 6;
	constant fixInputright : integer := 10;
	
	constant inferredWeightBits : integer := 2;
	
	type MAC_weights is array (24 downto 0) of signed((fixWeightleft + fixWeightright - 1) downto 0);
	type MAC_inputs is array (24 downto 0) of signed((fixInputleft + fixInputright - 1) downto 0);
	subtype MAC_result is signed((fixInputleft + fixInputright - 1) downto 0);
	
	subtype MAC_output is signed((fixWeightleft + fixWeightright + fixInputleft + fixInputright + inferredWeightBits + 5 - 1) downto 0);


	type ram_input is array (integer range <>) of std_logic_vector(15 downto 0);

	constant in_simulation : boolean := false --pragma synthesis_off
	or true--pragma synthesis_on
	;
end package Types;

package body Types is

end package body Types;
