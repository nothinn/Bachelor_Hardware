library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.math_real.all;
use work.types.all;
use work.configVHDL.all;
--NOTER
/*
�ndre Fullfiltermac til at outputtet er 16 bit unsigned. (ReLu).

�ndre saturation og padding til 17 bit, til at holde negative tal.

Add bias f�r relu.
*/
entity MACFullFilter is
	generic(
		filter_offset : unsigned(natural(log2(real(nrOfInputs))) - 1 downto 0) := (others => '1')
	);
	port(
		clk      : in  std_logic;
		rst      : in  std_logic;
		depth    : in  unsigned(6 downto 0);
		depthFC  : in  unsigned(8 downto 0);
		convOrFC : in  std_logic;
		Filter   : in  unsigned(5 downto 0);
		layer    : in  integer range 0 to NrOfLayers - 1;
		input    : in  MAC_inputs;
		hold     : in  std_logic;
		newCalc  : in  std_logic;
		result   : out MAC_result
	);
end entity MACFullFilter;

architecture RTL of MACFullFilter is
	signal layerResReg, nextLayerResReg : signedNeuron;

	signal inputs                              : MAC_inputs;
	signal weights                             : MAC_weights;
	signal macRes                              : MAC_output;
	signal AddSatCheck, newCalcMux, holdMux    : signed((fixWeightleft + fixWeightright + fixInputleft + fixInputright + inferredWeightBits + 1 + 5 + 1 - 1) downto 0);
	signal concatRight                         : signed(fixWeightright + inferredWeightBits + 1 - 1 downto 0);
	signal concatLeft                          : signed((fixWeightleft - 1) + 5 - 1 downto 0);
	signal newcalc_reg, newcalc_reg0, hold_reg : std_logic;
	signal bias                                : signedNeuron;
	signal addBiasOut                          : signedNeuron;
	signal ROMDepth                            : unsigned(8 downto 0);

	signal biasOut : signed(7 downto 0);

	signal filter_reg, filter_reg1, filter_reg2 : unsigned(5 downto 0);

	component MAC
		port(
			clk     : in  std_logic;
			rst     : in  std_logic;
			weight  : in  MAC_weights;
			neurons : in  MAC_inputs;
			results : out MAC_output
		);
	end component MAC;

	component weightsRom is
		generic(
			addressX      : integer range 0 to 4;
			addressY      : integer range 0 to 4;
			filter_offset : unsigned(natural(log2(real(nrOfInputs))) - 1 downto 0) := (others => '0')
		);
		port(
			clk      : in  std_logic;
			rst      : in  std_logic;
			layer    : in  integer range 0 to NrOfLayers - 1;
			filterin : in  unsigned(5 downto natural(log2(real(nrOfInputs))));
			addressZ : in  integer range 0 to 255;
			output   : out signed(7 downto 0)
		);
	end component;

	component biasRom is
		port(
			clk    : in  std_logic;
			rst    : in  std_logic;
			layer  : in  integer range 0 to NrOfLayers - 1;
			filter : in  integer range 0 to 63;
			output : out signed(7 downto 0)
		);
	end component;

