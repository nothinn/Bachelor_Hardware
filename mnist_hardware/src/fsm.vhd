library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fsm is
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
end entity;

architecture rtl of fsm is

	constant XMAX, YMAX : integer := 28;

	type state_type is (idle, prep, add, save, max, finished);

	signal state, state_next : state_type;

	signal count, count_next : integer;

	signal xint, xint_next, yint, yint_next, depthin, depthin_next : integer := 0;

	signal new_calcint, new_calcint_next : std_logic;

	signal maxCounter, maxCounter_next : unsigned(1 downto 0);

begin
	filter   <= count;
	x        <= xint + to_integer(maxCounter(0 downto 0));
	y        <= yint + to_integer(maxCounter(1 downto 1));
	depth    <= depthin;
	hold     <= '0';
	new_calc <= new_calcint;
	maxCounterOut <= maxCounter;

	process(all)
	begin
		writeEnable      <= '0';
		state_next       <= state;
		xint_next        <= xint;
		yint_next        <= yint;
		depthin_next     <= depthin;
		done             <= '0';
		new_calcint_next <= '0';
		count_next       <= count;
		maxCounter_next  <= maxCounter;
		calcMax          <= '0';
		newMax           <= '0';

		case state is
			when idle =>
				xint_next    <= 0;
				yint_next    <= 0;
				depthin_next <= 0;
				count_next   <= 0;

				if start = '1' then
					state_next <= prep;
				end if;

			when prep =>
				new_calcint_next <= '1';
				depthin_next     <= 0;
				--count_next <= 0;

				state_next <= add;

			when add =>

				depthin_next <= depthin + 1;

				if depth = 3 - 1 then
					state_next   <= max;
					depthin_next <= 0;
				end if;

			when max =>
				calcmax         <= '1';
				maxCounter_next <= maxCounter + 1;

				if maxCounter + 1= "00" then
					newMax <= '1';
				end if;

				if maxcounter = "11" then
					state_next <= save;
				else
					state_next <= prep;
				end if;

			when save =>
				writeEnable <= '1';
				count_next  <= count + 8;

				if count + 8 < 32 then
					state_next <= prep;
				else
					count_next <= 0;
					if xint = XMAX - 2 then
						if yint = YMAX - 2 then
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
				if start = '0' then
					state_next <= idle;
				end if;
		end case;
	end process;

	process(clk)
	begin
		if rst = '1'  then
            state       <= idle;
            xint        <= 0;
            yint        <= 0;
            depthin     <= 0;
            count       <= 0;
            new_calcint <= '0';
            maxCounter  <= (others => '0');
            
        elsif rising_edge(clk) then
            state       <= state_next;
            xint        <= xint_next;
            yint        <= yint_next;
            depthin     <= depthin_next;
            count       <= count_next;
            new_calcint <= new_calcint_next;
            maxCounter  <= maxCounter_next;
		end if;
	end process;

end architecture;
