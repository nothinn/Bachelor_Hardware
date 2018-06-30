library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.Types.all;
use IEEE.MATH_REAL.all;
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
	
	signal doareg0, doareg1, doareg2 : MAC_result;
    signal dobreg0, dobreg1, dobreg2 : MAC_result;
    signal enareg1, enareg2 : std_logic;
    signal enbreg1, enbreg2 : std_logic;
    signal addrareg1, addrareg2 : integer;
    signal addrbreg1, addrbreg2 : integer;
    signal weareg1, weareg2 : std_logic;
    signal webreg1, webreg2 : std_logic;
    signal diareg1, diareg2 : MAC_result;
    signal dibreg1, dibreg2 : MAC_result;
begin
	doa <= doareg2;
    dob <= dobreg2;
    
	process(clk)
	begin
		
		if rising_edge(clk) then
			if rst = '1' then
				doareg1 <= (others => '0');
				doareg2 <= (others => '0');
                dobreg1 <= (others => '0');
                dobreg2 <= (others => '0');
                enareg1 <= '0';
                enareg2 <= '0';
                enbreg1 <= '0';
                enbreg2 <= '0';
                addrareg1 <= 0;
                addrareg2 <= 0;
                addrbreg1 <= 0;
                addrbreg2 <= 0;
                weareg1 <= '0';
                weareg2 <= '0';
                webreg1 <= '0';
                webreg2 <= '0';
                diareg1 <= (others => '0');
                diareg2 <= (others => '0');
                dibreg1 <= (others => '0');
                dibreg2 <= (others => '0');
			else
                doareg1 <= doareg0;
                doareg2 <= doareg1;
                dobreg1 <= dobreg0;
                dobreg2 <= dobreg1;
                enareg1 <= ena;
                enareg2 <= enareg1;
                enbreg1 <= enb;
                enbreg2 <= enbreg1;
                addrareg1 <= addra;
                addrareg2 <= addrareg1;
                addrbreg1 <= addrb;
                addrbreg2 <= addrbreg1;
                weareg1 <= wea;
                weareg2 <= weareg1;
                webreg1 <= web;
                webreg2 <= webreg1;
                diareg1 <= dia;
                diareg2 <= diareg1;
                dibreg1 <= dib;
                dibreg2 <= dibreg1;                			    
				if enareg2 = '1' then
					if weareg2 = '1' then
						ram(addrareg2) <= diareg2;
					end if;
				end if;

				if enbreg2 = '1' then
					dobreg0 <= RAM(addrbreg2);      --mod (depth * integer((Ceil(real(width)/real(filter_width)))) **2 )); -- old approach
					if webreg2 = '1' then
					end if;
				end if;
			end if;
		end if;
	end process;

end architecture;
