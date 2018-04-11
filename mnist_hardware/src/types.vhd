library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

package Types is
	type MAC_weights is array(24 downto 0) of signed(7 downto 0);
	type MAC_inputs is array(24 downto 0) of signed(15 downto 0);
	subtype MAC_result is signed(15 downto 0);
    
    type ram_input is array(integer range <>) of MAC_result;
	
	constant in_simulation : boolean := false
    --pragma synthesis_off
    or true
    --pragma synthesis_on
    ;
    
    
    type mem_type is array(integer range 7 downto 0) of MAC_result;
    
    type mem_block is array(144 downto 0) of mem_type;
    
    
    type mem_ram is array(integer range 24 downto 0) of mem_block;
end package Types;

package body Types is
	
end package body Types;
