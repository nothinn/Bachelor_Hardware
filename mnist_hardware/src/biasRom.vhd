library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

    use work.Types.all;

entity biasRom is
    port (
        clk: in  std_logic;
        rst: in  std_logic;
		filter: in integer range 0 to 31;

        output: out signed(7 downto 0)
    );
end entity;

architecture rtl of biasRom is
    
begin
    
    
    process(all)
    begin
        if rising_edge(clk) then
            
            case filter is
				when 0 =>
						output <= "00000100";
				when 1 =>
						output <= "00000000";
				when 2 =>
						output <= "00000100";
				when 3 =>
						output <= "11111000";
				when 4 =>
						output <= "11110101";
				when 5 =>
						output <= "00000011";
				when 6 =>
						output <= "11111111";
				when 7 =>
						output <= "00000111";
				when 8 =>
						output <= "00001111";
				when 9 =>
						output <= "00000000";
				when 10 =>
						output <= "11111111";
				when 11 =>
						output <= "11111100";
				when 12 =>
						output <= "00000010";
				when 13 =>
						output <= "00000001";
				when 14 =>
						output <= "11111110";
				when 15 =>
						output <= "11111000";
				when 16 =>
						output <= "00000000";
				when 17 =>
						output <= "00000011";
				when 18 =>
						output <= "00000000";
				when 19 =>
						output <= "00000100";
				when 20 =>
						output <= "00000000";
				when 21 =>
						output <= "11111101";
				when 22 =>
						output <= "00000001";
				when 23 =>
						output <= "11111100";
				when 24 =>
						output <= "00000010";
				when 25 =>
						output <= "00001010";
				when 26 =>
						output <= "00000111";
				when 27 =>
						output <= "00000010";
				when 28 =>
						output <= "00000110";
				when 29 =>
						output <= "11111101";
				when 30 =>
						output <= "11111000";
				when others =>
						output <= "11111110";
            end case;
        end if;
    end process;
end architecture;
