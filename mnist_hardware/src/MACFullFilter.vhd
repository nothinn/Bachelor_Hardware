library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.types.all;

entity MACFullFilter is
	port(
		clk     : in  std_logic;
		rst     : in  std_logic;
		depth   : in  unsigned(1 downto 0); --Should be changed when weightROM can take deeper filters
		Filter  : in  unsigned(4 downto 0);
		input   : in  MAC_inputs;
		hold    : in  std_logic;
		newCalc : in  std_logic;
		result  : out MAC_result
	);
end entity MACFullFilter;

architecture RTL of MACFullFilter is
	type wAddrArray is array (24 downto 0) of unsigned(2 downto 0);

	signal wAddrX : wAddrArray;
	signal wAddrY : wAddrArray;

	signal layerResReg, nextLayerResReg : MAC_result;

	signal inputs                      : MAC_inputs;
	signal weights                     : MAC_weights;
	signal macRes, newCalcMux, holdMux : MAC_result;

	component MAC
		port(
			clk     : in  std_logic;
			rst     : in  std_logic;
			weight  : in  MAC_weights;
			neurons : in  MAC_inputs;
			results : out MAC_result
		);
	end component MAC;

	component weightsRom is
		generic(
			addressX : integer range 0 to 4;
			addressY : integer range 0 to 4
		);
		port(
			clk      : in  std_logic;
			rst      : in  std_logic;
			filter   : in  integer range 0 to 31;
			addressZ : in  integer range 0 to 2;
			output   : out signed(7 downto 0)
		);
	end component;

	component FirstRom is
		port(
			clk      : in  std_logic;
			addressX : in  integer range 0 to 27;
			addressY : in  integer range 0 to 27;
			addressZ : in  integer range 0 to 2;
			output   : out unsigned(15 downto 0)
		);
	end component;

begin
	result <= layerResReg;

	MAC1 : MAC
		port map(
			clk     => clk,
			rst     => rst,
			weight  => weights,
			neurons => inputs,
			results => macRes
		);

	makeROMs : for I in 0 to 24 generate
		weightsRom_inst : weightsRom
			generic map(
				addressX => to_integer(wAddrX(I)),
				addressY => to_integer(wAddrY(I))
			)
			port map(
				clk      => clk,
				rst      => rst,
				filter   => to_integer(filter),
				addressZ => to_integer(depth),
				output   => weights(I)
			);
	end generate makeROMs;

	inputs <= input;

	SetAddr : process(all)
	begin
		for I in 0 to 4 loop
			for J in 0 to 4 loop
				wAddrX(I*5 + J) <= to_unsigned(J, 3);
				wAddrY(I*5 + J) <= to_unsigned(I, 3);
			end loop;
		end loop;
	end process SetAddr;

	makeMuxLogic : process(all)
	begin
		mux1            <= X"0000";
		mux2            <= X"0000";
		nextLayerResReg <= mux1 + mux2;

		case setMux1 is
			when '1' =>
				mux1 <= macRes;
			when others =>
				mux1 <= X"0000";
		end case;

		case setMux2 is
			when '1' =>
				mux2 <= layerResReg;
			when others =>
				mux2 <= X"0000";
		end case;

	end process makeMuxLogic;

	ControlLogic : process(all)
	begin
		case start is
			when '1' =>
				if (currentLayer) = filtersLayers then
					nextCurrentLayer <= currentLayer;
					setMux1          <= '0';
					setMux2          <= '1';
					computed         <= '1';
				else
					nextCurrentLayer <= currentLayer + 1;
					setMux1          <= '1';
					setMux2          <= '1';
					computed         <= '0';
				end if;
			when others =>
				setMux1          <= '0';
				setMux2          <= '0';
				nextCurrentLayer <= "00";
				computed         <= '0';
		end case;

	end process ControlLogic;

	name : process(clk, rst) is
	begin
		if rst = '1' then
			currentLayer <= "00";
			layerResReg  <= X"0000";
		elsif rising_edge(clk) then
			currentLayer <= nextCurrentLayer;
			layerResReg  <= nextLayerResReg;
		end if;
	end process name;

end architecture RTL;
