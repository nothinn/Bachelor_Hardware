library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
--use work.Types.all;

package ConfigVHDL is

	constant nrOfLayers : integer := 3;
	type LayerConsantArray is array (0 to nrOfLayers - 1) of integer;
	type LayerConsantConvFCArray is array (0 to nrOfLayers - 1) of std_logic;

	constant layerInputDepth  : LayerConsantArray       := (3, 32, 64);
	constant layerWidthHeight : LayerConsantArray       := (28, 14, 7);
	constant layerTotFilters  : LayerConsantArray       := (32, 64, 0);
	constant layerConvFC      : LayerConsantConvFCArray := ('0', '0', '1');

end package ConfigVHDL;

package body ConfigVHDL is

end package body ConfigVHDL;
