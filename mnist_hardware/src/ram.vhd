-- -----------------------------------------------------------------------------
--
--  Project    : Hardware Accelerator for Image processing using an FPGA
--             : Bachelor, DTU
--             :
--  Title      :  RAM
--             :
--  Developers :  Anthon Vincent Riber - s154663@student.dtu.dk
--             :  Simon Thye Andersen  - s154227@student.dtu.dk
--             :
--  Purpose    :  RAM block for the memory components
--             :
--  Revision   :  1.0   20-06-18     Final version
--             :
--
-- -----------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.MATH_REAL.all;

use work.Types.all;

entity ram is
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
end entity;

architecture rtl of ram is

	signal RAM : mem_block((depth * integer((Ceil(real(width)/real(filter_width)))) **2 - 1) downto 0);

begin

	process(clk)
	begin
		
		if rising_edge(clk) then
			if rst = '1' then
				dob <= (others => '0');
			else
				if ena = '1' then
					if wea = '1' then
						ram(addra) <= dia;
					end if;
				end if;

				if enb = '1' then
					dob <= RAM(addrb);      --mod (depth * integer((Ceil(real(width)/real(filter_width)))) **2 )); -- old approach
					if web = '1' then
					end if;
				end if;
			end if;
		end if;
	end process;

end architecture;
