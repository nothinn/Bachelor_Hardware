library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

    use work.Types.all;

entity weightsRom is
    port (
        clk: in  std_logic;
        rst: in  std_logic;
		filter: in integer range 0 to 31;

        output: out signed(7 downto 0)
    );
end entity;

architecture rtl of weightsRom is
    
begin
    
    
    process(all)
    begin
        if rising_edge(clk) then
            
            case filter is
				when 0 =>
						output <= "00000100";
					end case;
				when 1 =>
						output <= "00000000";
					end case;
				when 2 =>
						output <= "00000100";
					end case;
				when 3 =>
						output <= "11111000";
					end case;
				when 4 =>
						output <= "11110101";
					end case;
				when 5 =>
						output <= "00000011";
					end case;
				when 6 =>
						output <= "11111111";
					end case;
				when 7 =>
						output <= "00000111";
					end case;
				when 8 =>
						output <= "00001111";
					end case;
				when 9 =>
						output <= "00000000";
					end case;
				when 10 =>
						output <= "11111111";
					end case;
				when 11 =>
						output <= "11111100";
					end case;
				when 12 =>
						output <= "00000010";
					end case;
				when 13 =>
						output <= "00000001";
					end case;
				when 14 =>
						output <= "11111110";
					end case;
				when 15 =>
						output <= "11111000";
					end case;
				when 16 =>
						output <= "00000000";
					end case;
				when 17 =>
						output <= "00000011";
					end case;
				when 18 =>
						output <= "00000000";
					end case;
				when 19 =>
						output <= "00000100";
					end case;
				when 20 =>
						output <= "00000000";
					end case;
				when 21 =>
						output <= "11111101";
					end case;
				when 22 =>
						output <= "00000001";
					end case;
				when 23 =>
						output <= "11111100";
					end case;
				when 24 =>
						output <= "00000010";
					end case;
				when 25 =>
						output <= "00001010";
					end case;
				when 26 =>
						output <= "00000111";
					end case;
				when 27 =>
						output <= "00000010";
					end case;
				when 28 =>
						output <= "00000110";
					end case;
				when 29 =>
						output <= "11111101";
					end case;
				when 30 =>
						output <= "11111000";
					end case;
				when others =>
						output <= "11111110";
					end case;
            end case;
        end if;
    end process;
end architecture;
