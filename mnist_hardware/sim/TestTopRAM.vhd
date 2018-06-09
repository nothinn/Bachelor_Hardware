library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.types.all;
use work.ConfigVHDL.all;

entity TestTopRAM is
	port(
		clk      : in  std_logic;
		rst      : in  std_logic;
		start    : in  std_logic;
		topDoa   : out MAC_inputs;
		topReady : out std_logic
	);
end entity TestTopRAM;

architecture RTL of TestTopRAM is
	component topRam
		generic(
			depth_size : integer;
			size       : integer;
			ram_size   : integer;
			NrOfInputs : integer
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
	end component topRam;

	type statetype is (idle, read, addressupdateread, write, addressupdatewrite);

	signal state, stateNext : statetype;

	signal topx, topxNext, topy, topyNext : integer range 0 to 14 - 1;
	signal topz, topzNext                 : integer range 0 to 32 - 1;
	signal topena, topwea                 : std_logic;
	signal topdia                         : ram_input(NrOfINputs - 1 downto 0);

begin

	inst_topram : topRam
		generic map(
			depth_size => 32,
			size       => 5,
			ram_size   => 14,
			NrOfInputs => NrOfInputs
		)
		port map(
			clk      => clk,
			rst      => rst,
			ena      => topena,
			wea      => topwea,
			depth    => topz,
			addressX => topx,
			addressY => topy,
			dia      => topdia,
			doa      => topdoa,
			ready    => topready
		);

	process(all)
	begin
		topxNext  <= topx;
		topyNext  <= topy;
		topzNext  <= topz;
		topena    <= '1';
		topwea    <= '0';
		stateNext <= state;

		for I in 0 to 7 loop
			topdia(i) <= "0000000000000000";
		end loop;

		case state is
			when idle =>
				topxNext <= 0;
				topyNext <= 0;
				topzNext <= 0;

				if start = '1' then
					stateNext <= write;
				end if;
			when write =>
				topwea <= '1';
				for I in 0 to 7 loop
					topdia(I) <= to_unsigned(topx, 4) & to_unsigned(topy, 4) & to_unsigned(topz+I, 8);
				end loop;
				stateNext <= addressupdatewrite;
				
			when addressupdatewrite =>
				if topready = '0' then
					stateNext <= addressupdatewrite;
				else
					if topx < 14 - 1 then
						topxNext  <= topx + 1;
						stateNext <= write;
					else
						if topy < 14 - 1 then
							topxNext  <= 0;
							topyNext  <= topy + 1;
							stateNext <= write;
						else
							if topz+8 < 32 - 1 then
								topxNext  <= 0;
								topyNext  <= 0;
								topzNext  <= topz + 8;
								stateNext <= write;
							else
								topxNext  <= 0;
								topyNext  <= 0;
								topzNext  <= 0;
								stateNext <= read;
							end if;
						end if;
					end if;
				end if;	  
			when read =>
				stateNext <= addressupdateread;

			when addressupdateread =>
				if topx < 14 - 1 then
					topxNext  <= topx + 1;
					stateNext <= read;
				else
					if topy < 14 - 1 then
						topxNext  <= 0;
						topyNext  <= topy + 1;
						stateNext <= read;
					else
						if topz < 32 - 1 then
							topxNext  <= 0;
							topyNext  <= 0;
							topzNext  <= topz + 1;
							stateNext <= read;
						else
							stateNext <= idle;
						end if;
					end if;
				end if;
		end case;

		if rst = '1' then
			topx  <= 0;
			topy  <= 0;
			topz  <= 0;
			state <= idle;

		elsif rising_edge(clk) then
			topx  <= topxNext;
			topy  <= topyNext;
			topz  <= topzNext;
			state <= stateNext;
		end if;

	end process;

end architecture RTL;
