-- -----------------------------------------------------------------------------
--
--  Project    : Hardware Accelerator for Image processing using an FPGA
--             : Bachelor, DTU
--             :
--  Title      :  ConfigVHDL
--             :
--  Developers :  Anthon Vincent Riber - s154663@student.dtu.dk
--             :  Simon Thye Andersen  - s154227@student.dtu.dk
--             :
--  Purpose    :  A package that documents constants describing the Network  
--             :  that the accelerator should run. These are mostly used in the  
--             :  FSMs
--             :
--  Revision   :  1.0   20-06-18     Final version
--             :
-- -----------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all; 
use IEEE.math_real.all;


package ConfigVHDL is

	constant nrOfLayers : integer := 3;
	type LayerConsantArray is array (0 to nrOfLayers - 1) of integer;
	type LayerConsantConvFCArray is array (0 to nrOfLayers - 1) of std_logic;

	constant layerInputDepth  : LayerConsantArray       := (3, 32, 64);
	constant layerWidthHeight : LayerConsantArray       := (28, 14, 7);
	constant layerTotFilters  : LayerConsantArray       := (32, 64, 10);
	constant layerConvFC      : LayerConsantConvFCArray := ('0', '0', '1');
    
    constant ram_0_depth : integer := 64;
    constant ram_1_depth : integer := 32;


end package ConfigVHDL;
 
package body ConfigVHDL is

end package body ConfigVHDL;
