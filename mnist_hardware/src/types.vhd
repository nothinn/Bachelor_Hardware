library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
use work.ConfigVHDL.all; 

package Types is
    constant MaxSizeOfFilterDepth : Integer := 64;
    constant NumberOfStepsOfRam: Integer := 6*6;

	constant fixWeightleft  : Integer := 1;
	constant fixWeightright : integer := 7;

	constant fixInputleft  : integer := 6;
	constant fixInputright : integer := 10;

	constant inferredWeightBits : integer := 2;
	
	constant NrOfInputs : integer := 8;
	
	constant layerCounterWidth : integer := integer(ceil(log2(real(nrOfLayers))));

	type MAC_weights is array (24 downto 0) of signed((fixWeightleft + fixWeightright - 1) downto 0);
	type MAC_inputs is array (24 downto 0) of unsigned((fixInputleft + fixInputright - 1) downto 0);
	subtype MAC_result is unsigned((fixInputleft + fixInputright - 1) downto 0);

	type ResultArray is array (9 downto 0) of unsigned((fixInputleft + fixInputright - 1) downto 0); 

	subtype MAC_output is signed((fixWeightleft + fixWeightright + fixInputleft + fixInputright + inferredWeightBits + 1 + 5 - 1) downto 0);
	subtype signedNeuron is signed(fixInputleft + fixInputright downto 0);
	type signedNeuronsType is array (24 downto 0) of signedNeuron;

	type ram_input is array (integer range <>) of MAC_result;

	
	constant in_simulation : boolean := false --pragma synthesis_off
	or true--pragma synthesis_on
	;

	
	--type mem_type is array (integer range 7 downto 0) of MAC_result;

	type mem_block is array (integer range <>) of MAC_result;
	
	--type mem_ram is array (integer range 24 downto 0) of mem_block;

end package Types; 

package body Types is

end package body Types;
