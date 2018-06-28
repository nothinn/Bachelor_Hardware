-- -----------------------------------------------------------------------------
--
--  Project    : Hardware Accelerator for Image processing using an FPGA
--             : Bachelor, DTU
--             :
--  Title      :  FirstRAM
--             :
--  Developers :  Anthon Vincent Riber - s154663@student.dtu.dk
--             :  Simon Thye Andersen  - s154227@student.dtu.dk
--             :
--  Purpose    :  The tom file for the memory component used as source input
--             :  for the first layer. This is the memory that the input is 
--             :  written to over UART
--             :
--  Revision   :  1.0   20-06-18     Final version
--             :
-- -----------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use IEEE.math_real.all;

use work.Types.all;

entity topFirstRam is
	generic(
		depth_size : integer := 64;
		size       : integer := 5;
		ram_size   : integer := 28;
		NrOfInputs : integer := 8
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
end entity;

--port a is used for input.
--port b is used for output.

architecture rtl of topFirstRam is

	----------------------------------------------------------
	--             Component declarations                   --
	----------------------------------------------------------

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

	----------------------------------------------------------
	--            type and signal declarations              --
	----------------------------------------------------------

	type trans_block is array (integer range size**2 - 1 downto 0) of integer range 0 to size **2 - 1;
	type trans_addr is array (integer range size**2 - 1 downto 0) of integer;
	type type_doa is array (integer range 0 to size **2 - 1) of MAC_result;
	type type_wea is array (integer range 0 to size **2 - 1) of std_logic;

	signal depthb_reg : integer range 0 to depth_size - 1;

	signal blocknr_arr                                                                             : trans_block;
	signal blocknr_arr_reg, blocknr_arr_reg2, blocknr_arr_reg3, blocknr_arr_reg4, blocknr_arr_reg5 : trans_block; -- 2 to 5 due to RAM pipeline
	signal depth_addr_arr                                                                          : trans_addr;
	signal depth_addr_arr2                                                                         : trans_addr;

	signal blocknr          : integer;
	signal depth_addr       : integer;
	signal depth_addr_added : integer;

	signal latchedInput : ram_input(NrOfINputs - 1 downto 0);
	signal latchedDepth : integer range 0 to depth_size - 1;
	signal latchedAddrX : integer range 0 to ram_size - 1;
	signal latchedAddrY : integer range 0 to ram_size - 1;

	signal blockValid : std_logic_vector(size**2 - 1 downto 0);

	signal counter : integer range 0 to NrOfInputs - 1;

	signal addrB : trans_addr;

	signal muxData : MAC_result;

	signal doa_int : mac_inputs;
	signal wea_int : type_wea;

	signal addressX_reg                                                              : integer range 0 to ram_size - 1;
	signal addressY_reg                                                              : integer range 0 to ram_size - 1;
	signal addressX_reg2, addressX_reg3, addressX_reg4, addressX_reg5, addressX_reg6 : integer range 0 to ram_size - 1; -- 3 to 6 due to RAM pipeline
	signal addressY_reg2, addressY_reg3, addressY_reg4, addressY_reg5, addressY_reg6 : integer range 0 to ram_size - 1;

	------------------------------------
	--      For OR-ing crossbar       --
	------------------------------------
	type addr_result_type is array (integer range size**2 - 1 downto 0) of integer;
	type addr_result_arr_type is array (integer range size**2 - 1 downto 0) of addr_result_type;
	type block_valid_type is array (0 to size**2 - 1, 0 to size**2 - 1) of std_logic;

	signal translated_output : addr_result_arr_type;

	signal blocknr_reg    : integer;
	signal depth_addr_reg : integer;

	signal ready2 : std_logic;

	signal block_valid : block_valid_type;

	signal wea_reg : std_logic;

begin

	----------------------------------------------------------
	--            Instantiating the components              --
	----------------------------------------------------------

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
					addressX   => addressXb + (-size/2 + i),
					addressY   => addressYb + (-size/2 + j),
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
			addressX   => addressXa,
			addressY   => addressYa,
			valid      => wea,
			blocknr    => blocknr,
			blockValid => open,
			depth_addr => depth_addr
		);

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

	----------------------------------------------------------
	--                       Logic                          --
	----------------------------------------------------------

	ready <= '1' when counter = NrOfInputs - 1 else '0';

	-- Cross bar logic (Input rounting)
	gen_crossbar : for i in 0 to size**2 - 1 generate
		gen_crossbar2 : for j in 0 to size**2 - 1 generate
			process(all) is
			begin
				if blockValid(i) = '0' then
					translated_output(i)(j) <= 0;
				else
					if blocknr_arr(i) = j then
						translated_output(i)(j) <= depth_addr_arr2(i) + depthb_reg;
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

	-- write enable logic
	process(all) is
	begin
		depth_addr_added <= depth_addr + counter + latchedDepth;

		for i in 0 to size**2 - 1 loop
			wea_int(i) <= '0';
		end loop;

		--enable the ram corresponding to the chosen block.
		if wea_reg = '1' then
			wea_int(blocknr) <= '1';
		else
			wea_int(blocknr) <= '0';
		end if;

		muxData <= latchedInput(counter);
	end process;

	-- Out of bounds check and output rounting
	ramProcess : process(all) is
	begin
		--if ena = '1' then
		for x in -size/2 to size/2 loop
			for y in -size/2 to size/2 loop

				if addressX_reg6 + x < 0 or addressX_reg6 + x >= ram_size or addressY_reg6 + y < 0 or addressY_reg6 + y >= ram_size then
					doa((x + 2) + (y + 2)*size) <= (others => '0');
				else
					doa((x + 2) + (y + 2)*size) <= doa_int(blocknr_arr_reg5((x + 2) + (y + 2)*size));
				end if;
			end loop;
		end loop;
		--end if;
	end process;

	-- out of bounds check for address translators
	translateValidProcess : process(all) is
	begin
		--if ena = '1' then
		for x in -size/2 to size/2 loop
			for y in -size/2 to size/2 loop
				if (addressXB + x) < 0 or (addressXB + x) >= ram_size or (addressYB + y) < 0 or (addressYB + y) >= ram_size then
					block_valid(x + 2, y + 2) <= '0';
				else
					block_valid(x + 2, y + 2) <= '1';
				end if;
			end loop;
		end loop;
		--end if;
	end process;

	----------------------------------------------------------
	--                 Register Transfer                    --
	----------------------------------------------------------	

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

				blocknr_arr_reg  <= (others => 0);
				blocknr_arr_reg2 <= (others => 0);
				blocknr_arr_reg3 <= (others => 0);
				blocknr_arr_reg4 <= (others => 0);
				blocknr_arr_reg5 <= (others => 0);
				blocknr_reg      <= 0;

				depthb_reg     <= 0;
				depth_addr_reg <= 0;

				wea_reg <= '0';
			else
				ready2        <= ready;
				addressX_reg  <= addressXb;
				addressY_reg  <= addressYb;
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

				depthb_reg <= depthb;

				wea_reg <= wea;

				if counter = 0 then

					blocknr_reg    <= blocknr;
					depth_addr_reg <= depth_addr;
				end if;

				if wea = '1' then
					latchedInput <= dia;
					latchedDepth <= deptha;
					latchedAddrX <= addressXa;
					latchedAddrY <= addressYa;

					counter <= 0;
				elsif counter < NrOfInputs - 1 then
					counter <= counter + 1;
				end if;
			end if;
		end if;
	end process;

end architecture;
