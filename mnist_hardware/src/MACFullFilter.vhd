library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.types.all;

entity MACFullFilter is
	port(
		clk           : in  std_logic;
		rst           : in  std_logic;
		start         : in  std_logic;  			--Starts an opperation
		filtersLayers : in  unsigned(1 downto 0); 	-- Should be changed when weightROM han handle more layers then 3
		Filter        : in  unsigned(4 downto 0);	-- Specify the filter to be used for computation computed
		computed      : out std_logic;  			--Is set high when a result is ready
		result        : out MAC_result
	);
end entity MACFullFilter;

architecture RTL of MACFullFilter is
	type wAddrArray is array (24 downto 0) of unsigned(2 downto 0);

	signal wAddrX : wAddrArray;
	signal wAddrY : wAddrArray;

	signal currentLayer, nextCurrentLayer : unsigned(1 downto 0);
	signal layerResReg, nextLayerResReg   : MAC_result; -- Register that hold the result, which also hold the intermediate result after every layer og the filter

	signal inputs             : MAC_inputs;	
	signal weights            : MAC_weights;
	signal macRes, mux1, mux2 : MAC_result;		-- Signals for the output system, consisting of two multiplexers an adder and a the layerResReg
	signal setMux1, setMux2   : std_logic;		-- Signals controlling the multiplexers above

	component MAC
		port(
			clk     : in  std_logic;
			rst     : in  std_logic;
			weight  : in  MAC_weights;
			neurons : in  MAC_inputs;
			results : out MAC_result
		);
	end component MAC;

	component weightsRom 
		port(
			clk      : in  std_logic;
			rst      : in  std_logic;
			filter   : in  integer range 0 to 31;
			addressX : in  integer range 0 to 4;
			addressY : in  integer range 0 to 4;
			addressZ : in  integer range 0 to 2;
			output   : out signed(7 downto 0)
		);
	end component weightsRom;

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
		weightsROM1 : weightsRom -- 25 copies of the wieght ROM. One for eache of the DSP's in MAC
			port map(
				clk      => clk,
				rst      => rst,
				filter   => to_integer(Filter),
				addressX => to_integer(wAddrX(I)),
				addressY => to_integer(wAddrY(I)),
				addressZ => to_integer(currentLayer),
				output   => weights(I)
			);
	end generate makeROMs;

	SetAddr : process(all)
	begin
		for I in 0 to 4 loop
			for J in 0 to 4 loop
				wAddrX(I*5 + J) <= to_unsigned(J, 3); -- Assigning addresses for the 25 weights.
				wAddrY(I*5 + J) <= to_unsigned(I, 3); 
				inputs(I*5 + J) <= X"0002";			  -- A temperary value that should be changed when the Input RAM has been written
			end loop;
		end loop;
	end process SetAddr;

	makeMuxLogic : process(all) -- Describes how the mux should opperate (might be more readable if it was merged into the "controlLogic" process
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

	ControlLogic : process(all) -- Describes the logic of output system
	begin
		case start is
			when '1' =>
				if (currentLayer) = filtersLayers then -- The result has been computed and whe hold the value in the layersResReg, be setting the mux accordinly
					nextCurrentLayer <= currentLayer;
					setMux1          <= '0';
					setMux2          <= '1';
					computed         <= '1';
				else
					nextCurrentLayer <= currentLayer + 1; -- We are not yet finished and we should keep adding intermediate result to LayerResReg
					setMux1          <= '1';
					setMux2          <= '1';
					computed         <= '0';
				end if;
			when others =>								-- Start is not high and we should set the counter (CurrentLayer register) and LayerResReg to 0
				setMux1          <= '0';
				setMux2          <= '0';
				nextCurrentLayer <= "00";
				computed         <= '0';
		end case;

	end process ControlLogic;

	registerTransfer : process(clk, rst) is
	begin
		if rst = '1' then
			currentLayer <= "00";
			layerResReg  <= X"0000";
		elsif rising_edge(clk) then
			currentLayer <= nextCurrentLayer;
			layerResReg  <= nextLayerResReg;
		end if;
	end process registerTransfer;

end architecture RTL;
