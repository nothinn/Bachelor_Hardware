library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

package Types is
	type MAC_weights is array(24 downto 0) of signed(7 downto 0);
	type MAC_inputs is array(24 downto 0) of signed(15 downto 0);
	subtype MAC_result is signed(15 downto 0);
	
	constant in_simulation : boolean := false
    --pragma synthesis_off
    or true
    --pragma synthesis_on
    ;
end package Types;

package body Types is
	
end package body Types;
