library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.types.all;
use work.ConfigVHDL.all;

entity topFSM is
	port(
		clk             : in  std_logic;
		rst             : in  std_logic;
		start           : in  std_logic;
		innerDone       : in  std_logic;
		innerStart      : out std_logic;
		innerDepth      : out unsigned(6 downto 0); -- in this implementation the maximal depth of a feature map is 64
		innerXMax       : out unsigned(5 downto 0); -- the max height/witdh of a featuremap is 28
		innerYMax       : out unsigned(5 downto 0);
		innerTotFilters : out unsigned(6 downto 0); -- the maximum amount of filters used in a layer is 64
		innerConvFC     : out std_logic; -- determines whether the current layer is a Conv or FC layer (is used in the inner FSM
		layerCount      : out unsigned(layerCounterWidth - 1 downto 0);
		innerDoneAck    : out std_logic;
		doneLED         : out std_logic
	);
end entity topFSM;

architecture RTL of topFSM is

	type state_type is (idle, runLayer, innerDoneState, allDone);
	signal state, state_next : state_type;

	signal layer, layerNext : unsigned(layerCounterWidth - 1 downto 0);

begin
	innerDepth      <= to_unsigned(layerInputDepth(to_integer(layer)), innerDepth'length);
	innerXMax       <= to_unsigned(layerWidthHeight(to_integer(layer)), innerXMax'length);
	innerYMax       <= to_unsigned(layerWidthHeight(to_integer(layer)), innerYMax'length);
	innerTotFilters <= to_unsigned(layerTotFilters(to_integer(layer)), innerTotFilters'length);
	innerConvFC     <= layerConvFC(to_integer(layer));
	layerCount      <= layer;

	process(all)
	begin
		layerNext    <= layer;
		state_next   <= state;
		innerstart   <= '0';
		innerDoneAck <= '0';
		doneLED      <= '0';
		case state is
			when idle =>
				layerNext <= "00";

				if start = '1' then
					state_next <= runLayer;
				end if;

			when runLayer =>
				innerstart <= '1';

				if innerDone = '1' then
					if layer = nrOfLayers - 1 then
						state_next <= allDone;
					else
						state_next <= innerDoneState;
					end if;
				end if;

			when allDone =>
				doneLED <= '1';
				if (start = '1') then
					state_next <= allDone;
				else
					state_next <= idle;
				end if;

			when innerDoneState =>
				innerDoneAck <= '1';
				layerNext    <= layer + 1;
				state_next   <= runLayer;
		end case;

	end process;

	process(clk, rst)
	begin
		if rst = '1' then
			state <= idle;
			layer <= (others => '0');

		elsif rising_edge(clk) then
			state <= state_next;
			layer <= layerNext;

		end if;
	end process;

end architecture RTL;
