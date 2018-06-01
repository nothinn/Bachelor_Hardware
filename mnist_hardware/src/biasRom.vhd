library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

    use work.Types.all;

entity biasRom is
    port (
        clk: in  std_logic;
        rst: in  std_logic;
		layer: in integer range 0 to 3;
		filter: in integer range 0 to 63;

        output: out signed(7 downto 0)
    );
end entity;

architecture rtl of biasRom is
    
begin
    
    
    process(all)
    begin
        if rising_edge(clk) then
            case layer is
				when 0 =>
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
				when 1 =>
					case filter is
						when 0 =>
							output <= "11110110";
						when 1 =>
							output <= "00000110";
						when 2 =>
							output <= "11111000";
						when 3 =>
							output <= "11111110";
						when 4 =>
							output <= "11111010";
						when 5 =>
							output <= "11111100";
						when 6 =>
							output <= "00000001";
						when 7 =>
							output <= "00000000";
						when 8 =>
							output <= "11110100";
						when 9 =>
							output <= "00000101";
						when 10 =>
							output <= "11111101";
						when 11 =>
							output <= "11111110";
						when 12 =>
							output <= "11111010";
						when 13 =>
							output <= "00000101";
						when 14 =>
							output <= "11111100";
						when 15 =>
							output <= "00000110";
						when 16 =>
							output <= "11111110";
						when 17 =>
							output <= "11110110";
						when 18 =>
							output <= "11111001";
						when 19 =>
							output <= "00000000";
						when 20 =>
							output <= "00000000";
						when 21 =>
							output <= "11110001";
						when 22 =>
							output <= "11111111";
						when 23 =>
							output <= "11111100";
						when 24 =>
							output <= "11110111";
						when 25 =>
							output <= "00000010";
						when 26 =>
							output <= "00000010";
						when 27 =>
							output <= "11110110";
						when 28 =>
							output <= "11111101";
						when 29 =>
							output <= "11110010";
						when 30 =>
							output <= "11111101";
						when 31 =>
							output <= "11111101";
						when 32 =>
							output <= "11111101";
						when 33 =>
							output <= "11111101";
						when 34 =>
							output <= "11111100";
						when 35 =>
							output <= "00000011";
						when 36 =>
							output <= "11111001";
						when 37 =>
							output <= "11111100";
						when 38 =>
							output <= "11111111";
						when 39 =>
							output <= "00000100";
						when 40 =>
							output <= "11111111";
						when 41 =>
							output <= "11111001";
						when 42 =>
							output <= "00000011";
						when 43 =>
							output <= "00000000";
						when 44 =>
							output <= "00000010";
						when 45 =>
							output <= "11111111";
						when 46 =>
							output <= "11111011";
						when 47 =>
							output <= "11111100";
						when 48 =>
							output <= "00000010";
						when 49 =>
							output <= "11101111";
						when 50 =>
							output <= "00000110";
						when 51 =>
							output <= "11111111";
						when 52 =>
							output <= "00000000";
						when 53 =>
							output <= "11111100";
						when 54 =>
							output <= "11111101";
						when 55 =>
							output <= "00000000";
						when 56 =>
							output <= "00000010";
						when 57 =>
							output <= "00000000";
						when 58 =>
							output <= "11111101";
						when 59 =>
							output <= "11111111";
						when 60 =>
							output <= "11111010";
						when 61 =>
							output <= "00000000";
						when 62 =>
							output <= "11111111";
						when others =>
							output <= "11111110";
						end case;
				when others =>
					case filter is
						when 0 =>
							output <= "11111001";
						when 1 =>
							output <= "00010111";
						when 2 =>
							output <= "11111100";
						when 3 =>
							output <= "11111011";
						when 4 =>
							output <= "00000001";
						when 5 =>
							output <= "00000001";
						when 6 =>
							output <= "11111110";
						when 7 =>
							output <= "00001000";
						when 8 =>
							output <= "11110010";
						when others =>
							output <= "11111111";
						end case;
            end case;
        end if;
    end process;
end architecture;
