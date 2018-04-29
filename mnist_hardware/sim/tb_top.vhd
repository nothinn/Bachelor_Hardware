library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

library work;
use work.Types.all;

library std;
use std.textio.all;

entity tb_top is
end entity;

architecture rtl of tb_top is

	component FirstRom is
		port(
			clk      : in  std_logic;
			addressX : in  integer range 0 to 27;
			addressY : in  integer range 0 to 27;
			addressZ : in  integer range 0 to 2;
			output   : out unsigned(15 downto 0)
		);
	end component;

	component MACFullFilter is
		port(
			clk     : in  std_logic;
			rst     : in  std_logic;
			depth   : in  unsigned(1 downto 0);
			Filter  : in  unsigned(4 downto 0);
			input   : in  MAC_inputs;
			hold    : in  std_logic;
			newCalc : in  std_logic;
			result  : out MAC_result
		);
	end component;

	component maxpool
		port(
			clk        : in  std_logic;
			rst        : in  std_logic;
			convResult : in  MAC_result;
			newMax     : in  std_logic;
			calcMax    : in  std_logic;
			MaxResult  : out MAC_result
		);
	end component maxpool;

	component resultRam is
		generic(
			depth_size : integer := 32;
			size       : integer := 5;
			ram_size   : integer := 28;
			NrOfInputs : integer := 8
		);
		port(
			clk      : in  std_logic;
			ena      : in  std_logic;
			wea      : in  std_logic;
			depth    : in  integer range 0 to depth_size - 1;
			addressX : in  integer range 0 to ram_size - 1;
			addressY : in  integer range 0 to ram_size - 1;
			dia      : in  ram_input(NrOfINputs - 1 downto 0);
			doa      : out MAC_inputs
		);
	end component;

	component fsm is
		port(
			clk           : in  std_logic;
			rst           : in  std_logic;
			start         : in  std_logic;
			hold          : out std_logic;
			new_calc      : out std_logic;
			writeEnable   : out std_logic;
			x             : out integer;
			y             : out integer;
			depth         : out integer;
			filter        : out integer;
			done          : out std_logic;
			calcMax       : out std_logic;
			newMax        : out std_logic;
			maxCounterOut : out unsigned(1 downto 0)
		);
	end component;

	constant CLK_PERIOD : time      := 10 ns;
	signal clk          : std_logic;
	signal rst          : std_logic := '0';

	signal input_mac : MAC_inputs;
	--signal input_weight_mac: MAC_weights;
	--signal output_mac: ram_input(7 downto 0);

	signal filter : unsigned(4 downto 0);

	signal addressX, addressX_reg, addressX_reg2, addressXOut : integer;
	signal addressY, addressY_reg, addressY_reg2, addressYOut : integer;
	signal addressZ                              : integer range 0 to 31;

	signal hold, newCalc, done, calcMax, newMax : std_logic;
	signal maxCounterOut                        : unsigned(1 downto 0);
	signal maxCounterOutx, maxCounterOuty       : unsigned(0 downto 0);

	signal start : std_logic := '0';

	signal depth : unsigned(1 downto 0);

	signal MAC_ARRAY, MAX_ARRAY : ram_input(7 downto 0);

	signal en_ram : std_logic := '0';
	signal we_ram : std_logic := '0';

	signal writeEnable, writeEnableReg : std_logic;

	signal pre_filter, filter_reg, filter_reg2 : integer;

	type filter_array is array (7 downto 0) of unsigned(4 downto 0);

	signal filter_input : filter_array;

begin
	
	process(clk)
	begin
		if rst = '1' then
			writeEnableReg <= '0';
			we_ram         <= '0';
		elsif rising_edge(clk) then
			writeEnableReg <= writeEnable;
			we_ram         <= writeEnableReg;

			addressX_reg  <= addressX;
			addressX_reg2 <= addressX_reg;

			addressY_reg  <= addressY;
			addressY_reg2 <= addressY_reg;

			filter_reg  <= pre_filter;
			filter_Reg2 <= filter_reg;

			maxCounterOutx <= maxCounterOut(0 downto 0);
			maxCounterOuty <= maxCounterOut(1 downto 1);
		end if;
	end process;

	gen_romX : for x in -2 to 2 generate
		gen_romY : for y in -2 to 2 generate
			FirstRom_inst : FirstRom
				port map(
					clk      => clk,
					addressX => (addressX + x),
					addressY => (addressY + y),
					addressZ => addressZ,
					output   => input_mac((x + 2) + (y + 2)*5)
				);
		end generate;
	end generate;

	depth <= to_unsigned(addressZ, depth'length);

	process(all)
	begin
		for i in 0 to 7 loop
			filter_input(i) <= filter + to_unsigned(I, 5);
		end loop;
	end process;

	GEN_MACFull : for I in 0 to 7 generate
		MACFullFilter_inst : MACFullFilter
			port map(
				clk     => clk,
				rst     => rst,
				depth   => depth,
				Filter  => filter_input(i),
				input   => input_mac,
				hold    => hold,
				newCalc => newCalc,
				result  => MAC_array(i)
			);
	end generate;
	
	addressXOut <= addressX_reg2/2;
	addressYOut <= addressY_reg2/2;
	
	resultRam_inst : resultRam
		generic map(
			depth_size => 32,
			size       => 5,
			ram_size   => 28,
			NrOfInputs => 8
		)
		port map(
			clk      => clk,
			ena      => en_ram,
			wea      => we_ram,
			depth    => filter_reg2,
			addressX => addressXOut,
			addressY => addressYOut,
			dia      => max_array,
			doa      => open
		);

	fsm_inst : fsm
		port map(
			clk           => clk,
			rst           => rst,
			start         => start,
			hold          => hold,
			new_calc      => newCalc,
			writeEnable   => writeEnable,
			x             => addressX,
			y             => addressY,
			depth         => addressZ,
			filter        => pre_filter,
			done          => done,
			calcMax       => calcMax,
			newMax        => newMax,
			maxCounterOut => maxCounterOut
		);

	GEN_MAXPOOL : for I in 0 to (NrOfInputs - 1) generate
		inst_maxpool : maxpool
			port map(
				clk        => clk,
				rst        => rst,
				convResult => MAC_array(I),
				newMax     => newMax,
				calcMax    => calcMax,
				MaxResult  => MAX_array(I)
			);

	end generate GEN_MAXPOOL;

	filter <= to_unsigned(pre_filter, 5);

	stimuli_p : process is
	begin
		wait until rising_edge(clk) and rst = '0';

		start <= '1';

		wait until rising_edge(clk) and done = '1';

		report "DONE" severity failure;

	end process;

	clock_p : process is
	begin
		clk <= '0';
		wait for CLK_PERIOD / 2;
		clk <= '1';
		wait for CLK_PERIOD / 2;
	end process;

	reset_p : process is
	begin
		rst <= '1';
		wait for 4 * CLK_PERIOD;
		rst <= '0';
		wait;
	end process;
end architecture;
