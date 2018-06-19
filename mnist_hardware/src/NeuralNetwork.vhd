library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.MATH_REAL.all;

library work;
use work.Types.all;
use work.ConfigVHDL.all;

entity NeuralNetwork is
	port(
		clk_in  : in  std_logic;
		start   : in  std_logic;
		rst     : in  std_logic;
		number  : in  std_logic_vector(3 downto 0);
		segment : out std_logic_vector(6 downto 0);
		an      : out std_logic_vector(3 downto 0);
		tx      : out std_logic;
		rx      : in  std_logic;
		doneLED : out std_logic
	);
end entity;

architecture rtl of NeuralNetwork is

	--attribute DONT_TOUCH : string;
	--attribute DONT_TOUCH of  topRam0_inst : label is "TRUE";
	--attribute DONT_TOUCH of  topRam1_inst : label is "TRUE";
	--attribute DONT_TOUCH of  muxProcess : label is "TRUE";
	--attribute DONT_TOUCH of  fsm_inst : label is "TRUE";
	--attribute DONT_TOUCH of  topfsm_inst : label is "TRUE";
	--attribute DONT_TOUCH of  GEN_MACFull : label is "TRUE";
	--attribute DONT_TOUCH of   ResultLogic: label is "TRUE";

	/*component FirstRom is
        port (
            clk      : in std_logic;
            addressX : in integer range 0 to 27;
            addressY : in integer range 0 to 27;
            addressZ : in integer range 0 to 2;
            output   : out unsigned(15 downto 0)
        );
    end component;
    */
	component MACFullFilter is
		generic(
			filter_offset : unsigned(natural(log2(real(nrOfInputs))) - 1 downto 0) := (others => '0')
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
	end component;

	component maxpool is
		port(
			clk        : in  std_logic;
			rst        : in  std_logic;
			convResult : in  MAC_result;
			newMax     : in  std_logic;
			calcMax    : in  std_logic;
			MaxResult  : out MAC_result
		);
	end component;

	component fsm is
		port(
			clk           : in  std_logic;
			rst           : in  std_logic;
			start         : in  std_logic;
			inputDepth    : in  unsigned(6 downto 0);
			inputXMax     : in  unsigned(5 downto 0);
			inputYMax     : in  unsigned(5 downto 0);
			totalFilters  : in  unsigned(6 downto 0);
			doneAck       : in  std_logic;
			convOrFC      : in  std_logic;
			hold          : out std_logic;
			new_calc      : out std_logic;
			writeEnable   : out std_logic;
			x             : out integer;
			y             : out integer;
			depth         : out integer;
			fcWDepth      : out integer;
			filter        : out integer;
			done          : out std_logic;
			calcMax       : out std_logic;
			newMax        : out std_logic;
			maxCounterOut : out unsigned(1 downto 0)
		);
	end component;

	component topFSM is
		port(
			clk             : in  std_logic;
			rst             : in  std_logic;
			start           : in  std_logic;
			innerDone       : in  std_logic;
			innerStart      : out std_logic;
			innerDepth      : out unsigned(6 downto 0);
			innerXMax       : out unsigned(5 downto 0);
			innerYMax       : out unsigned(5 downto 0);
			innerTotFilters : out unsigned(6 downto 0);
			innerConvFC     : out std_logic;
			layerCount      : out unsigned(layerCounterWidth - 1 downto 0);
			innerDoneAck    : out std_logic;
			doneLED         : out std_logic
		);
	end component;

	component topRam is
		generic(
			depth_size : integer := 64;
			size       : integer := 5;
			ram_size   : integer := 28;
			NrOfInputs : integer := 8
		);
		port(
			clk      : in  std_logic;
			rst      : in  std_logic;
			ena      : in  std_logic;
			wea      : in  std_logic;
			depth    : in  integer range 0 to depth_size - 1;
			addressX : in  integer range 0 to ram_size - 1;
			addressY : in  integer range 0 to ram_size - 1;
			dia      : in  ram_input(NrOfINputs - 1 downto 0);
			doa      : out MAC_inputs;
			ready    : out std_logic
		);
	end component;

	component topFirstRam
		generic(
			depth_size : integer;
			size       : integer;
			ram_size   : integer;
			NrOfInputs : integer
		);
		port(
			clk       : in  std_logic;
			rst       : in  std_logic;
			ena       : in  std_logic;
			wea       : in  std_logic;
			deptha    : in  integer range 0 to depth_size - 1;
			addressXa : in  integer range 0 to ram_size - 1;
			addressYa : in  integer range 0 to ram_size - 1;
			depthb    : in  integer range 0 to depth_size - 1;
			addressXb : in  integer range 0 to ram_size - 1;
			addressYb : in  integer range 0 to ram_size - 1;
			dia       : in  ram_input(NrOfINputs - 1 downto 0);
			doa       : out MAC_inputs;
			ready     : out std_logic
		);
	end component topFirstRam;

	component hex_to_7segment is
		port(clk     : in  std_logic;
		     reset   : in  std_logic;
		     value   : in  std_logic_vector(15 downto 0);
		     segment : out std_logic_vector(6 downto 0);
		     an      : out std_logic_vector(3 downto 0)
		    );
	end component;

	component clk_wiz_0 is
		port(
			clk_out1 : out std_logic;
			clk_in1  : in  std_logic);
	end component;

	component uart
		generic(
			baud            : positive;
			clock_frequency : positive
		);
		port(
			clock               : in  std_logic;
			reset               : in  std_logic;
			data_stream_in      : in  std_logic_vector(7 downto 0);
			data_stream_in_stb  : in  std_logic;
			data_stream_in_ack  : out std_logic;
			data_stream_out     : out std_logic_vector(7 downto 0);
			data_stream_out_stb : out std_logic;
			tx                  : out std_logic;
			rx                  : in  std_logic
		);
	end component uart;

	component UartController
		port(
			clk                  : in  std_logic;
			rst                  : in  std_logic;
			uartDataStreamTx     : out std_logic_vector(7 downto 0);
			uartDataStreamTx_stb : out std_logic;
			uartDataStreamTx_ack : in  std_logic;
			uartDataStreamRx     : in  std_logic_vector(7 downto 0);
			uartDataStreamRx_stb : in  std_logic;
			uartToMem_en         : out std_logic;
			uartToMem_we         : out std_logic;
			uartToMem_AddrX      : out integer range 0 to layerWidthHeight(0) - 1;
			uartToMem_AddrY      : out integer range 0 to layerWidthHeight(0) - 1;
			uartToMem_AddrZ      : out integer range 0 to layerInputDepth(0) - 1;
			uartToMem_DataWrite  : out ram_input(0 downto 0)
		);
	end component UartController;

	component pipeRamInput is
		generic(
			nrOfDelays : integer := 1
		);
		port(
			clk               : in  std_logic;
			rst               : in  std_logic;
			we_ram            : in  std_logic;
			addressXout       : in  integer;
			addressYout       : in  integer;
			filter            : in  integer;
			ram_data          : in  ram_input(NrOfINputs - 1 downto 0);
			we_ram_piped      : out std_logic;
			addressXout_piped : out integer;
			addressYout_piped : out integer;
			filter_piped      : out integer;
			ram_data_piped    : out ram_input(NrOfINputs - 1 downto 0)
		);
	end component;

	component pipeMacfullOut is
		generic(
			nrOfDelays : integer := 0
		);
		port(
			clk               : in  std_logic;
			rst               : in  std_logic;
			we_ram            : in  std_logic;
			addressXout       : in  integer;
			addressYout       : in  integer;
			filter            : in  integer;
			mac_array         : in  ram_input(NrOfInputs - 1 downto 0);
			we_ram_piped      : out std_logic;
			addressXout_piped : out integer;
			addressYout_piped : out integer;
			filter_piped      : out integer;
			mac_array_piped   : out ram_input(NrOfInputs - 1 downto 0)
		);
	end component;

	--Pipeline signals for mac_output
	signal we_ram_pipedfm      : std_logic;
	signal addressXout_pipedfm : integer;
	signal addressYout_pipedfm : integer;
	signal filter_pipedfm      : integer;
	signal mac_array_piped     : ram_input(NrOfINputs - 1 downto 0);

	--Pipeline signals for ram input
	signal we_ram_piped      : std_logic;
	signal addressXout_piped : integer;
	signal addressYout_piped : integer;
	signal filter_piped      : integer;
	signal ram_data_piped    : ram_input(NrOfINputs - 1 downto 0);

	signal input_mac : MAC_inputs;

	signal filter : unsigned(5 downto 0);

	signal addressX, addressX_reg, addressXOut, addressXOut_reg, addressXOut_reg1, addressXOut_reg2 : integer := 0;
	signal addressY, addressY_reg, addressYOut, addressYOut_reg, addressYOut_reg1, addressYOut_reg2 : integer := 0;
	signal addressZ, addressZ_reg                                                                   : integer; -- range 0 to 31;

	signal hold, newCalc, done, calcMax, newMax : std_logic;
	signal maxCounterOut                        : unsigned(1 downto 0);

	signal depthWFCInt : integer;

	signal depth    : unsigned(6 downto 0);
	signal depthWFC : unsigned(8 downto 0);

	signal MAC_ARRAY, MAX_ARRAY : ram_input(NrOfInputs - 1 downto 0);

	signal we_ram : std_logic := '0';

	signal writeEnable, writeEnableReg : std_logic;

	signal pre_filter, filter_reg, filter_reg1 : integer;

	type filter_array is array (NrOfInputs - 1 downto 0) of unsigned(5 downto 0);

	signal filter_input    : filter_array;
	signal innerStart      : std_logic;
	signal innerDepth      : unsigned(6 downto 0);
	signal innerXMax       : unsigned(5 downto 0);
	signal innerYMax       : unsigned(5 downto 0);
	signal innerTotFilters : unsigned(6 downto 0);
	signal innerConvFC     : std_logic;
	signal layerCount      : unsigned(layerCounterWidth - 1 downto 0);
	signal innerDoneAck    : std_logic;

	signal depth_reg                       : unsigned(6 downto 0);
	signal depthWFC_reg                    : unsigned(8 downto 0);
	signal innerConvFC_reg                 : std_logic;
	signal filter_input_reg                : filter_array;
	signal layercount_reg, layercount_reg2 : unsigned(layerCounterWidth - 1 downto 0);
	signal hold_reg                        : std_logic;
	signal newCalc_reg                     : std_logic;

	signal newMax_reg  : std_logic;
	signal calcMax_reg : std_logic;

	--Signals for ram
	signal ram_ena : std_logic_vector(1 downto 0);
	signal ram_wea : std_logic_vector(1 downto 0);

	signal ram_depthStart : integer range 0 to layerInputDepth(0) - 1;
	signal ram_depth0     : integer range 0 to ram_0_depth - 1;
	signal ram_depth1     : integer range 0 to ram_1_depth - 1;

	signal ram_addressXStart : integer range 0 to layerWidthHeight(0) - 1;
	signal ram_addressYStart : integer range 0 to layerWidthHeight(0) - 1;

	signal ram_addressX0 : integer range 0 to layerWidthHeight(2) - 1;
	signal ram_addressY0 : integer range 0 to layerWidthHeight(2) - 1;

	signal ram_addressX1 : integer range 0 to layerWidthHeight(1) - 1;
	signal ram_addressY1 : integer range 0 to layerWidthHeight(1) - 1;

	signal ram_data_in : ram_input(NrOfINputs - 1 downto 0);

	signal ram_data_out0      : MAC_inputs;
	signal ram_data_out1      : MAC_inputs;
	signal ram_data_out_first : MAC_inputs;

	-- Signals for uart controller
	signal uartDataStreamTx     : std_logic_vector(7 downto 0);
	signal uartDataStreamTx_stb : std_logic;
	signal uartDataStreamTx_ack : std_logic;
	signal uartDataStreamRx     : std_logic_vector(7 downto 0);
	signal uartDataStreamRx_stb : std_logic;
	--signal uartToMem_en : std_logic;
	signal uartToMem_we         : std_logic;
	signal uartToMem_AddrX      : integer range 0 to layerWidthHeight(0) - 1;
	signal uartToMem_AddrY      : integer range 0 to layerWidthHeight(0) - 1;
	signal uartToMem_AddrZ      : integer range 0 to layerInputDepth(0) - 1;
	signal uartToMem_DataWrite  : ram_input(0 downto 0);

	signal we_ram_reg                : std_logic;
	signal resultReg, resultReg_next : ResultArray;

	Signal clk : std_logic;

	signal filter_reg2 : integer;

	signal value : std_logic_vector(15 downto 0);
	--signal segment : std_logic_vector(6 downto 0);
	--signal an : std_logic_vector(3 downto 0);

begin

	clock_inst : clk_wiz_0
		port map(
			clk_out1 => clk,
			clk_in1  => clk_in
		);

	process(all) is
	begin
		case number is
			when "0000" =>
				value <= std_logic_vector(resultReg(0));
			when "0001" =>
				value <= std_logic_vector(resultReg(1));
			when "0010" =>
				value <= std_logic_vector(resultReg(2));
			when "0011" =>
				value <= std_logic_vector(resultReg(3));
			when "0100" =>
				value <= std_logic_vector(resultReg(4));
			when "0101" =>
				value <= std_logic_vector(resultReg(5));
			when "0110" =>
				value <= std_logic_vector(resultReg(6));
			when "0111" =>
				value <= std_logic_vector(resultReg(7));
			when "1000" =>
				value <= std_logic_vector(resultReg(8));
			when "1001" =>
				value <= std_logic_vector(resultReg(9));
			when others =>
				value <= "0001001000110100";
		end case;
	end process;

	----------------------------------------------------------------------------
	--                           Istantiating display                         --
	----------------------------------------------------------------------------

	display_inst : hex_to_7segment
		port map(
			clk     => clk,
			reset   => rst,
			value   => value,
			segment => segment,
			an      => an
		);

	----------------------------------------------------------------------------
	--                           Istantiating memory                          --
	----------------------------------------------------------------------------
	topRam0_inst : topRam
		generic map(
			depth_size => LayerInputDepth(2),
			size       => 5,
			ram_size   => LayerWidthHeight(2),
			NrOfInputs => NrOfInputs
		)
		port map(
			clk      => clk,
			rst      => rst,
			ena      => ram_ena(0),
			wea      => ram_wea(0),
			depth    => ram_depth0,
			addressX => ram_addressX0,
			addressY => ram_addressY0,
			dia      => ram_data_in,
			doa      => ram_data_out0,
			ready    => open            --ram_ready(0)
		);

	topRam1_inst : topRam
		generic map(
			depth_size => LayerInputDepth(1),
			size       => 5,
			ram_size   => LayerWidthHeight(1),
			NrOfInputs => NrOfInputs
		)
		port map(
			clk      => clk,
			rst      => rst,
			ena      => ram_ena(1),
			wea      => ram_wea(1),
			depth    => ram_depth1,
			addressX => ram_addressX1,
			addressY => ram_addressY1,
			dia      => ram_data_in,
			doa      => ram_data_out1,
			ready    => open            --ram_ready(1)
		);

	inputRam_inst : topFirstRam
		generic map(
			depth_size => layerInputDepth(0),
			size       => 5,
			ram_size   => layerWidthHeight(0),
			NrOfInputs => 1
		)
		port map(
			clk       => clk,
			rst       => rst,
			ena       => ram_ena(0),
			wea       => uartToMem_we,
			deptha    => uartToMem_AddrZ,
			addressXa => uartToMem_AddrX,
			addressYa => uartToMem_AddrY,
			depthb    => ram_depthStart,
			addressXb => ram_addressXStart,
			addressYb => ram_addressYStart,
			dia       => uartToMem_DataWrite,
			doa       => ram_data_out_first,
			ready     => open
		);

	/*  
    --This is to be subsituted with ram when ready.
    gen_romX : for x in -2 to 2 generate
        gen_romY : for y in -2 to 2 generate
            FirstRom_inst : FirstRom
                port map( --Reg to match ram
                    clk      => clk,
                    addressX => (addressX_reg + x),
                    addressY => (addressY_reg + y),
                    addressZ => addressZ_reg,
                    output   => ram_data_out_first((x + 2) + (y + 2)*5)
                );
        end generate;
    end generate;
    */
	----------------------------------------------------------------------------
	--        Pipeline for RAM blocks                                         --
	----------------------------------------------------------------------------  

	pipeRamInput_inst : pipeRamInput
		generic map(
			nrOfDelays => 0
		)
		port map(
			clk               => clk,
			rst               => rst,
			we_ram            => we_ram_pipedfm,
			addressXout       => addressXout_pipedfm,
			addressYout       => addressYout_pipedfm,
			filter            => filter_pipedfm,
			ram_data          => max_array,
			we_ram_piped      => we_ram_piped,
			addressXout_piped => addressXout_piped,
			addressYout_piped => addressYout_piped,
			filter_piped      => filter_piped,
			ram_data_piped    => ram_data_piped
		);

	----------------------------------------------------------------------------
	--        Pipeline for MacFull output                                     --
	----------------------------------------------------------------------------  
	pipeMacfullOut_inst : pipeMacfullOut
		generic map(
			nrOfDelays => 0
		)
		port map(
			clk               => clk,
			rst               => rst,
			we_ram            => we_ram_reg,
			addressXout       => addressXout_reg1,
			addressYout       => addressYout_reg1,
			filter            => filter_reg2,
			mac_array         => mac_array,
			we_ram_piped      => we_ram_pipedfm,
			addressXout_piped => addressXout_pipedfm,
			addressYout_piped => addressYout_pipedfm,
			filter_piped      => filter_pipedfm,
			mac_array_piped   => mac_array_piped
		);

	----------------------------------------------------------------------------
	--        Multiplexer for handling the three ram blocks                   --
	----------------------------------------------------------------------------   
	muxProcess : process(all) is
	begin
		if layerCount = 0 then          -- to_unsigned(0,layerCount'length) then
			input_mac <= ram_data_out_first;
		elsif layerCount(0) = '0' then
			input_mac <= ram_data_out0;
		else
			input_mac <= ram_data_out1;
		end if;

		ram_addressXStart <= addressX;
		ram_addressYStart <= addressY;
		ram_depthStart    <= addressZ;

		if layerCount_reg(0) = '0' then
			ram_addressX0 <= addressX;
			ram_addressY0 <= addressY;
			ram_depth0    <= addressZ;

			ram_addressX1 <= addressXOut_piped;
			ram_addressY1 <= addressYOut_piped;
			ram_depth1    <= filter_piped;

			ram_wea(0) <= '0';
			ram_wea(1) <= '1' and we_ram_piped;

		else
			ram_addressX1 <= addressX;
			ram_addressY1 <= addressY;
			ram_depth1    <= addressZ;

			ram_addressX0 <= addressXOut_piped;
			ram_addressY0 <= addressYOut_piped;
			ram_depth0    <= filter_piped;

			ram_wea(1) <= '0';
			ram_wea(0) <= '1' and we_ram_piped;
		end if;
	end process;

	----------------------------------------------------------------------------
	--                         Generate macfullfilters                        --
	----------------------------------------------------------------------------    
	GEN_MACFull : for I in 0 to NrOfInputs - 1 generate
		MACFullFilter_inst : MACFullFilter
			generic map(
				filter_offset => to_unsigned(I, natural(log2(real(nrOfInputs))))
			)
			port map(
				clk      => clk,
				rst      => rst,
				depth    => depth_reg,
				depthFC  => depthWFC_reg,
				convOrFC => innerConvFC_reg,
				Filter   => filter_input_reg(i),
				layer    => to_integer(layercount_reg),
				input    => input_mac,
				hold     => hold_reg,
				newCalc  => newCalc_reg,
				result   => MAC_array(i)
			);
	end generate;

	----------------------------------------------------------------------------
	--                         Istantiating inner fsm                         --
	----------------------------------------------------------------------------   
	fsm_inst : fsm
		port map(
			clk           => clk,
			rst           => rst,
			start         => innerstart,
			inputDepth    => innerDepth,
			inputXMax     => innerXMax,
			inputYMax     => innerYMax,
			totalFilters  => innerTotFilters,
			doneAck       => innerDoneAck,
			convOrFC      => innerConvFC,
			hold          => hold,
			new_calc      => newCalc,
			writeEnable   => writeEnable,
			x             => addressX,
			y             => addressY,
			depth         => addressZ,
			fcwDepth      => depthWFCInt,
			filter        => pre_filter,
			done          => done,
			calcMax       => calcMax,
			newMax        => newMax,
			maxCounterOut => maxCounterOut
		);

	----------------------------------------------------------------------------
	--                         Istantiating outer fsm                         --
	----------------------------------------------------------------------------   
	topFSM_inst : component topFSM
		port map(
			clk             => clk,
			rst             => rst,
			start           => start,
			innerDone       => done,
			innerStart      => innerStart,
			innerDepth      => innerDepth,
			innerXMax       => innerXMax,
			innerYMax       => innerYMax,
			innerTotFilters => innerTotFilters,
			innerConvFC     => innerConvFC,
			layerCount      => layerCount,
			innerDoneAck    => innerDoneAck,
			doneLED         => doneLED
		);

	----------------------------------------------------------------------------
	--                         Istantiating max pools                         --
	----------------------------------------------------------------------------   

	GEN_MAXPOOL : for I in 0 to (NrOfInputs - 1) generate
		inst_maxpool : maxpool
			port map(
				clk        => clk,
				rst        => rst,
				convResult => MAC_array_piped(I),
				newMax     => newMax_reg,
				calcMax    => calcMax_reg,
				MaxResult  => MAX_array(I)
			);

	end generate GEN_MAXPOOL;

	----------------------------------------------------------------------------
	--                         Istantiating UART interface                    --
	----------------------------------------------------------------------------
	uartController_inst : UartController
		port map(
			clk                  => clk,
			rst                  => rst,
			uartDataStreamTx     => uartDataStreamTx,
			uartDataStreamTx_stb => uartDataStreamTx_stb,
			uartDataStreamTx_ack => uartDataStreamTx_ack,
			uartDataStreamRx     => uartDataStreamRx,
			uartDataStreamRx_stb => uartDataStreamRx_stb,
			uartToMem_en         => open,
			uartToMem_we         => uartToMem_we,
			uartToMem_AddrX      => uartToMem_AddrX,
			uartToMem_AddrY      => uartToMem_AddrY,
			uartToMem_AddrZ      => uartToMem_AddrZ,
			uartToMem_DataWrite  => uartToMem_DataWrite
		);

	----------------------------------------------------------------------------
	--                         Istantiating UART interface                    --
	----------------------------------------------------------------------------

	uart_Inst : uart
		generic map(
			baud            => 115200,
			clock_frequency => CLOCK_FREQ
		)
		port map(
			clock               => clk,
			reset               => rst,
			data_stream_in      => uartDataStreamTx,
			data_stream_in_stb  => uartDataStreamTx_stb,
			data_stream_in_ack  => uartDataStreamTx_ack,
			data_stream_out     => uartDataStreamRx,
			data_stream_out_stb => uartDataStreamRx_stb,
			tx                  => tx,
			rx                  => rx
		);

	----------------------------------------------------------------------------
	--                         Logic for saving the results                   --
	----------------------------------------------------------------------------    

	ResultLogic : process(all)
	begin
		for I in 0 to 9 loop
			resultreg_next(I) <= resultReg(I);
		end loop;

		if (we_ram_reg = '1') and (innerConvFC_reg = '1') then

			for I in 0 to NrOfInputs - 1 loop
				if (filter_piped + I < layerTotFilters(nrOfLayers - 1)) then
					resultreg_next(I + filter_piped) <= ram_data_in(I);
				end if;
			end loop;

		end if;

	end process ResultLogic;

	----------------------------------------------------------------------------
	--                          Binding signals                               --
	----------------------------------------------------------------------------    
	ram_ena <= "11";

	ram_data_in <= ram_data_piped;

	depth <= to_unsigned(addressZ, depth'length);

	process(all)
	begin
		for i in 0 to NrOfInputs - 1 loop
			filter_input(i) <= filter + to_unsigned(I, 6);
		end loop;
	end process;

	--Divide by two because of maxpool. This may have to change in synthesis.
	addressXOut <= to_integer(to_unsigned(addressX_reg, 11)(10 downto 1));
	addressYOut <= to_integer(to_unsigned(addressY_reg, 11)(10 downto 1));

	depthWFC <= to_unsigned(depthWFCInt, depthWFC'length);

	filter <= to_unsigned(pre_filter, 6);
	----------------------------------------------------------------------------
	--                            Clocked registers                           --
	----------------------------------------------------------------------------

	process(clk, maxCounterOut(0 downto 0), maxCounterOut(1 downto 1), rst)
	begin
		if rst = '1' then
			writeEnableReg <= '0';
			we_ram         <= '0';

			addressX_reg <= 0;
			--addressX_reg2 <= 0;

			addressY_reg <= 0;
			--addressY_reg2 <= 0;

			addressZ_reg <= 0;

			filter_reg  <= 0;
			filter_reg1 <= 0;
			filter_reg2 <= 0;

			--maxCounterOutx <= maxCounterOut(0 downto 0);
			--maxCounterOuty <= maxCounterOut(1 downto 1);

			depth_reg        <= (others => '0');
			depthWFC_reg     <= (others => '0');
			innerConvFC_reg  <= '0';
			filter_input_reg <= (others => (others => '0'));
			layercount_reg   <= (others => '0');
			layercount_reg2  <= (others => '0');

			hold_reg    <= '0';
			newCalc_reg <= '0';

			newMax_reg  <= '0';
			calcMax_reg <= '0';

			we_ram_reg <= '0';

			for I in 0 to 9 loop
				resultReg(I) <= (others => '0');
			end loop;

		elsif rising_edge(clk) then

			writeEnableReg <= writeEnable;
			we_ram         <= writeEnableReg;

			we_ram_reg <= we_ram;

			addressX_reg <= addressX;
			--addressX_reg2 <= addressX_reg;

			addressY_reg <= addressY;
			--addressY_reg2 <= addressY_reg;

			addressZ_reg     <= addressZ;
			addressXOut_reg  <= addressXOut;
			addressXOut_reg1 <= addressXOut_reg;

			addressYOut_reg  <= addressYOut;
			addressYOut_reg1 <= addressYOut_reg;

			filter_reg  <= pre_filter;
			filter_Reg1 <= filter_reg;
			filter_reg2 <= filter_reg1;
			--maxCounterOutx <= maxCounterOut(0 downto 0);
			--maxCounterOuty <= maxCounterOut(1 downto 1);

			depth_reg        <= depth;
			depthWFC_reg     <= depthWFC;
			innerConvFC_reg  <= innerconvFC;
			filter_input_reg <= filter_input;
			layercount_reg   <= layercount;
			layercount_reg2  <= layercount_reg;

			hold_reg    <= hold;
			newCalc_reg <= newCalc;

			newMax_reg  <= newMax;
			calcMax_reg <= calcMax;

			for I in 0 to 9 loop
				resultReg(I) <= resultReg_next(I);
			end loop;

		end if;
	end process;
end architecture;
