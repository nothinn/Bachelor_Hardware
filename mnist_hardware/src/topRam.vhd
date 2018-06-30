library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

use IEEE.math_real.all;

use work.Types.all;

entity topRam is
	generic(
		depth_size : integer := 64;
		size       : integer := 5;
		ram_size   : integer := 28
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
end entity;

--port a is used for input.
--port b is used for output.

architecture rtl of topRam is

	component addressTranslator is
		generic(
			depth_size : integer := depth_size;
			size       : integer := 5;
			ram_size   : integer := 28
		);
		port(
			clk        : in  std_logic;
			rst        : in  std_logic;
			addressX   : in  integer range 0 to ram_size - 1;
			addressY   : in  integer range 0 to ram_size - 1;
			valid      : in  std_logic;
			blocknr    : out integer range 0 to size ** 2 - 1;
			blockValid : out std_logic;
			depth_addr : out integer
		);
	end component;

	component ram is
		generic(
			depth        : integer := 64;
			width        : integer := 7;
			filter_width : integer := 5
		);
		port(
			clk   : in  std_logic;
			rst   : in  std_logic;
			ena   : in  std_logic;
			enb   : in  std_logic;
			addra : in  integer;
			addrb : in  integer;
			wea   : in  std_logic;
			web   : in  std_logic;
			dia   : in  MAC_result;
			dib   : in  MAC_result;
			doa   : out MAC_result;
			dob   : out MAC_result
		);
	end component;

	type trans_block is array (integer range size**2 - 1 downto 0) of integer range 0 to size **2 - 1;

	type trans_addr is array (integer range size**2 - 1 downto 0) of integer;

	signal blocknr_arr     : trans_block;
	signal blocknr_arr_reg, blocknr_arr_reg2, blocknr_arr_reg3, blocknr_arr_reg4, blocknr_arr_reg5 : trans_block; -- 2 to 5 due to RAM pipeline
	signal depth_addr_arr  : trans_addr;
	signal depth_addr_arr2 : trans_addr;

	signal blocknr          : integer;
	signal depth_addr       : integer;
	signal depth_addr_added : integer;

	signal latchedInput : ram_input(NrOfINputs - 1 downto 0);
	signal latchedDepth : integer range 0 to depth_size - 1;
	signal latchedAddrX : integer range 0 to ram_size - 1;
	signal latchedAddrY : integer range 0 to ram_size - 1;

	signal blockValid : std_logic_vector(size**2 - 1 downto 0);
	--
	signal counter    : integer range 0 to NrOfInputs - 1;

	type type_doa is array (integer range 0 to size **2 - 1) of MAC_result;
	type type_wea is array (integer range 0 to size **2 - 1) of std_logic;

	signal addrB : trans_addr;

	signal muxData : MAC_result;

	signal doa_int : mac_inputs;
	signal wea_int : type_wea;

	signal addressX_reg  : integer range 0 to ram_size - 1;
	signal addressY_reg  : integer range 0 to ram_size - 1;
	signal addressX_reg2, addressX_reg3, addressX_reg4, addressX_reg5, addressX_reg6 : integer range 0 to ram_size - 1; -- 3 to 6 due to RAM pipeline
	signal addressY_reg2, addressY_reg3, addressY_reg4, addressY_reg5, addressY_reg6 : integer range 0 to ram_size - 1;


	signal depthReg : integer range 0 to depth_size - 1;

	------------------------------------
	-- For OR-ing crossbar
	------------------------------------
	type addr_result_type is array (integer range size**2 - 1 downto 0) of integer;
	type addr_result_arr_type is array (integer range size**2 - 1 downto 0) of addr_result_type;

	signal translated_output : addr_result_arr_type;

	signal blocknr_reg    : integer;
	signal depth_addr_reg : integer;

	signal ready2 : std_logic;

	type block_valid_type is array (0 to size**2 - 1, 0 to size**2 - 1) of std_logic;
	signal block_valid : block_valid_type;

begin


	gen_crossbar : for i in 0 to size**2 - 1 generate
		gen_crossbar2 : for j in 0 to size**2 - 1 generate
			process(all) is
			begin
				if blockValid(i) = '0' then
					translated_output(i)(j) <= 0;
				else
					if blocknr_arr(i) = j then
						translated_output(i)(j) <= depth_addr_arr2(i) + depthReg;
					else
						translated_output(i)(j) <= 0;
					end if;
				end if;
			end process;
		end generate;
	end generate;

	gen_crossbar_receive : for i in 0 to size**2 - 1 generate
		process(all) is
			variable tmp : unsigned(10 downto 0);
		begin
			tmp := (others => '0');
			for j in 0 to size**2 - 1 loop
				tmp := tmp OR to_unsigned(translated_output(j)(i), 11);
			end loop;

			depth_addr_arr(i) <= to_integer(tmp);
		end process;
	end generate;

	process(clk, rst) is
	begin
		
		if rising_edge(clk) then
			if rst = '1' then
				ready2       <= '1';
				latchedInput <= (others => (others => '0'));
				latchedDepth <= 0;
				latchedAddrX <= 0;
				latchedAddrY <= 0;

				counter <= NrOfInputs - 1;

				addressX_reg  <= 0;
				addressY_reg  <= 0;
				addressX_reg2 <= 0;
				addressX_reg3 <= 0;
				addressX_reg4 <= 0;
				addressX_reg5 <= 0;
				addressX_reg6 <= 0;
				addressY_reg2 <= 0;
				addressY_reg3 <= 0;
				addressY_reg4 <= 0;
				addressY_reg5 <= 0;
				addressY_reg6 <= 0;
				depthReg      <= 0;

				blocknr_arr_reg <= (others => 0);
				blocknr_arr_reg2 <= (others => 0);
				blocknr_arr_reg3 <= (others => 0);
				blocknr_arr_reg4 <= (others => 0);
				blocknr_arr_reg5 <= (others => 0);

				blocknr_reg    <= 0;
				depth_addr_reg <= 0;
			else
				ready2        <= ready;
				addressX_reg  <= addressX;
				addressY_reg  <= addressY;
				addressX_reg2 <= addressX_reg;
				addressX_reg3 <= addressX_reg2;
				addressX_reg4 <= addressX_reg3;
				addressX_reg5 <= addressX_reg4;
				addressX_reg6 <= addressX_reg5;
				addressY_reg2 <= addressY_reg;
				addressY_reg3 <= addressY_reg2;
				addressY_reg4 <= addressY_reg3;
				addressY_reg5 <= addressY_reg4;
				addressY_reg6 <= addressY_reg5;

				blocknr_arr_reg  <= blocknr_arr;
				blocknr_arr_reg2 <= blocknr_arr_reg;
				blocknr_arr_reg3 <= blocknr_arr_reg2;
				blocknr_arr_reg4 <= blocknr_arr_reg3;
				blocknr_arr_reg5 <= blocknr_arr_reg4;
				depthReg        <= depth;

				if counter = 0 then

					blocknr_reg    <= blocknr;
					depth_addr_reg <= depth_addr;
				end if;

				if wea = '1' then
					latchedInput <= dia;
					latchedDepth <= depth;
					latchedAddrX <= addressX;
					latchedAddrY <= addressY;

					counter <= 0;
				elsif counter < NrOfInputs - 1 then
					counter <= counter + 1;
				end if;
			end if;
		end if;
	end process;

	ready <= '1' when counter = NrOfInputs - 1 else '0';

	ramGen : for i in 0 to size **2 - 1 generate
		ram_inst : ram
			generic map(
				depth        => depth_size,
				width        => ram_size,
				filter_width => size
			)
			port map(
				clk   => clk,
				rst   => rst,
				ena   => ena,
				enb   => ena,           --enb,
				addra => depth_addr_added,
				addrb => depth_addr_arr(i), --addrb,
				wea   => wea_int(i),
				web   => '0',           --web,
				dia   => muxData,
				dib   => (others => '0'), --dib,
				doa   => open,
				dob   => doa_int(i)
			);
	end generate;

	process(all) is
	begin
		if counter = 0 then
			depth_addr_added <= depth_addr + counter + latchedDepth;
			--We look at the translated address and decode if it should be a write enable.

			for i in 0 to size**2 - 1 loop
				wea_int(i) <= '0';
			end loop;

			--enable the ram corresponding to the chosen block.
			if ready = '0' or ready2 = '0' then
				wea_int(blocknr) <= '1';
			else
				wea_int(blocknr) <= '0';
			end if;

		else
			depth_addr_added <= depth_addr_reg + counter + latchedDepth;

			for i in 0 to size**2 - 1 loop
				wea_int(i) <= '0';
			end loop;

			--enable the ram corresponding to the chosen block.
			if ready = '0' or ready2 = '0' then
				wea_int(blocknr_reg) <= '1';
			else
				wea_int(blocknr_reg) <= '0';
			end if;
		end if;
	end process;

	process(all) is
	begin
		muxData <= latchedInput(counter);
	end process;

	ramProcess : process(all) is
	begin
		--if ena = '1' then
		for x in -size/2 to size/2 loop
			for y in -size/2 to size/2 loop

				if addressX_reg6 + x < 0 or addressX_reg6 + x >= ram_size or addressY_reg6 + y < 0 or addressY_reg6 + y >= ram_size then
					doa((x + 2) + size*(y + 2)) <= (others => '0');
				else
					doa((x + 2) + size*(y + 2)) <= doa_int(blocknr_arr_reg5((x + 2) + (y + 2)*size));
				end if;
			end loop;
		end loop;
		--end if;
	end process;

	translateValidProcess : process(all) is
	begin
		--if ena = '1' then
		for x in -size/2 to size/2 loop
			for y in -size/2 to size/2 loop
				if (addressX + x) < 0 or (addressX + x) >= ram_size or (addressY + y) < 0 or (addressY + y) >= ram_size then
					block_valid(x + 2, y + 2) <= '0';
				else
					block_valid(x + 2, y + 2) <= '1';
				end if;
			end loop;
		end loop;
		--end if;
	end process;

	--Generate translators for all the outputs of portB.
	gen_trans : for I in 0 to size - 1 generate
		gen_trans2 : for J in 0 to size - 1 generate
			addressTranslator_inst : addressTranslator
				generic map(
					depth_size => depth_size,
					size       => size,
					ram_size   => ram_size
				)
				port map(
					clk        => clk,
					rst        => rst,
					addressX   => addressX + (-size/2 + i),
					addressY   => addressY + (-size/2 + j),
					valid      => block_valid(i, j),
					blocknr    => blocknr_arr(I + j*size),
					blockValid => blockValid(I + j*size),
					depth_addr => depth_addr_arr2(I + j*size)
				);
		end generate;
	end generate;

	--We only look at a single address on the way in.
	addressTranslator_inst : addressTranslator
		generic map(
			depth_size => depth_size,
			size       => size,
			ram_size   => ram_size
		)
		port map(
			clk        => clk,
			rst        => rst,
			addressX   => addressX,
			addressY   => addressY,
			valid      => wea,
			blocknr    => blocknr,
			blockValid => open,
			depth_addr => depth_addr
		);

end architecture;
