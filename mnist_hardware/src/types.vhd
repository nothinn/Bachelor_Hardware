-- -----------------------------------------------------------------------------
--
--  Project    : Hardware Accelerator for Image processing using an FPGA
--             : Bachelor, DTU
--             :
--  Title      :  Types
--             :
--  Developers :  Anthon Vincent Riber - s154663@student.dtu.dk
--             :  Simon Thye Andersen  - s154227@student.dtu.dk
--             :
--  Purpose    :  A package that documents constants and types that is used   
--             :  through out the system. This is also where the number of
--             :  MACFullFilters used is configured
--             :
--  Revision   :  1.0   20-06-18     Final version
--             :
-- -----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

use work.ConfigVHDL.all;

package Types is

	constant CLOCK_FREQ : Integer := 62_000_000; -- Used for UART configuration
	constant NrOfInputs : integer := 8; -- configured number of MACFullFilter

	constant MaxSizeOfFilterDepth : Integer := 64;
	constant NumberOfStepsOfRam   : Integer := 6*6;

	constant fixWeightleft  : Integer := 1;
	constant fixWeightright : integer := 7;

	constant fixInputleft  : integer := 6;
	constant fixInputright : integer := 10;

	constant inferredWeightBits : integer := 2;

	constant layerCounterWidth : integer := integer(ceil(log2(real(nrOfLayers))));

	type MAC_weights is array (24 downto 0) of signed((fixWeightleft + fixWeightright - 1) downto 0);
	type MAC_inputs is array (24 downto 0) of unsigned((fixInputleft + fixInputright - 1) downto 0);
	subtype MAC_result is unsigned((fixInputleft + fixInputright - 1) downto 0);

	type ResultArray is array (9 downto 0) of unsigned((fixInputleft + fixInputright - 1) downto 0);

	subtype MAC_output is signed((fixWeightleft + fixWeightright + fixInputleft + fixInputright + inferredWeightBits + 1 + 5 - 1) downto 0);
	subtype signedNeuron is signed(fixInputleft + fixInputright downto 0);
	type signedNeuronsType is array (24 downto 0) of signedNeuron;

	type ram_input is array (integer range <>) of MAC_result;

	type mem_block is array (integer range <>) of MAC_result;

end package Types;

package body Types is

end package body Types;