begin

	MAC1 : MAC
		port map(
			clk     => clk,
			rst     => rst,
			weight  => weights,
			neurons => inputs,
			results => macRes
		);

	biasRom1 : biasRom
		port map(
			clk    => clk,
			rst    => rst,
			layer  => layer,
			filter => to_integer(filter_reg2),
			output => biasout
		);

	makeROMsy : for I in 0 to 4 generate
		makeROMsx : for J in 0 to 4 generate
			weightsRom_inst : weightsRom
				generic map(
					addressX      => J,
					addressY      => I,
					filter_offset => filter_offset
				)
				port map(
					clk      => clk,
					rst      => rst,
					layer    => layer,
					filterin => filter(5 downto natural(log2(real(nrOfInputs)))),
					addressZ => to_integer(ROMDepth),
					output   => weights(I*5 + J)
				);
		end generate makeROMsx;
	end generate makeROMsy;

	inputs <= input;

	makeMuxLogic : process(all)
	begin
		newCalcMux  <= (others => '0');
		holdMux     <= (others => '0');
		AddSatCheck <= newCalcMux + holdMux;
		concatLeft  <= (others => '0');
		concatRight <= (others => '0');
		--bias					<= (others => '0'); --temperary value
		case hold_reg is
			when '1' =>
				holdMux <= (others => '0');
			when others =>
				if macRes(macRes'length - 1) = '0' then
					holdMux <= '0' & macRes;
				else
					holdMux <= '1' & macRes;
				end if;
		end case;

		case biasOut(biasOut'length - 1) is
			when '1' =>
				bias <= "111111111" & biasOut;
			when others =>
				bias <= "000000000" & biasOut;
		end case;

		case newCalc_reg is
			when '1' =>
				newCalcMux <= (others => '0');
			when others =>
				if layerResReg(layerResReg'length - 1) = '0' then
					concatLeft <= (others => '0');
					newCalcMux <= '0' & concatLeft & layerResReg & concatRight;
				else
					concatLeft <= (others => '1');
					newCalcMux <= '1' & concatLeft & layerResReg & concatRight;
				end if;

		end case;

		case convOrFC is
			when '1' =>
				ROMDepth <= depthFC;

			when others =>
				ROMDepth <= "00" & depth;
		end case;

		--check for saturation
		case AddSatCheck(AddSatCheck'length - 1 downto (AddSatCheck'length - 1) - 1 - 5 - (fixWeightleft - 1)) is -- first -1 to have the extra bit possiple by the addition. secind -1 To look at the sign aswell
			when (AddSatCheck(AddSatCheck'length - 1 downto (AddSatCheck'length - 1) - 1 - 5 - (fixWeightleft - 1))'range => '1') => -- the result has not meet negative saturation
				nextLayerResReg <= AddSatCheck((AddSatCheck'length - 1) - 1 - 5 - (fixWeightleft - 1) downto fixWeightright + inferredWeightBits + 1);
			when (AddSatCheck(AddSatCheck'length - 1 downto (AddSatCheck'length - 1) - 1 - 5 - (fixWeightleft - 1))'range => '0') => -- the result has not meet posative saturation
				nextLayerResReg <= AddSatCheck((AddSatCheck'length - 1) - 1 - 5 - (fixWeightleft - 1) downto fixWeightright + inferredWeightBits + 1);
			when others =>              -- saturation detected
				if AddSatCheck(AddSatCheck'length - 1) = '0' then -- "overflow" saturation detected
					nextLayerResReg <= (nextLayerResReg'length - 1 => '0', others => '1'); -- highest possiple number is passed
				else
					nextLayerResReg <= (nextLayerResReg'length - 1 => '1', others => '0'); -- lowest possiple number is passed
				end if;
		end case;

		-- bias and reLU

		addBiasOut <= layerResReg + bias;
		if addBiasOut(addBiasOut'length - 1) = '1' then
			result <= (others => '0');
		else
			result <= unsigned(addBiasOut(addBiasOut'length - 2 downto 0));
		end if;

	end process makeMuxLogic;

	name : process(clk, rst) is
	begin
		if rst = '1' then
			layerResReg  <= X"0000" & "0";
			newcalc_reg0 <= '0';
			newcalc_reg  <= '0';
			hold_reg     <= '0';
			filter_reg   <= (others => '0');
			filter_reg1  <= (others => '0');
			filter_reg2  <= (others => '0');

		elsif rising_edge(clk) then
			layerResReg  <= nextLayerResReg;
			newcalc_reg0 <= newcalc;
			newcalc_reg  <= newcalc_reg0;
			hold_reg     <= hold;
			filter_reg   <= filter;
			filter_reg1  <= filter_reg;
			filter_reg2  <= filter_reg1;

		end if;
	end process name;

end architecture RTL;
