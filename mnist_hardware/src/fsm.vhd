-- -----------------------------------------------------------------------------
--
--  Project    : Hardware Accelerator for Image processing using an FPGA
--             : Bachelor, DTU
--             :
--  Title      :  FSM
--             :
--  Developers :  Anthon Vincent Riber - s154663@student.dtu.dk
--             :  Simon Thye Andersen  - s154227@student.dtu.dk
--             :
--  Purpose    :  The FSM controlling execution of a sigle layer
--             :
--  Revision   :  1.0   20-06-18     Final version
--             :
-- -----------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity fsm is
	port(
		clk           : in  std_logic;
		rst           : in  std_logic;
		start         : in  std_logic;
		inputDepth    : in  unsigned(6 downto 0); -- in this implementation the maximal depth of a feature map is 64
		inputXMax     : in  unsigned(5 downto 0); -- the max height/witdh of a featuremap is 28
		inputYMax     : in  unsigned(5 downto 0);
		totalFilters  : in  unsigned(6 downto 0); -- the maximum amount of filters used in a layer is 64
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
end entity;

architecture rtl of fsm is

	----------------------------------------------------------
	--             signal declarations                      --
	----------------------------------------------------------

	type state_type is (idle, prep, MAC, save, max, finished, prepFC, MACFC, maxFC, saveFC);

	signal state, state_next : state_type;

	signal filterCount, filterCount_next : integer;

	signal xint, xint_next, yint, yint_next, depthin, depthin_next, fcWDepthIn, fcWDepthIn_next : integer := 0;

	signal new_calcint, new_calcint_next : std_logic;

	signal maxCounter, maxCounter_next : unsigned(1 downto 0);

begin
	filter        <= filterCount;
	x             <= xint + to_integer(maxCounter(0 downto 0));
	y             <= yint + to_integer(maxCounter(1 downto 1));
	depth         <= depthin;
	fcWDepth      <= fcWDepthin;
	hold          <= '0';
	new_calc      <= new_calcint;
	maxCounterOut <= maxCounter;

	process(all)
		----------------------------------------------------------
		--                     FSM Logic                        --
		----------------------------------------------------------		
	begin
		writeEnable      <= '0';
		state_next       <= state;
		xint_next        <= xint;
		yint_next        <= yint;
		depthin_next     <= depthin;
		fcWDepthin_next  <= fcWDepthin;
		done             <= '0';
		new_calcint_next <= '0';
		filterCount_next <= filterCount;
		maxCounter_next  <= maxCounter;
		calcMax          <= '0';
		newMax           <= '0';

		case state is
			when idle =>
				xint_next        <= 0;
				yint_next        <= 0;
				depthin_next     <= 0;
				filterCount_next <= 0;

				if start = '1' then
					if convOrFC = '1' then
						state_next <= prepFC;
					else
						state_next <= prep;
					end if;
				end if;

			when prep =>
				new_calcint_next <= '1';
				depthin_next     <= 0;

				state_next <= MAC;

			when MAC =>

				depthin_next <= depthin + 1;

				if depth = inputDepth - 1 then
					state_next   <= max;
					depthin_next <= 0;
				end if;

			when max =>
				calcmax         <= '1';
				maxCounter_next <= maxCounter + 1;

				if maxCounter = "00" then
					newMax <= '1';
				end if;

				if maxcounter = "11" then
					state_next <= save;
				else
					state_next <= prep;
				end if;

			when save =>
				writeEnable      <= '1';
				filterCount_next <= filterCount + NrOfInputs;

				if filterCount + NrOfInputs < totalFilters then
					state_next <= prep;
				else
					filterCount_next <= 0;
					if xint = inputXMax - 2 then
						if yint = inputYMax - 2 then
							state_next <= finished;
						else
							xint_next  <= 0;
							yint_next  <= yint + 2;
							state_next <= prep;
						end if;

					else
						xint_next  <= xint + 2;
						state_next <= prep;
					end if;
				end if;

			when finished =>
				done <= '1';
				if doneAck = '1' then
					state_next <= idle;
				end if;

			when prepFC =>
				new_calcint_next <= '1';
				xint_next        <= 2;
				yint_next        <= 2;
				fcWDepthin_next  <= 0;
				depthin_next     <= 0;

				state_next <= MACFC;

			when MACFC =>
				fcWDepthin_next <= fcWDepthin + 1;
				depthin_next    <= depthin + 1;
				if depthin < inputDepth - 1 then
					state_next <= MACFC;
				else
					depthin_next <= 0;

					if xint + 5 > inputXMax then

						if yint + 5 > inputYMax then
							state_next <= maxFC;
						else
							xint_next  <= 2;
							yint_next  <= yint + 5;
							state_next <= MACFC;
						end if;

					else
						xint_next  <= xint + 5;
						state_next <= MACFC;
					end if;
				end if;

			when maxFC =>
				calcmax    <= '1';
				newMax     <= '1';
				state_next <= saveFC;

			when saveFC =>
				writeEnable      <= '1';
				filterCount_next <= filterCount + NrOfInputs;
				if filtercount + NrOfInputs < totalFilters then
					state_next <= prepFC;
				else
					state_next <= finished;
				end if;

		end case;
	end process;
	----------------------------------------------------------
	--                 Register Transfer                    --
	----------------------------------------------------------	
	process(clk, rst)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				state       <= idle;
				xint        <= 0;
				yint        <= 0;
				depthin     <= 0;
				fcWDepthin  <= 0;
				filterCount <= 0;
				new_calcint <= '0';
				maxCounter  <= (others => '0');
			else 
				state       <= state_next;
				xint        <= xint_next;
				yint        <= yint_next;
				depthin     <= depthin_next;
				fcWDepthin  <= fcWDepthin_next;
				filterCount <= filterCount_next;
				new_calcint <= new_calcint_next;
				maxCounter  <= maxCounter_next;
			end if;
		end if;
	end process;

end architecture;
