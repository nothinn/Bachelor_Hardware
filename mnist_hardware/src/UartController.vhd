-- -----------------------------------------------------------------------------
--
--  Project    : Hardware Accelerator for Image processing using an FPGA
--             : Bachelor, DTU
--             :
--  Title      :  UARTController
--             :
--  Developers :  Anthon Vincent Riber - s154663@student.dtu.dk
--             :  Simon Thye Andersen  - s154227@student.dtu.dk
--             :
--  Purpose    :  UART controller for downloading input image
--             :
--  Revision   :  1.0   20-06-18     Final version
--             :
-- -----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.Types.all;
use work.configVHDL.all;

entity UartController is
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
end entity UartController;

architecture RTL of UartController is

	----------------------------------------------------------
	--            type and signal declarations              --
	----------------------------------------------------------

	type stateType is (WaitForDownload, loadByte0, loadByte1, save);

	signal state, stateNext                   : stateType;
	signal addrX, addrY, addrXNext, addrYNext : integer range 0 to layerWidthHeight(0) - 1;
	signal addrZ, addrZNext                   : integer range 0 to layerInputDepth(0) - 1;
	signal WriteData, WriteDataNext           : ram_input(0 downto 0);
begin
	uartToMem_AddrX     <= addrX;
	uartToMem_AddrY     <= addrY;
	uartToMem_AddrZ     <= addrZ;
	uartToMem_DataWrite <= WriteData;

	----------------------------------------------------------
	--                     FSM Logic                        --
	----------------------------------------------------------		

	process(all)
	begin
		stateNext     <= state;
		addrXNext     <= addrX;
		addrYNext     <= addrY;
		addrZNext     <= addrZ;
		WriteDataNext <= WriteData;
		uartToMem_en  <= '0';
		uartToMem_we  <= '0';

		case state is
			when WaitForDownload =>
				addrXNext <= 0;
				addrYNext <= 0;
				addrZNext <= 0;
				if (uartDataStreamRx_stb = '1' and uartDataStreamRx = x"53") then -- x53 = 'S' For start
					stateNext <= loadByte0;
				end if;

			when loadByte0 =>
				if (uartDataStreamRx_stb = '1') then
					WriteDataNext(0)(7 downto 0) <= unsigned(uartDataStreamRx);
					stateNext                    <= loadByte1;
				end if;

			when loadByte1 =>
				if (uartDataStreamRx_stb = '1') then
					WriteDataNext(0)(15 downto 8) <= unsigned(uartDataStreamRx);
					stateNext                     <= save;
				end if;

			when save =>
				uartToMem_en <= '1';
				uartToMem_we <= '1';

				if (addrX < layerWidthHeight(0) - 1) then
					addrXNext <= addrX + 1;
					stateNext <= loadByte0;

				else
					if (addrY < layerWidthHeight(0) - 1) then
						addrXNext <= 0;
						addrYNext <= addrY + 1;
						stateNext <= loadByte0;
					else
						if (addrZ < layerInputDepth(0) - 1) then
							addrXNext <= 0;
							addrYNext <= 0;
							addrZNext <= addrZ + 1;
							stateNext <= loadByte0;

						else
							stateNext <= WaitForDownload;
						end if;
					end if;
				end if;
		end case;

		----------------------------------------------------------
		--                 Register Transfer                    --
		----------------------------------------------------------	

		
		if rising_edge(clk) then
			if (rst = '1') then
				state        <= WaitForDownload;
				addrX        <= 0;
				addrY        <= 0;
				addrZ        <= 0;
				WriteData(0) <= (others => '0');
			else
				state        <= stateNext;
				addrX        <= addrXNext;
				addrY        <= addrYNext;
				addrZ        <= addrZNext;
				WriteData(0) <= WriteDataNext(0);
			end if;
		end if;

	end process;

end architecture RTL;
