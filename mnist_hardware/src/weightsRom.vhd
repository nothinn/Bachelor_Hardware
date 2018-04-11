library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

    use work.Types.all;

entity weightsRom is
    generic (
        addressX: integer range 0 to 4; 
        addressY: integer range 0 to 4

    );
    port (
        clk: in  std_logic;
        rst: in  std_logic;
        filter: in integer range 0 to 31;
        addressZ: in integer range 0 to 2;

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
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01000100";
                                        when 1 =>
                                            output <= "11110101";
                                        when others =>
                                            output <= "11110011";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10111110";
                                        when 1 =>
                                            output <= "11110111";
                                        when others =>
                                            output <= "11100000";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010011";
                                        when 1 =>
                                            output <= "11100000";
                                        when others =>
                                            output <= "11101100";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101000";
                                        when 1 =>
                                            output <= "11100111";
                                        when others =>
                                            output <= "10110110";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000110";
                                        when 1 =>
                                            output <= "01101001";
                                        when others =>
                                            output <= "11101111";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11000010";
                                        when 1 =>
                                            output <= "00101100";
                                        when others =>
                                            output <= "10101111";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00100010";
                                        when 1 =>
                                            output <= "11010111";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111101";
                                        when 1 =>
                                            output <= "00100011";
                                        when others =>
                                            output <= "01101111";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11010100";
                                        when 1 =>
                                            output <= "10111011";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10100111";
                                        when 1 =>
                                            output <= "01000000";
                                        when others =>
                                            output <= "00010100";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01000001";
                                        when 1 =>
                                            output <= "11011101";
                                        when others =>
                                            output <= "11100110";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001100";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "01101111";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "11000010";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011001";
                                        when 1 =>
                                            output <= "00000111";
                                        when others =>
                                            output <= "00001111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111100";
                                        when 1 =>
                                            output <= "11101111";
                                        when others =>
                                            output <= "00100011";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "11001010";
                                        when others =>
                                            output <= "11110000";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01001010";
                                        when 1 =>
                                            output <= "00111001";
                                        when others =>
                                            output <= "11101010";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01001100";
                                        when 1 =>
                                            output <= "01000100";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11010000";
                                        when 1 =>
                                            output <= "11011001";
                                        when others =>
                                            output <= "01001000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111101";
                                        when 1 =>
                                            output <= "11100000";
                                        when others =>
                                            output <= "11000010";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10111001";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "10001001";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10001110";
                                        when 1 =>
                                            output <= "11110001";
                                        when others =>
                                            output <= "01101101";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "11101010";
                                        when others =>
                                            output <= "01100011";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10111100";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "00000000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10110001";
                                        when 1 =>
                                            output <= "01010110";
                                        when others =>
                                            output <= "01000010";
                                    end case;
                            end case;
                    end case;
                when 1 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "11101011";
                                        when others =>
                                            output <= "10101100";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10011001";
                                        when 1 =>
                                            output <= "00000111";
                                        when others =>
                                            output <= "11110001";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000000";
                                        when 1 =>
                                            output <= "11011001";
                                        when others =>
                                            output <= "01101100";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01110001";
                                        when 1 =>
                                            output <= "11110101";
                                        when others =>
                                            output <= "11100101";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10110111";
                                        when 1 =>
                                            output <= "01111010";
                                        when others =>
                                            output <= "11110101";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010011";
                                        when 1 =>
                                            output <= "11100011";
                                        when others =>
                                            output <= "10101001";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01110010";
                                        when 1 =>
                                            output <= "10100110";
                                        when others =>
                                            output <= "10110000";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01000101";
                                        when 1 =>
                                            output <= "11110111";
                                        when others =>
                                            output <= "00000000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011001";
                                        when 1 =>
                                            output <= "11111000";
                                        when others =>
                                            output <= "00001000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01110101";
                                        when 1 =>
                                            output <= "11101110";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11100110";
                                        when 1 =>
                                            output <= "10011111";
                                        when others =>
                                            output <= "10100111";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "00111100";
                                        when others =>
                                            output <= "01000110";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00101000";
                                        when 1 =>
                                            output <= "01010010";
                                        when others =>
                                            output <= "10011000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10101000";
                                        when 1 =>
                                            output <= "01010101";
                                        when others =>
                                            output <= "10000111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11000001";
                                        when 1 =>
                                            output <= "10110111";
                                        when others =>
                                            output <= "01111110";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11000011";
                                        when 1 =>
                                            output <= "10110011";
                                        when others =>
                                            output <= "00110011";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01010001";
                                        when 1 =>
                                            output <= "00101011";
                                        when others =>
                                            output <= "11110010";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01001101";
                                        when 1 =>
                                            output <= "00100101";
                                        when others =>
                                            output <= "00100100";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01010100";
                                        when 1 =>
                                            output <= "00011001";
                                        when others =>
                                            output <= "00000000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01000101";
                                        when 1 =>
                                            output <= "10000101";
                                        when others =>
                                            output <= "10011101";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001100";
                                        when 1 =>
                                            output <= "10011011";
                                        when others =>
                                            output <= "00001110";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101100";
                                        when 1 =>
                                            output <= "01110001";
                                        when others =>
                                            output <= "01000010";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011111";
                                        when 1 =>
                                            output <= "10110010";
                                        when others =>
                                            output <= "10110001";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11011110";
                                        when 1 =>
                                            output <= "01001101";
                                        when others =>
                                            output <= "01011110";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110111";
                                        when 1 =>
                                            output <= "01010010";
                                        when others =>
                                            output <= "10011010";
                                    end case;
                            end case;
                    end case;
                when 2 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10001000";
                                        when 1 =>
                                            output <= "00000100";
                                        when others =>
                                            output <= "11100111";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11011101";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "00001110";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011000";
                                        when 1 =>
                                            output <= "11100000";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "01011101";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01100011";
                                        when 1 =>
                                            output <= "10111101";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11000101";
                                        when 1 =>
                                            output <= "11000110";
                                        when others =>
                                            output <= "11011100";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10011100";
                                        when 1 =>
                                            output <= "01110111";
                                        when others =>
                                            output <= "00010000";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01001011";
                                        when 1 =>
                                            output <= "11100010";
                                        when others =>
                                            output <= "11010000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10110111";
                                        when 1 =>
                                            output <= "00011001";
                                        when others =>
                                            output <= "00110110";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11010110";
                                        when 1 =>
                                            output <= "00100110";
                                        when others =>
                                            output <= "10011100";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10101100";
                                        when 1 =>
                                            output <= "00010000";
                                        when others =>
                                            output <= "11000010";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11000111";
                                        when 1 =>
                                            output <= "11011101";
                                        when others =>
                                            output <= "01110000";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110010";
                                        when 1 =>
                                            output <= "01000111";
                                        when others =>
                                            output <= "00011000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10111011";
                                        when 1 =>
                                            output <= "10100000";
                                        when others =>
                                            output <= "11010001";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011011";
                                        when 1 =>
                                            output <= "11000000";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110110";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "00111101";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011011";
                                        when 1 =>
                                            output <= "10110011";
                                        when others =>
                                            output <= "10011100";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00100000";
                                        when 1 =>
                                            output <= "00001011";
                                        when others =>
                                            output <= "11011101";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001010";
                                        when 1 =>
                                            output <= "00110010";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10100010";
                                        when 1 =>
                                            output <= "10110100";
                                        when others =>
                                            output <= "11001111";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "00100000";
                                        when others =>
                                            output <= "01101011";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01010101";
                                        when 1 =>
                                            output <= "00010101";
                                        when others =>
                                            output <= "00001101";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001001";
                                        when 1 =>
                                            output <= "01110000";
                                        when others =>
                                            output <= "00100000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000101";
                                        when 1 =>
                                            output <= "10100000";
                                        when others =>
                                            output <= "01101111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01101101";
                                        when 1 =>
                                            output <= "10000110";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                            end case;
                    end case;
                when 3 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000111";
                                        when 1 =>
                                            output <= "00001001";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00100010";
                                        when 1 =>
                                            output <= "11010101";
                                        when others =>
                                            output <= "00001110";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011000";
                                        when 1 =>
                                            output <= "01011111";
                                        when others =>
                                            output <= "11110001";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01100011";
                                        when 1 =>
                                            output <= "00101100";
                                        when others =>
                                            output <= "00110111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00111010";
                                        when 1 =>
                                            output <= "00010110";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11001101";
                                        when 1 =>
                                            output <= "01011101";
                                        when others =>
                                            output <= "00011100";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111100";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "01110101";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011001";
                                        when 1 =>
                                            output <= "10101011";
                                        when others =>
                                            output <= "01100101";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11011100";
                                        when 1 =>
                                            output <= "00010011";
                                        when others =>
                                            output <= "11011011";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "00110101";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "11111000";
                                        when others =>
                                            output <= "01100100";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "11010001";
                                        when others =>
                                            output <= "00001110";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000011";
                                        when 1 =>
                                            output <= "11101110";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000010";
                                        when 1 =>
                                            output <= "11001101";
                                        when others =>
                                            output <= "10011100";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00100000";
                                        when 1 =>
                                            output <= "00000100";
                                        when others =>
                                            output <= "00000001";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10110000";
                                        when 1 =>
                                            output <= "11001011";
                                        when others =>
                                            output <= "11001000";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10110101";
                                        when 1 =>
                                            output <= "10101000";
                                        when others =>
                                            output <= "00110000";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11000010";
                                        when 1 =>
                                            output <= "00111101";
                                        when others =>
                                            output <= "10111001";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "10001010";
                                        when others =>
                                            output <= "00010000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110001";
                                        when 1 =>
                                            output <= "01110001";
                                        when others =>
                                            output <= "01110100";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01011100";
                                        when 1 =>
                                            output <= "00011001";
                                        when others =>
                                            output <= "11001101";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10101101";
                                        when 1 =>
                                            output <= "11100100";
                                        when others =>
                                            output <= "11110010";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011000";
                                        when 1 =>
                                            output <= "11100011";
                                        when others =>
                                            output <= "11011101";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000100";
                                        when 1 =>
                                            output <= "00011010";
                                        when others =>
                                            output <= "11110100";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "00111111";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                            end case;
                    end case;
                when 4 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11011111";
                                        when 1 =>
                                            output <= "10100010";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010010";
                                        when 1 =>
                                            output <= "10111111";
                                        when others =>
                                            output <= "01001011";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11011010";
                                        when 1 =>
                                            output <= "01101000";
                                        when others =>
                                            output <= "11011011";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101110";
                                        when 1 =>
                                            output <= "01101011";
                                        when others =>
                                            output <= "00111001";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00101001";
                                        when 1 =>
                                            output <= "00010100";
                                        when others =>
                                            output <= "10011111";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01100000";
                                        when 1 =>
                                            output <= "01100010";
                                        when others =>
                                            output <= "00100011";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "01110011";
                                        when others =>
                                            output <= "11010100";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11000000";
                                        when 1 =>
                                            output <= "11101111";
                                        when others =>
                                            output <= "11111010";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "01010110";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10101001";
                                        when 1 =>
                                            output <= "11011010";
                                        when others =>
                                            output <= "00100101";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010111";
                                        when 1 =>
                                            output <= "01101101";
                                        when others =>
                                            output <= "00101010";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00101100";
                                        when 1 =>
                                            output <= "00010111";
                                        when others =>
                                            output <= "11011001";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101100";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "11101011";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10111110";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "11110101";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01001011";
                                        when 1 =>
                                            output <= "00000111";
                                        when others =>
                                            output <= "10111010";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101011";
                                        when 1 =>
                                            output <= "11111101";
                                        when others =>
                                            output <= "11100001";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110001";
                                        when 1 =>
                                            output <= "01010111";
                                        when others =>
                                            output <= "10100011";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000000";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "00000110";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001001";
                                        when 1 =>
                                            output <= "11100010";
                                        when others =>
                                            output <= "11111010";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101001";
                                        when 1 =>
                                            output <= "00011010";
                                        when others =>
                                            output <= "11001011";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01011100";
                                        when 1 =>
                                            output <= "00101101";
                                        when others =>
                                            output <= "01010110";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "01101101";
                                        when others =>
                                            output <= "10011100";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00100110";
                                        when 1 =>
                                            output <= "00010010";
                                        when others =>
                                            output <= "00011111";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "01111110";
                                        when others =>
                                            output <= "10010111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01011001";
                                        when 1 =>
                                            output <= "00000000";
                                        when others =>
                                            output <= "01001001";
                                    end case;
                            end case;
                    end case;
                when 5 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10101101";
                                        when 1 =>
                                            output <= "00011100";
                                        when others =>
                                            output <= "11011110";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10010000";
                                        when 1 =>
                                            output <= "00111000";
                                        when others =>
                                            output <= "11110100";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00100000";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "00010001";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00101011";
                                        when 1 =>
                                            output <= "11000100";
                                        when others =>
                                            output <= "10111000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10010011";
                                        when 1 =>
                                            output <= "11010110";
                                        when others =>
                                            output <= "11001000";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11100110";
                                        when 1 =>
                                            output <= "00111100";
                                        when others =>
                                            output <= "10011101";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11000101";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "11100001";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010001";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110110";
                                        when 1 =>
                                            output <= "00000011";
                                        when others =>
                                            output <= "11011100";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000011";
                                        when 1 =>
                                            output <= "11001110";
                                        when others =>
                                            output <= "01100101";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01001101";
                                        when 1 =>
                                            output <= "11111001";
                                        when others =>
                                            output <= "00010111";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "01010100";
                                        when others =>
                                            output <= "00100010";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "01100011";
                                        when others =>
                                            output <= "11100001";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000001";
                                        when 1 =>
                                            output <= "11110010";
                                        when others =>
                                            output <= "01100111";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10011010";
                                        when 1 =>
                                            output <= "00101001";
                                        when others =>
                                            output <= "00001100";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "10101111";
                                        when others =>
                                            output <= "10010001";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "00111100";
                                        when others =>
                                            output <= "11100110";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "11001011";
                                        when others =>
                                            output <= "10110100";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11000010";
                                        when 1 =>
                                            output <= "10100100";
                                        when others =>
                                            output <= "00101100";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11000010";
                                        when 1 =>
                                            output <= "11110001";
                                        when others =>
                                            output <= "00011011";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10100000";
                                        when 1 =>
                                            output <= "00000101";
                                        when others =>
                                            output <= "00001011";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00100000";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "10101101";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111011";
                                        when 1 =>
                                            output <= "11100111";
                                        when others =>
                                            output <= "11000111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010111";
                                        when 1 =>
                                            output <= "01100000";
                                        when others =>
                                            output <= "00000000";
                                    end case;
                            end case;
                    end case;
                when 6 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11001000";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "01000101";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01010100";
                                        when 1 =>
                                            output <= "01011110";
                                        when others =>
                                            output <= "10110111";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101011";
                                        when 1 =>
                                            output <= "00111110";
                                        when others =>
                                            output <= "10001100";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "00101001";
                                        when others =>
                                            output <= "00011100";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "11011110";
                                        when others =>
                                            output <= "10110100";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11011101";
                                        when 1 =>
                                            output <= "10001111";
                                        when others =>
                                            output <= "11111011";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00100010";
                                        when 1 =>
                                            output <= "00111100";
                                        when others =>
                                            output <= "01001111";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000010";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "10001001";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10111010";
                                        when 1 =>
                                            output <= "10110011";
                                        when others =>
                                            output <= "00001011";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101110";
                                        when 1 =>
                                            output <= "10101011";
                                        when others =>
                                            output <= "00000101";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010010";
                                        when 1 =>
                                            output <= "00111010";
                                        when others =>
                                            output <= "11000110";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "00111000";
                                        when others =>
                                            output <= "11101111";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11100001";
                                        when 1 =>
                                            output <= "00011001";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01000011";
                                        when 1 =>
                                            output <= "10011001";
                                        when others =>
                                            output <= "11110011";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11011011";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "00111100";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01001110";
                                        when 1 =>
                                            output <= "00110101";
                                        when others =>
                                            output <= "01000010";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01000011";
                                        when 1 =>
                                            output <= "00011100";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00101100";
                                        when 1 =>
                                            output <= "00000001";
                                        when others =>
                                            output <= "10011001";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011111";
                                        when 1 =>
                                            output <= "01011011";
                                        when others =>
                                            output <= "00010000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10110111";
                                        when 1 =>
                                            output <= "00100000";
                                        when others =>
                                            output <= "11011000";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01100010";
                                        when 1 =>
                                            output <= "01100110";
                                        when others =>
                                            output <= "00000111";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110111";
                                        when 1 =>
                                            output <= "01101111";
                                        when others =>
                                            output <= "00100000";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001111";
                                        when 1 =>
                                            output <= "11010000";
                                        when others =>
                                            output <= "10111110";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001011";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "11011110";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101101";
                                        when 1 =>
                                            output <= "00001000";
                                        when others =>
                                            output <= "00010110";
                                    end case;
                            end case;
                    end case;
                when 7 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11011101";
                                        when 1 =>
                                            output <= "11001110";
                                        when others =>
                                            output <= "11101010";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001101";
                                        when 1 =>
                                            output <= "01000001";
                                        when others =>
                                            output <= "10111001";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111111";
                                        when 1 =>
                                            output <= "01001001";
                                        when others =>
                                            output <= "11110001";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01110001";
                                        when 1 =>
                                            output <= "11001100";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111011";
                                        when 1 =>
                                            output <= "00000100";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01101011";
                                        when 1 =>
                                            output <= "00001100";
                                        when others =>
                                            output <= "11011010";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "01000000";
                                        when others =>
                                            output <= "01111011";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000000";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "00101111";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01000111";
                                        when 1 =>
                                            output <= "00101000";
                                        when others =>
                                            output <= "10010001";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110010";
                                        when 1 =>
                                            output <= "00111110";
                                        when others =>
                                            output <= "11011110";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001010";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "00000001";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10101010";
                                        when 1 =>
                                            output <= "10010111";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01110100";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "01001110";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000101";
                                        when 1 =>
                                            output <= "01011001";
                                        when others =>
                                            output <= "00101000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111001";
                                        when 1 =>
                                            output <= "01011010";
                                        when others =>
                                            output <= "11011010";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11000011";
                                        when 1 =>
                                            output <= "00000110";
                                        when others =>
                                            output <= "11100001";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10101000";
                                        when 1 =>
                                            output <= "01100110";
                                        when others =>
                                            output <= "00011101";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101010";
                                        when 1 =>
                                            output <= "11011111";
                                        when others =>
                                            output <= "11001010";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01001111";
                                        when 1 =>
                                            output <= "11101000";
                                        when others =>
                                            output <= "00011110";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000000";
                                        when 1 =>
                                            output <= "11110100";
                                        when others =>
                                            output <= "00000110";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01001010";
                                        when 1 =>
                                            output <= "01011110";
                                        when others =>
                                            output <= "10100101";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01010010";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "11001111";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110100";
                                        when 1 =>
                                            output <= "11110000";
                                        when others =>
                                            output <= "10011011";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001011";
                                        when 1 =>
                                            output <= "00000011";
                                        when others =>
                                            output <= "10010000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11001010";
                                        when 1 =>
                                            output <= "10111000";
                                        when others =>
                                            output <= "11001101";
                                    end case;
                            end case;
                    end case;
                when 8 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "11001111";
                                        when others =>
                                            output <= "11000110";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10110101";
                                        when 1 =>
                                            output <= "11101001";
                                        when others =>
                                            output <= "10010011";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000010";
                                        when 1 =>
                                            output <= "11010000";
                                        when others =>
                                            output <= "10001001";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101001";
                                        when 1 =>
                                            output <= "00110111";
                                        when others =>
                                            output <= "00100011";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "10110100";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10011111";
                                        when 1 =>
                                            output <= "01010110";
                                        when others =>
                                            output <= "00110110";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "11001001";
                                        when others =>
                                            output <= "01011010";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01100100";
                                        when 1 =>
                                            output <= "10100011";
                                        when others =>
                                            output <= "00101101";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11011011";
                                        when 1 =>
                                            output <= "01110011";
                                        when others =>
                                            output <= "11101011";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01100011";
                                        when 1 =>
                                            output <= "10101010";
                                        when others =>
                                            output <= "11001111";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000011";
                                        when 1 =>
                                            output <= "00000010";
                                        when others =>
                                            output <= "10011011";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00100110";
                                        when 1 =>
                                            output <= "00000000";
                                        when others =>
                                            output <= "11000001";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10110000";
                                        when 1 =>
                                            output <= "11001110";
                                        when others =>
                                            output <= "11100110";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010101";
                                        when 1 =>
                                            output <= "11111000";
                                        when others =>
                                            output <= "11011111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110010";
                                        when 1 =>
                                            output <= "01011111";
                                        when others =>
                                            output <= "00001111";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "10110111";
                                        when others =>
                                            output <= "00010010";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111010";
                                        when 1 =>
                                            output <= "00000000";
                                        when others =>
                                            output <= "01001011";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "01000110";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111001";
                                        when 1 =>
                                            output <= "00001100";
                                        when others =>
                                            output <= "01000111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110101";
                                        when 1 =>
                                            output <= "10100101";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11010011";
                                        when 1 =>
                                            output <= "00110001";
                                        when others =>
                                            output <= "11000011";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "10010110";
                                        when others =>
                                            output <= "00000000";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00101001";
                                        when 1 =>
                                            output <= "10000111";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "01000000";
                                        when others =>
                                            output <= "11010111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "01100010";
                                        when others =>
                                            output <= "10011100";
                                    end case;
                            end case;
                    end case;
                when 9 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11000101";
                                        when 1 =>
                                            output <= "10011110";
                                        when others =>
                                            output <= "11000010";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "00100110";
                                        when others =>
                                            output <= "11011010";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01010110";
                                        when 1 =>
                                            output <= "00000011";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101010";
                                        when 1 =>
                                            output <= "10010101";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000000";
                                        when 1 =>
                                            output <= "10001000";
                                        when others =>
                                            output <= "00010111";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10010001";
                                        when 1 =>
                                            output <= "00111110";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10001011";
                                        when 1 =>
                                            output <= "11110110";
                                        when others =>
                                            output <= "11001100";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "00110100";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01100100";
                                        when 1 =>
                                            output <= "11100111";
                                        when others =>
                                            output <= "01011010";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "10110110";
                                        when others =>
                                            output <= "01011001";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "11000100";
                                        when others =>
                                            output <= "10011101";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11000001";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "10101011";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010111";
                                        when 1 =>
                                            output <= "00110111";
                                        when others =>
                                            output <= "01001000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01001100";
                                        when 1 =>
                                            output <= "00001111";
                                        when others =>
                                            output <= "11100101";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010101";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "10110100";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110001";
                                        when 1 =>
                                            output <= "00010001";
                                        when others =>
                                            output <= "00111110";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000000";
                                        when 1 =>
                                            output <= "01000001";
                                        when others =>
                                            output <= "00001001";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000111";
                                        when 1 =>
                                            output <= "10111101";
                                        when others =>
                                            output <= "11111011";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01101100";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110110";
                                        when 1 =>
                                            output <= "11101101";
                                        when others =>
                                            output <= "10111001";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010100";
                                        when 1 =>
                                            output <= "01000101";
                                        when others =>
                                            output <= "01111011";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "11111111";
                                        when others =>
                                            output <= "00001110";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101111";
                                        when 1 =>
                                            output <= "10100111";
                                        when others =>
                                            output <= "00001111";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10101011";
                                        when 1 =>
                                            output <= "10100001";
                                        when others =>
                                            output <= "11111001";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "00010000";
                                        when others =>
                                            output <= "00000101";
                                    end case;
                            end case;
                    end case;
                when 10 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00111000";
                                        when 1 =>
                                            output <= "00000001";
                                        when others =>
                                            output <= "01001101";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10100101";
                                        when 1 =>
                                            output <= "00011100";
                                        when others =>
                                            output <= "00001100";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10110101";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "11101101";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101010";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "01101100";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00101011";
                                        when 1 =>
                                            output <= "10110000";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110010";
                                        when 1 =>
                                            output <= "00101110";
                                        when others =>
                                            output <= "00111100";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11001101";
                                        when 1 =>
                                            output <= "01001001";
                                        when others =>
                                            output <= "01001100";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001100";
                                        when 1 =>
                                            output <= "01011000";
                                        when others =>
                                            output <= "00011100";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10011111";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "11111101";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00100101";
                                        when 1 =>
                                            output <= "01010000";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "01001000";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001101";
                                        when 1 =>
                                            output <= "00001110";
                                        when others =>
                                            output <= "00110011";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000111";
                                        when 1 =>
                                            output <= "11110101";
                                        when others =>
                                            output <= "11011011";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110110";
                                        when 1 =>
                                            output <= "11111100";
                                        when others =>
                                            output <= "11101000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110111";
                                        when 1 =>
                                            output <= "00110100";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111101";
                                        when 1 =>
                                            output <= "01000000";
                                        when others =>
                                            output <= "00110111";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01000000";
                                        when 1 =>
                                            output <= "11001010";
                                        when others =>
                                            output <= "01010000";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01000111";
                                        when 1 =>
                                            output <= "11100000";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101010";
                                        when 1 =>
                                            output <= "11001011";
                                        when others =>
                                            output <= "10111111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10110110";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00101101";
                                        when 1 =>
                                            output <= "10100011";
                                        when others =>
                                            output <= "11101100";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010110";
                                        when 1 =>
                                            output <= "00001110";
                                        when others =>
                                            output <= "00000101";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001000";
                                        when 1 =>
                                            output <= "00111011";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000100";
                                        when 1 =>
                                            output <= "00001001";
                                        when others =>
                                            output <= "10011011";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11001101";
                                        when 1 =>
                                            output <= "11111110";
                                        when others =>
                                            output <= "10001110";
                                    end case;
                            end case;
                    end case;
                when 11 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "01100001";
                                        when others =>
                                            output <= "01010110";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11100100";
                                        when 1 =>
                                            output <= "00001001";
                                        when others =>
                                            output <= "00000111";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111000";
                                        when 1 =>
                                            output <= "00001011";
                                        when others =>
                                            output <= "10111001";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00111101";
                                        when 1 =>
                                            output <= "10001100";
                                        when others =>
                                            output <= "01100111";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11010010";
                                        when 1 =>
                                            output <= "01010111";
                                        when others =>
                                            output <= "00101011";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "11110101";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "01101000";
                                        when others =>
                                            output <= "11100101";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000101";
                                        when 1 =>
                                            output <= "00100010";
                                        when others =>
                                            output <= "11100010";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11010011";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "01011001";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10111111";
                                        when 1 =>
                                            output <= "11000011";
                                        when others =>
                                            output <= "00111111";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001101";
                                        when 1 =>
                                            output <= "11110110";
                                        when others =>
                                            output <= "11010101";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000000";
                                        when 1 =>
                                            output <= "11111000";
                                        when others =>
                                            output <= "11111011";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110010";
                                        when 1 =>
                                            output <= "01100100";
                                        when others =>
                                            output <= "00010110";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11000100";
                                        when 1 =>
                                            output <= "11101100";
                                        when others =>
                                            output <= "00011001";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110111";
                                        when 1 =>
                                            output <= "01101000";
                                        when others =>
                                            output <= "11111001";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "11001011";
                                        when others =>
                                            output <= "00001111";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "11111110";
                                        when others =>
                                            output <= "01101111";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "10100100";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "01010100";
                                        when others =>
                                            output <= "01101010";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11011111";
                                        when 1 =>
                                            output <= "11101100";
                                        when others =>
                                            output <= "11100001";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01110001";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "00100011";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "11111011";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11010111";
                                        when 1 =>
                                            output <= "10111101";
                                        when others =>
                                            output <= "00000111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11001001";
                                        when 1 =>
                                            output <= "11100111";
                                        when others =>
                                            output <= "11101001";
                                    end case;
                            end case;
                    end case;
                when 12 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10110000";
                                        when 1 =>
                                            output <= "10000010";
                                        when others =>
                                            output <= "00110011";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11011100";
                                        when 1 =>
                                            output <= "11011010";
                                        when others =>
                                            output <= "11010011";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01010001";
                                        when 1 =>
                                            output <= "10110010";
                                        when others =>
                                            output <= "11111110";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01010010";
                                        when 1 =>
                                            output <= "10110100";
                                        when others =>
                                            output <= "11111001";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01010011";
                                        when 1 =>
                                            output <= "11001011";
                                        when others =>
                                            output <= "10011101";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110010";
                                        when 1 =>
                                            output <= "00010100";
                                        when others =>
                                            output <= "11010001";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10100001";
                                        when 1 =>
                                            output <= "00010010";
                                        when others =>
                                            output <= "10111111";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111001";
                                        when 1 =>
                                            output <= "01010000";
                                        when others =>
                                            output <= "11110000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11010110";
                                        when 1 =>
                                            output <= "00010000";
                                        when others =>
                                            output <= "01000011";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110111";
                                        when 1 =>
                                            output <= "11000011";
                                        when others =>
                                            output <= "01101100";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010001";
                                        when 1 =>
                                            output <= "11110111";
                                        when others =>
                                            output <= "01010000";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001001";
                                        when 1 =>
                                            output <= "00000111";
                                        when others =>
                                            output <= "11100100";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01000010";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "00100011";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000011";
                                        when 1 =>
                                            output <= "10110001";
                                        when others =>
                                            output <= "00011100";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101010";
                                        when 1 =>
                                            output <= "00110000";
                                        when others =>
                                            output <= "10010100";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111011";
                                        when 1 =>
                                            output <= "11001111";
                                        when others =>
                                            output <= "11100000";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "00011101";
                                        when others =>
                                            output <= "11010001";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011000";
                                        when 1 =>
                                            output <= "01010011";
                                        when others =>
                                            output <= "11110000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110101";
                                        when 1 =>
                                            output <= "01100110";
                                        when others =>
                                            output <= "01000010";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "10010001";
                                        when others =>
                                            output <= "11111010";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00100101";
                                        when 1 =>
                                            output <= "00011101";
                                        when others =>
                                            output <= "01000111";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00101000";
                                        when 1 =>
                                            output <= "00001010";
                                        when others =>
                                            output <= "00000110";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101011";
                                        when 1 =>
                                            output <= "01110000";
                                        when others =>
                                            output <= "11101010";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110000";
                                        when 1 =>
                                            output <= "01001111";
                                        when others =>
                                            output <= "11101110";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000011";
                                        when 1 =>
                                            output <= "00000101";
                                        when others =>
                                            output <= "00111111";
                                    end case;
                            end case;
                    end case;
                when 13 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101001";
                                        when 1 =>
                                            output <= "00101010";
                                        when others =>
                                            output <= "00000100";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00101001";
                                        when 1 =>
                                            output <= "00100011";
                                        when others =>
                                            output <= "11101101";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010000";
                                        when 1 =>
                                            output <= "11101110";
                                        when others =>
                                            output <= "00011111";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01100011";
                                        when 1 =>
                                            output <= "01111001";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11100011";
                                        when 1 =>
                                            output <= "00111110";
                                        when others =>
                                            output <= "10101010";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10110000";
                                        when 1 =>
                                            output <= "01100101";
                                        when others =>
                                            output <= "10110111";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001000";
                                        when 1 =>
                                            output <= "00101011";
                                        when others =>
                                            output <= "00100010";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11000101";
                                        when 1 =>
                                            output <= "11100100";
                                        when others =>
                                            output <= "00000100";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "11100010";
                                        when others =>
                                            output <= "11111001";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10101111";
                                        when 1 =>
                                            output <= "11101010";
                                        when others =>
                                            output <= "01101111";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01001100";
                                        when 1 =>
                                            output <= "00100111";
                                        when others =>
                                            output <= "11011001";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10111100";
                                        when 1 =>
                                            output <= "00100110";
                                        when others =>
                                            output <= "11001101";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10011100";
                                        when 1 =>
                                            output <= "10010000";
                                        when others =>
                                            output <= "11111111";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011000";
                                        when 1 =>
                                            output <= "00000001";
                                        when others =>
                                            output <= "00001011";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010011";
                                        when 1 =>
                                            output <= "11100111";
                                        when others =>
                                            output <= "00110010";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110000";
                                        when 1 =>
                                            output <= "11000100";
                                        when others =>
                                            output <= "11100001";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010001";
                                        when 1 =>
                                            output <= "00101000";
                                        when others =>
                                            output <= "11100010";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000111";
                                        when 1 =>
                                            output <= "10001110";
                                        when others =>
                                            output <= "00010110";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001000";
                                        when 1 =>
                                            output <= "00010100";
                                        when others =>
                                            output <= "01101001";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111101";
                                        when 1 =>
                                            output <= "10111110";
                                        when others =>
                                            output <= "01101000";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10010000";
                                        when 1 =>
                                            output <= "11000100";
                                        when others =>
                                            output <= "11101111";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111010";
                                        when 1 =>
                                            output <= "00101000";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00101010";
                                        when 1 =>
                                            output <= "01110100";
                                        when others =>
                                            output <= "10101100";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110011";
                                        when 1 =>
                                            output <= "11001011";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010011";
                                        when 1 =>
                                            output <= "11110110";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                            end case;
                    end case;
                when 14 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010000";
                                        when 1 =>
                                            output <= "00111100";
                                        when others =>
                                            output <= "00011101";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110010";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "01101010";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11000000";
                                        when 1 =>
                                            output <= "00111001";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111010";
                                        when 1 =>
                                            output <= "00101110";
                                        when others =>
                                            output <= "00100011";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11100110";
                                        when 1 =>
                                            output <= "10110100";
                                        when others =>
                                            output <= "01110001";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11011001";
                                        when 1 =>
                                            output <= "00010010";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010101";
                                        when 1 =>
                                            output <= "01001110";
                                        when others =>
                                            output <= "01011111";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101010";
                                        when 1 =>
                                            output <= "10010110";
                                        when others =>
                                            output <= "11010110";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010110";
                                        when 1 =>
                                            output <= "01100001";
                                        when others =>
                                            output <= "00111101";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010000";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "01110001";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "00000011";
                                        when others =>
                                            output <= "00111100";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010010";
                                        when 1 =>
                                            output <= "00000011";
                                        when others =>
                                            output <= "01111001";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "11001100";
                                        when others =>
                                            output <= "01010101";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011011";
                                        when 1 =>
                                            output <= "11001101";
                                        when others =>
                                            output <= "01010010";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "10101010";
                                        when others =>
                                            output <= "11010101";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11100011";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "00011111";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00111011";
                                        when 1 =>
                                            output <= "00101111";
                                        when others =>
                                            output <= "10100010";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00101100";
                                        when 1 =>
                                            output <= "01100110";
                                        when others =>
                                            output <= "00111010";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000100";
                                        when 1 =>
                                            output <= "10111000";
                                        when others =>
                                            output <= "01001001";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "11100100";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01011010";
                                        when 1 =>
                                            output <= "01000010";
                                        when others =>
                                            output <= "10001111";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11010000";
                                        when 1 =>
                                            output <= "11000111";
                                        when others =>
                                            output <= "00111110";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10010011";
                                        when 1 =>
                                            output <= "00000011";
                                        when others =>
                                            output <= "00101111";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000000";
                                        when 1 =>
                                            output <= "11101001";
                                        when others =>
                                            output <= "11110101";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110000";
                                        when 1 =>
                                            output <= "00100110";
                                        when others =>
                                            output <= "00001110";
                                    end case;
                            end case;
                    end case;
                when 15 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11001010";
                                        when 1 =>
                                            output <= "10110110";
                                        when others =>
                                            output <= "00100001";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "11100000";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01011110";
                                        when 1 =>
                                            output <= "00001100";
                                        when others =>
                                            output <= "11011101";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "01101111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001011";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "00001100";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00100001";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "10010000";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01010101";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "11010110";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11010010";
                                        when 1 =>
                                            output <= "01001000";
                                        when others =>
                                            output <= "01001111";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11001110";
                                        when 1 =>
                                            output <= "11100011";
                                        when others =>
                                            output <= "11001101";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110001";
                                        when 1 =>
                                            output <= "01111001";
                                        when others =>
                                            output <= "10011011";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10010101";
                                        when 1 =>
                                            output <= "11111110";
                                        when others =>
                                            output <= "01000000";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "01010000";
                                        when others =>
                                            output <= "11101001";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000011";
                                        when 1 =>
                                            output <= "11110011";
                                        when others =>
                                            output <= "11100011";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10001100";
                                        when 1 =>
                                            output <= "00010111";
                                        when others =>
                                            output <= "00010010";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00101101";
                                        when 1 =>
                                            output <= "11110111";
                                        when others =>
                                            output <= "11100011";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000000";
                                        when 1 =>
                                            output <= "01011111";
                                        when others =>
                                            output <= "10100110";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "00110101";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11000001";
                                        when 1 =>
                                            output <= "11001101";
                                        when others =>
                                            output <= "11001000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10100100";
                                        when 1 =>
                                            output <= "00000000";
                                        when others =>
                                            output <= "00011101";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10001000";
                                        when 1 =>
                                            output <= "00110111";
                                        when others =>
                                            output <= "10010100";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01110111";
                                        when 1 =>
                                            output <= "11001101";
                                        when others =>
                                            output <= "00010100";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00100100";
                                        when 1 =>
                                            output <= "01101101";
                                        when others =>
                                            output <= "00001110";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10010111";
                                        when 1 =>
                                            output <= "11001101";
                                        when others =>
                                            output <= "10000001";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01001101";
                                        when 1 =>
                                            output <= "00001001";
                                        when others =>
                                            output <= "01001101";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01100101";
                                        when 1 =>
                                            output <= "11000000";
                                        when others =>
                                            output <= "00100000";
                                    end case;
                            end case;
                    end case;
                when 16 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11001000";
                                        when 1 =>
                                            output <= "11001001";
                                        when others =>
                                            output <= "11101011";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01000010";
                                        when 1 =>
                                            output <= "00010110";
                                        when others =>
                                            output <= "00010000";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10011101";
                                        when 1 =>
                                            output <= "11010110";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011000";
                                        when 1 =>
                                            output <= "01001101";
                                        when others =>
                                            output <= "00010100";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000011";
                                        when 1 =>
                                            output <= "01100111";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001100";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "11010010";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001110";
                                        when 1 =>
                                            output <= "01101011";
                                        when others =>
                                            output <= "11111010";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001100";
                                        when 1 =>
                                            output <= "00010001";
                                        when others =>
                                            output <= "10001000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "01100101";
                                        when others =>
                                            output <= "00111110";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "10100100";
                                        when others =>
                                            output <= "00001010";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10101101";
                                        when 1 =>
                                            output <= "11100100";
                                        when others =>
                                            output <= "00011001";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000011";
                                        when 1 =>
                                            output <= "00101001";
                                        when others =>
                                            output <= "11110011";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101101";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "01010000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01110010";
                                        when 1 =>
                                            output <= "10010001";
                                        when others =>
                                            output <= "00110011";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "00000000";
                                        when others =>
                                            output <= "10011010";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11011110";
                                        when 1 =>
                                            output <= "10100001";
                                        when others =>
                                            output <= "00001101";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10111001";
                                        when 1 =>
                                            output <= "11111101";
                                        when others =>
                                            output <= "10100101";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "01000101";
                                        when others =>
                                            output <= "11111110";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10010101";
                                        when 1 =>
                                            output <= "00001100";
                                        when others =>
                                            output <= "11101000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110110";
                                        when 1 =>
                                            output <= "10110110";
                                        when others =>
                                            output <= "00101001";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111100";
                                        when 1 =>
                                            output <= "00110001";
                                        when others =>
                                            output <= "10110111";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101111";
                                        when 1 =>
                                            output <= "11010111";
                                        when others =>
                                            output <= "00110010";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110010";
                                        when 1 =>
                                            output <= "11011110";
                                        when others =>
                                            output <= "11011010";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "00100011";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01001101";
                                        when 1 =>
                                            output <= "11011001";
                                        when others =>
                                            output <= "00001010";
                                    end case;
                            end case;
                    end case;
                when 17 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110010";
                                        when 1 =>
                                            output <= "01011101";
                                        when others =>
                                            output <= "10110101";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01011110";
                                        when 1 =>
                                            output <= "01101010";
                                        when others =>
                                            output <= "00001101";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11000000";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "01001100";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11010110";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "00000101";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10010001";
                                        when 1 =>
                                            output <= "01010010";
                                        when others =>
                                            output <= "11000100";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10110101";
                                        when 1 =>
                                            output <= "10011000";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "01011010";
                                        when others =>
                                            output <= "11100110";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010010";
                                        when 1 =>
                                            output <= "11111101";
                                        when others =>
                                            output <= "01001100";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01000011";
                                        when 1 =>
                                            output <= "11000011";
                                        when others =>
                                            output <= "00110111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01001010";
                                        when 1 =>
                                            output <= "00110110";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110000";
                                        when 1 =>
                                            output <= "11000101";
                                        when others =>
                                            output <= "00111110";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011110";
                                        when 1 =>
                                            output <= "11011000";
                                        when others =>
                                            output <= "11101010";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01011001";
                                        when 1 =>
                                            output <= "00000001";
                                        when others =>
                                            output <= "11111010";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111000";
                                        when 1 =>
                                            output <= "11011001";
                                        when others =>
                                            output <= "00101010";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110001";
                                        when 1 =>
                                            output <= "10001001";
                                        when others =>
                                            output <= "11111000";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001000";
                                        when 1 =>
                                            output <= "10011001";
                                        when others =>
                                            output <= "01010011";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000111";
                                        when 1 =>
                                            output <= "00010000";
                                        when others =>
                                            output <= "00101000";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "11111101";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00101000";
                                        when 1 =>
                                            output <= "01010100";
                                        when others =>
                                            output <= "10101001";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00100001";
                                        when 1 =>
                                            output <= "00111101";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01110110";
                                        when 1 =>
                                            output <= "10110011";
                                        when others =>
                                            output <= "11101110";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "11010111";
                                        when others =>
                                            output <= "00111011";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11100111";
                                        when 1 =>
                                            output <= "00001010";
                                        when others =>
                                            output <= "11001001";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11100110";
                                        when 1 =>
                                            output <= "11000110";
                                        when others =>
                                            output <= "10010100";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11011001";
                                        when 1 =>
                                            output <= "10100011";
                                        when others =>
                                            output <= "11100111";
                                    end case;
                            end case;
                    end case;
                when 18 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111101";
                                        when 1 =>
                                            output <= "10110110";
                                        when others =>
                                            output <= "11110100";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101101";
                                        when 1 =>
                                            output <= "00001000";
                                        when others =>
                                            output <= "11001110";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "11110000";
                                        when others =>
                                            output <= "00101110";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10001011";
                                        when 1 =>
                                            output <= "11101011";
                                        when others =>
                                            output <= "00101111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10100001";
                                        when 1 =>
                                            output <= "10101000";
                                        when others =>
                                            output <= "01011101";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11011100";
                                        when 1 =>
                                            output <= "10111110";
                                        when others =>
                                            output <= "00011010";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101111";
                                        when 1 =>
                                            output <= "11100001";
                                        when others =>
                                            output <= "01110000";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110110";
                                        when 1 =>
                                            output <= "00001100";
                                        when others =>
                                            output <= "11100010";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111010";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "11110110";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00100101";
                                        when 1 =>
                                            output <= "00101100";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110111";
                                        when 1 =>
                                            output <= "10101001";
                                        when others =>
                                            output <= "11111101";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111000";
                                        when 1 =>
                                            output <= "10100101";
                                        when others =>
                                            output <= "10010111";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11100001";
                                        when 1 =>
                                            output <= "11010011";
                                        when others =>
                                            output <= "11100001";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01011000";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "01100110";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01001011";
                                        when 1 =>
                                            output <= "00001111";
                                        when others =>
                                            output <= "11111110";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "11101001";
                                        when others =>
                                            output <= "11111101";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01100000";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11100111";
                                        when 1 =>
                                            output <= "01010000";
                                        when others =>
                                            output <= "00110011";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011000";
                                        when 1 =>
                                            output <= "11110110";
                                        when others =>
                                            output <= "01001011";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "11011100";
                                        when others =>
                                            output <= "10010100";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "11111101";
                                        when others =>
                                            output <= "00010100";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11010011";
                                        when 1 =>
                                            output <= "10001000";
                                        when others =>
                                            output <= "01100100";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01000111";
                                        when 1 =>
                                            output <= "01001100";
                                        when others =>
                                            output <= "00010101";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01100100";
                                        when 1 =>
                                            output <= "11010000";
                                        when others =>
                                            output <= "11100100";
                                    end case;
                            end case;
                    end case;
                when 19 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10001101";
                                        when 1 =>
                                            output <= "11101111";
                                        when others =>
                                            output <= "01100100";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101000";
                                        when 1 =>
                                            output <= "11001101";
                                        when others =>
                                            output <= "11110010";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010101";
                                        when 1 =>
                                            output <= "00101110";
                                        when others =>
                                            output <= "11001100";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000100";
                                        when 1 =>
                                            output <= "01010000";
                                        when others =>
                                            output <= "01010110";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01001101";
                                        when 1 =>
                                            output <= "00100010";
                                        when others =>
                                            output <= "00110010";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111001";
                                        when 1 =>
                                            output <= "11000110";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "00000110";
                                        when others =>
                                            output <= "10011110";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011000";
                                        when 1 =>
                                            output <= "01011001";
                                        when others =>
                                            output <= "10111000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01101001";
                                        when 1 =>
                                            output <= "10110110";
                                        when others =>
                                            output <= "11101101";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11010011";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "10001101";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011100";
                                        when 1 =>
                                            output <= "01101111";
                                        when others =>
                                            output <= "11100110";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11100000";
                                        when 1 =>
                                            output <= "11001001";
                                        when others =>
                                            output <= "00100110";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00101101";
                                        when 1 =>
                                            output <= "10101010";
                                        when others =>
                                            output <= "00000000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11000011";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "00011010";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10111111";
                                        when 1 =>
                                            output <= "00101010";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011010";
                                        when 1 =>
                                            output <= "00100001";
                                        when others =>
                                            output <= "01010101";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "11101110";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110010";
                                        when 1 =>
                                            output <= "10110010";
                                        when others =>
                                            output <= "00001101";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11100110";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "11110101";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "11010011";
                                        when others =>
                                            output <= "11001011";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10001111";
                                        when 1 =>
                                            output <= "00001110";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11010000";
                                        when 1 =>
                                            output <= "01011110";
                                        when others =>
                                            output <= "11110000";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10100011";
                                        when 1 =>
                                            output <= "01000101";
                                        when others =>
                                            output <= "10010110";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00100001";
                                        when 1 =>
                                            output <= "11110010";
                                        when others =>
                                            output <= "10110100";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011110";
                                        when 1 =>
                                            output <= "10101111";
                                        when others =>
                                            output <= "00100111";
                                    end case;
                            end case;
                    end case;
                when 20 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01100111";
                                        when 1 =>
                                            output <= "11110101";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111011";
                                        when 1 =>
                                            output <= "10111111";
                                        when others =>
                                            output <= "10011110";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001101";
                                        when 1 =>
                                            output <= "10110011";
                                        when others =>
                                            output <= "00000010";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11001100";
                                        when 1 =>
                                            output <= "11101001";
                                        when others =>
                                            output <= "01100110";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01100110";
                                        when 1 =>
                                            output <= "01011100";
                                        when others =>
                                            output <= "11111100";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000110";
                                        when 1 =>
                                            output <= "01000101";
                                        when others =>
                                            output <= "10101101";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011101";
                                        when 1 =>
                                            output <= "01110001";
                                        when others =>
                                            output <= "11100001";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111011";
                                        when 1 =>
                                            output <= "11110011";
                                        when others =>
                                            output <= "11111000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10101011";
                                        when 1 =>
                                            output <= "11010101";
                                        when others =>
                                            output <= "00001110";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10100001";
                                        when 1 =>
                                            output <= "01000011";
                                        when others =>
                                            output <= "11000010";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "11001100";
                                        when others =>
                                            output <= "00110100";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "10110010";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "11111110";
                                        when others =>
                                            output <= "01011010";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010101";
                                        when 1 =>
                                            output <= "01000001";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010000";
                                        when 1 =>
                                            output <= "00111100";
                                        when others =>
                                            output <= "01010110";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10110101";
                                        when 1 =>
                                            output <= "11001001";
                                        when others =>
                                            output <= "00011000";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11100101";
                                        when 1 =>
                                            output <= "00011111";
                                        when others =>
                                            output <= "00010001";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "10111010";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "10100110";
                                        when others =>
                                            output <= "00000100";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011010";
                                        when 1 =>
                                            output <= "00111110";
                                        when others =>
                                            output <= "01001100";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10111111";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01011111";
                                        when 1 =>
                                            output <= "01110001";
                                        when others =>
                                            output <= "10011110";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000111";
                                        when 1 =>
                                            output <= "00001011";
                                        when others =>
                                            output <= "10100011";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000000";
                                        when 1 =>
                                            output <= "00010010";
                                        when others =>
                                            output <= "11011100";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11001111";
                                        when 1 =>
                                            output <= "11011000";
                                        when others =>
                                            output <= "01011000";
                                    end case;
                            end case;
                    end case;
                when 21 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111100";
                                        when 1 =>
                                            output <= "01000100";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00101101";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "10000101";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00100110";
                                        when 1 =>
                                            output <= "11000101";
                                        when others =>
                                            output <= "11101001";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110011";
                                        when 1 =>
                                            output <= "10100000";
                                        when others =>
                                            output <= "00000010";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111101";
                                        when 1 =>
                                            output <= "11110110";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00101100";
                                        when 1 =>
                                            output <= "11110000";
                                        when others =>
                                            output <= "00010001";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "00101111";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01010000";
                                        when 1 =>
                                            output <= "10101000";
                                        when others =>
                                            output <= "11111001";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10110110";
                                        when 1 =>
                                            output <= "01101101";
                                        when others =>
                                            output <= "11101101";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "00011010";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01110111";
                                        when 1 =>
                                            output <= "00100100";
                                        when others =>
                                            output <= "01001001";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011000";
                                        when 1 =>
                                            output <= "01100000";
                                        when others =>
                                            output <= "00101100";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11000000";
                                        when 1 =>
                                            output <= "10111000";
                                        when others =>
                                            output <= "10010101";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001100";
                                        when 1 =>
                                            output <= "11111000";
                                        when others =>
                                            output <= "10111010";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11011000";
                                        when 1 =>
                                            output <= "11110001";
                                        when others =>
                                            output <= "10101100";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "00110010";
                                        when others =>
                                            output <= "00111110";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110010";
                                        when 1 =>
                                            output <= "00001101";
                                        when others =>
                                            output <= "00010100";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01000010";
                                        when 1 =>
                                            output <= "01001100";
                                        when others =>
                                            output <= "01111001";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11000001";
                                        when 1 =>
                                            output <= "00101101";
                                        when others =>
                                            output <= "00100011";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "11011000";
                                        when others =>
                                            output <= "00011111";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011011";
                                        when 1 =>
                                            output <= "10000011";
                                        when others =>
                                            output <= "11100101";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "01011101";
                                        when others =>
                                            output <= "01010100";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110010";
                                        when 1 =>
                                            output <= "11111010";
                                        when others =>
                                            output <= "11110101";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00101000";
                                        when 1 =>
                                            output <= "01000011";
                                        when others =>
                                            output <= "01010011";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00101101";
                                        when 1 =>
                                            output <= "00011000";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                            end case;
                    end case;
                when 22 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110111";
                                        when 1 =>
                                            output <= "11010011";
                                        when others =>
                                            output <= "11101111";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00101101";
                                        when 1 =>
                                            output <= "01101011";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10110100";
                                        when 1 =>
                                            output <= "11010010";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00111111";
                                        when 1 =>
                                            output <= "01000110";
                                        when others =>
                                            output <= "00001111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "10100010";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00100101";
                                        when 1 =>
                                            output <= "11011011";
                                        when others =>
                                            output <= "00011011";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10001111";
                                        when 1 =>
                                            output <= "10100111";
                                        when others =>
                                            output <= "00101001";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10101100";
                                        when 1 =>
                                            output <= "01010011";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01101010";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000111";
                                        when 1 =>
                                            output <= "11100100";
                                        when others =>
                                            output <= "01110100";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "00001001";
                                        when others =>
                                            output <= "11011100";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010001";
                                        when 1 =>
                                            output <= "10110111";
                                        when others =>
                                            output <= "11111000";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101010";
                                        when 1 =>
                                            output <= "11000011";
                                        when others =>
                                            output <= "00010001";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01011000";
                                        when 1 =>
                                            output <= "10101000";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110000";
                                        when 1 =>
                                            output <= "00110011";
                                        when others =>
                                            output <= "10110001";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "01010001";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01010101";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "01111001";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01010101";
                                        when 1 =>
                                            output <= "00110010";
                                        when others =>
                                            output <= "00011011";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11100010";
                                        when 1 =>
                                            output <= "11000011";
                                        when others =>
                                            output <= "10000101";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10001110";
                                        when 1 =>
                                            output <= "11000100";
                                        when others =>
                                            output <= "10010001";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00100100";
                                        when 1 =>
                                            output <= "00101010";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01010100";
                                        when 1 =>
                                            output <= "01010110";
                                        when others =>
                                            output <= "00010110";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00100011";
                                        when 1 =>
                                            output <= "10011101";
                                        when others =>
                                            output <= "11100010";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101101";
                                        when 1 =>
                                            output <= "01110010";
                                        when others =>
                                            output <= "00011000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10001010";
                                        when 1 =>
                                            output <= "10000101";
                                        when others =>
                                            output <= "11110010";
                                    end case;
                            end case;
                    end case;
                when 23 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010101";
                                        when 1 =>
                                            output <= "00001000";
                                        when others =>
                                            output <= "01100001";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10101110";
                                        when 1 =>
                                            output <= "11100010";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000110";
                                        when 1 =>
                                            output <= "01000000";
                                        when others =>
                                            output <= "11011000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11010001";
                                        when 1 =>
                                            output <= "00000101";
                                        when others =>
                                            output <= "01000100";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10111000";
                                        when 1 =>
                                            output <= "11110010";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111000";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "10100101";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10111001";
                                        when 1 =>
                                            output <= "11101110";
                                        when others =>
                                            output <= "00011011";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010011";
                                        when 1 =>
                                            output <= "11110011";
                                        when others =>
                                            output <= "00000001";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001010";
                                        when 1 =>
                                            output <= "00001001";
                                        when others =>
                                            output <= "00000011";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11001010";
                                        when 1 =>
                                            output <= "11101000";
                                        when others =>
                                            output <= "00001010";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11001000";
                                        when 1 =>
                                            output <= "11011000";
                                        when others =>
                                            output <= "10111000";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01101110";
                                        when 1 =>
                                            output <= "11001011";
                                        when others =>
                                            output <= "01001010";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11010100";
                                        when 1 =>
                                            output <= "01101111";
                                        when others =>
                                            output <= "00110100";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000010";
                                        when 1 =>
                                            output <= "10110001";
                                        when others =>
                                            output <= "00110000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "11101001";
                                        when others =>
                                            output <= "11001111";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01000010";
                                        when 1 =>
                                            output <= "00001111";
                                        when others =>
                                            output <= "11010101";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101001";
                                        when 1 =>
                                            output <= "10100111";
                                        when others =>
                                            output <= "00000000";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110000";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "10011001";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11000100";
                                        when 1 =>
                                            output <= "00101100";
                                        when others =>
                                            output <= "10010010";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "10101000";
                                        when others =>
                                            output <= "10010110";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010101";
                                        when 1 =>
                                            output <= "00010001";
                                        when others =>
                                            output <= "00010001";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11100001";
                                        when 1 =>
                                            output <= "00001101";
                                        when others =>
                                            output <= "10100010";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01011111";
                                        when 1 =>
                                            output <= "00100000";
                                        when others =>
                                            output <= "01011001";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11011011";
                                        when 1 =>
                                            output <= "00011010";
                                        when others =>
                                            output <= "11100001";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101010";
                                        when 1 =>
                                            output <= "00110100";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                            end case;
                    end case;
                when 24 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00101111";
                                        when 1 =>
                                            output <= "00111110";
                                        when others =>
                                            output <= "11001111";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10111101";
                                        when 1 =>
                                            output <= "01001000";
                                        when others =>
                                            output <= "11111011";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10100100";
                                        when 1 =>
                                            output <= "01001000";
                                        when others =>
                                            output <= "11100001";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11011100";
                                        when 1 =>
                                            output <= "11001101";
                                        when others =>
                                            output <= "11100010";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01000001";
                                        when 1 =>
                                            output <= "11101000";
                                        when others =>
                                            output <= "00111011";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111111";
                                        when 1 =>
                                            output <= "10001110";
                                        when others =>
                                            output <= "11000101";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01001011";
                                        when 1 =>
                                            output <= "10000010";
                                        when others =>
                                            output <= "00110011";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001101";
                                        when 1 =>
                                            output <= "01000101";
                                        when others =>
                                            output <= "01101100";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101100";
                                        when 1 =>
                                            output <= "10001100";
                                        when others =>
                                            output <= "00011011";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11100000";
                                        when 1 =>
                                            output <= "11010010";
                                        when others =>
                                            output <= "00000011";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10010100";
                                        when 1 =>
                                            output <= "11010011";
                                        when others =>
                                            output <= "11100001";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00101011";
                                        when 1 =>
                                            output <= "10010010";
                                        when others =>
                                            output <= "00000111";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00100111";
                                        when 1 =>
                                            output <= "10010010";
                                        when others =>
                                            output <= "00010011";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00111010";
                                        when 1 =>
                                            output <= "00001111";
                                        when others =>
                                            output <= "00100101";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "11010010";
                                        when others =>
                                            output <= "01000011";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00111100";
                                        when 1 =>
                                            output <= "11101110";
                                        when others =>
                                            output <= "11010001";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10001101";
                                        when 1 =>
                                            output <= "11011010";
                                        when others =>
                                            output <= "00110000";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01011100";
                                        when 1 =>
                                            output <= "10101011";
                                        when others =>
                                            output <= "10110000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "01000010";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01001110";
                                        when 1 =>
                                            output <= "00011000";
                                        when others =>
                                            output <= "11110001";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000000";
                                        when 1 =>
                                            output <= "00001111";
                                        when others =>
                                            output <= "10111000";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00100011";
                                        when 1 =>
                                            output <= "01110111";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01011010";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "00011110";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001101";
                                        when 1 =>
                                            output <= "11100000";
                                        when others =>
                                            output <= "00010000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00100000";
                                        when 1 =>
                                            output <= "11101110";
                                        when others =>
                                            output <= "11001110";
                                    end case;
                            end case;
                    end case;
                when 25 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11011101";
                                        when 1 =>
                                            output <= "00001001";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00111110";
                                        when 1 =>
                                            output <= "00010101";
                                        when others =>
                                            output <= "00010110";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10101001";
                                        when 1 =>
                                            output <= "00010110";
                                        when others =>
                                            output <= "00000100";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11100111";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "11001100";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "11110001";
                                        when others =>
                                            output <= "10010000";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10101010";
                                        when 1 =>
                                            output <= "11101110";
                                        when others =>
                                            output <= "10100101";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10010111";
                                        when 1 =>
                                            output <= "10010010";
                                        when others =>
                                            output <= "11111110";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11011001";
                                        when 1 =>
                                            output <= "11100110";
                                        when others =>
                                            output <= "01110100";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "11101101";
                                        when others =>
                                            output <= "01011100";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01001101";
                                        when 1 =>
                                            output <= "01110011";
                                        when others =>
                                            output <= "11101001";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010101";
                                        when 1 =>
                                            output <= "11010000";
                                        when others =>
                                            output <= "10100010";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01101100";
                                        when 1 =>
                                            output <= "01001111";
                                        when others =>
                                            output <= "11101110";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01000100";
                                        when 1 =>
                                            output <= "01110011";
                                        when others =>
                                            output <= "11100111";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111001";
                                        when 1 =>
                                            output <= "11100010";
                                        when others =>
                                            output <= "00001001";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11100001";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "01010100";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "10001100";
                                        when others =>
                                            output <= "10001000";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111010";
                                        when 1 =>
                                            output <= "10100110";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111101";
                                        when 1 =>
                                            output <= "00110100";
                                        when others =>
                                            output <= "01010111";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "00010100";
                                        when others =>
                                            output <= "11000111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10100111";
                                        when 1 =>
                                            output <= "01101000";
                                        when others =>
                                            output <= "11111101";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110100";
                                        when 1 =>
                                            output <= "00110000";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110111";
                                        when 1 =>
                                            output <= "00001110";
                                        when others =>
                                            output <= "01001010";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11011000";
                                        when 1 =>
                                            output <= "01101111";
                                        when others =>
                                            output <= "10111101";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "00011000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "10011011";
                                    end case;
                            end case;
                    end case;
                when 26 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01100100";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "01110100";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011010";
                                        when 1 =>
                                            output <= "10111001";
                                        when others =>
                                            output <= "11010010";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11100001";
                                        when 1 =>
                                            output <= "00111010";
                                        when others =>
                                            output <= "01000100";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101101";
                                        when 1 =>
                                            output <= "10010111";
                                        when others =>
                                            output <= "00101000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10010110";
                                        when 1 =>
                                            output <= "11001111";
                                        when others =>
                                            output <= "11111000";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "11110100";
                                        when others =>
                                            output <= "11101001";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "10111000";
                                        when others =>
                                            output <= "10100100";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101000";
                                        when 1 =>
                                            output <= "01011011";
                                        when others =>
                                            output <= "11001011";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011001";
                                        when 1 =>
                                            output <= "10001010";
                                        when others =>
                                            output <= "00100111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "01000101";
                                        when others =>
                                            output <= "11111011";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "10111101";
                                        when others =>
                                            output <= "00000010";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11010000";
                                        when 1 =>
                                            output <= "11100100";
                                        when others =>
                                            output <= "00001000";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01101110";
                                        when 1 =>
                                            output <= "11011001";
                                        when others =>
                                            output <= "10111001";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "11000100";
                                        when others =>
                                            output <= "11000011";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011101";
                                        when 1 =>
                                            output <= "10011111";
                                        when others =>
                                            output <= "11111100";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "01010001";
                                        when others =>
                                            output <= "01011001";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000111";
                                        when 1 =>
                                            output <= "00001010";
                                        when others =>
                                            output <= "01011111";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01010001";
                                        when 1 =>
                                            output <= "00100110";
                                        when others =>
                                            output <= "11111010";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11011001";
                                        when 1 =>
                                            output <= "00011010";
                                        when others =>
                                            output <= "10010111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11100000";
                                        when 1 =>
                                            output <= "11111011";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "00111000";
                                        when others =>
                                            output <= "00000000";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01001111";
                                        when 1 =>
                                            output <= "00011111";
                                        when others =>
                                            output <= "00110111";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00100111";
                                        when 1 =>
                                            output <= "00110011";
                                        when others =>
                                            output <= "10010001";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110111";
                                        when 1 =>
                                            output <= "11010001";
                                        when others =>
                                            output <= "00110011";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110010";
                                        when 1 =>
                                            output <= "00101110";
                                        when others =>
                                            output <= "00000010";
                                    end case;
                            end case;
                    end case;
                when 27 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110110";
                                        when 1 =>
                                            output <= "11000000";
                                        when others =>
                                            output <= "00101010";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01010100";
                                        when 1 =>
                                            output <= "11110010";
                                        when others =>
                                            output <= "11111111";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001100";
                                        when 1 =>
                                            output <= "00101011";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011110";
                                        when 1 =>
                                            output <= "11000111";
                                        when others =>
                                            output <= "11100111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10110101";
                                        when 1 =>
                                            output <= "11101011";
                                        when others =>
                                            output <= "10001010";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11000010";
                                        when 1 =>
                                            output <= "11111110";
                                        when others =>
                                            output <= "01100000";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011011";
                                        when 1 =>
                                            output <= "11001110";
                                        when others =>
                                            output <= "01111010";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001100";
                                        when 1 =>
                                            output <= "11110010";
                                        when others =>
                                            output <= "10100010";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010010";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "00101101";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11001000";
                                        when 1 =>
                                            output <= "01010111";
                                        when others =>
                                            output <= "10110111";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01100111";
                                        when 1 =>
                                            output <= "00001001";
                                        when others =>
                                            output <= "11101001";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011101";
                                        when 1 =>
                                            output <= "11000100";
                                        when others =>
                                            output <= "11001001";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110000";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "10111100";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10011111";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "01001000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "00101000";
                                        when others =>
                                            output <= "00100010";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010110";
                                        when 1 =>
                                            output <= "11111111";
                                        when others =>
                                            output <= "01100010";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "00100010";
                                        when others =>
                                            output <= "01001001";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10110001";
                                        when 1 =>
                                            output <= "00100110";
                                        when others =>
                                            output <= "11010110";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10101101";
                                        when 1 =>
                                            output <= "10010100";
                                        when others =>
                                            output <= "00100101";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10100101";
                                        when 1 =>
                                            output <= "10111100";
                                        when others =>
                                            output <= "00011111";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01010100";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "00011101";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "01101000";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110110";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "10100101";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11010110";
                                        when 1 =>
                                            output <= "11010110";
                                        when others =>
                                            output <= "00010111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00100011";
                                        when 1 =>
                                            output <= "11111100";
                                        when others =>
                                            output <= "11111111";
                                    end case;
                            end case;
                    end case;
                when 28 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110101";
                                        when 1 =>
                                            output <= "01101001";
                                        when others =>
                                            output <= "00010110";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111110";
                                        when 1 =>
                                            output <= "00001101";
                                        when others =>
                                            output <= "10110011";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11010010";
                                        when 1 =>
                                            output <= "11110111";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11011011";
                                        when 1 =>
                                            output <= "11010110";
                                        when others =>
                                            output <= "01000100";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010110";
                                        when 1 =>
                                            output <= "10010010";
                                        when others =>
                                            output <= "11000011";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001001";
                                        when 1 =>
                                            output <= "01001000";
                                        when others =>
                                            output <= "00001110";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010101";
                                        when 1 =>
                                            output <= "11010111";
                                        when others =>
                                            output <= "01110010";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111011";
                                        when 1 =>
                                            output <= "11101001";
                                        when others =>
                                            output <= "01001000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000010";
                                        when 1 =>
                                            output <= "11001000";
                                        when others =>
                                            output <= "00101010";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010110";
                                        when 1 =>
                                            output <= "11011100";
                                        when others =>
                                            output <= "01011011";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10101010";
                                        when 1 =>
                                            output <= "10011011";
                                        when others =>
                                            output <= "01100010";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11011111";
                                        when 1 =>
                                            output <= "00101111";
                                        when others =>
                                            output <= "11011011";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11000110";
                                        when 1 =>
                                            output <= "01111010";
                                        when others =>
                                            output <= "00010100";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "11101011";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "10001010";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10101000";
                                        when 1 =>
                                            output <= "00001010";
                                        when others =>
                                            output <= "11111101";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "01000001";
                                        when others =>
                                            output <= "00110000";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00101100";
                                        when 1 =>
                                            output <= "11001100";
                                        when others =>
                                            output <= "11101111";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11010010";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "11001111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11000110";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "00111010";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110000";
                                        when 1 =>
                                            output <= "00111010";
                                        when others =>
                                            output <= "11111010";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01010111";
                                        when 1 =>
                                            output <= "01110101";
                                        when others =>
                                            output <= "01010011";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111010";
                                        when 1 =>
                                            output <= "00000111";
                                        when others =>
                                            output <= "11001110";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10001010";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "11000100";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10010011";
                                        when 1 =>
                                            output <= "01100001";
                                        when others =>
                                            output <= "11011011";
                                    end case;
                            end case;
                    end case;
                when 29 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110101";
                                        when 1 =>
                                            output <= "11000110";
                                        when others =>
                                            output <= "11101100";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000011";
                                        when 1 =>
                                            output <= "00100111";
                                        when others =>
                                            output <= "11010001";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01010011";
                                        when 1 =>
                                            output <= "00110101";
                                        when others =>
                                            output <= "00000000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11001100";
                                        when 1 =>
                                            output <= "00011000";
                                        when others =>
                                            output <= "00001000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00100110";
                                        when 1 =>
                                            output <= "01001100";
                                        when others =>
                                            output <= "00011000";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00101010";
                                        when 1 =>
                                            output <= "00110110";
                                        when others =>
                                            output <= "11100010";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10101111";
                                        when 1 =>
                                            output <= "01010111";
                                        when others =>
                                            output <= "11001101";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01101000";
                                        when 1 =>
                                            output <= "01000011";
                                        when others =>
                                            output <= "01011101";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "11010000";
                                        when others =>
                                            output <= "11001001";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01110001";
                                        when 1 =>
                                            output <= "01100001";
                                        when others =>
                                            output <= "10111100";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10001101";
                                        when 1 =>
                                            output <= "01101000";
                                        when others =>
                                            output <= "11011110";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110111";
                                        when 1 =>
                                            output <= "01100111";
                                        when others =>
                                            output <= "01110110";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11100110";
                                        when 1 =>
                                            output <= "00100110";
                                        when others =>
                                            output <= "10011001";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01100101";
                                        when 1 =>
                                            output <= "01101011";
                                        when others =>
                                            output <= "00000000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000111";
                                        when 1 =>
                                            output <= "00011001";
                                        when others =>
                                            output <= "01100111";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10101110";
                                        when 1 =>
                                            output <= "11010101";
                                        when others =>
                                            output <= "00000100";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10101001";
                                        when 1 =>
                                            output <= "00011001";
                                        when others =>
                                            output <= "01100001";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "01100011";
                                        when others =>
                                            output <= "01010000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110000";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00010111";
                                        when 1 =>
                                            output <= "11010010";
                                        when others =>
                                            output <= "11000011";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000000";
                                        when 1 =>
                                            output <= "00100010";
                                        when others =>
                                            output <= "11110001";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011111";
                                        when 1 =>
                                            output <= "11101101";
                                        when others =>
                                            output <= "01010110";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00100100";
                                        when 1 =>
                                            output <= "00101001";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "11101100";
                                        when others =>
                                            output <= "00001011";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001000";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "01001000";
                                    end case;
                            end case;
                    end case;
                when 30 =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00011110";
                                        when 1 =>
                                            output <= "00011110";
                                        when others =>
                                            output <= "00000000";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10111011";
                                        when 1 =>
                                            output <= "10111000";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01110001";
                                        when 1 =>
                                            output <= "01110010";
                                        when others =>
                                            output <= "00000101";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10001111";
                                        when 1 =>
                                            output <= "01001000";
                                        when others =>
                                            output <= "00001001";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10101110";
                                        when 1 =>
                                            output <= "01010000";
                                        when others =>
                                            output <= "00100101";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11011111";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "00100010";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10111000";
                                        when 1 =>
                                            output <= "10110000";
                                        when others =>
                                            output <= "00000110";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00101011";
                                        when 1 =>
                                            output <= "01001100";
                                        when others =>
                                            output <= "00110101";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10111000";
                                        when 1 =>
                                            output <= "00101111";
                                        when others =>
                                            output <= "01000011";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00001100";
                                        when 1 =>
                                            output <= "00001110";
                                        when others =>
                                            output <= "00011101";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11010110";
                                        when 1 =>
                                            output <= "01010010";
                                        when others =>
                                            output <= "11110100";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11100101";
                                        when 1 =>
                                            output <= "01011101";
                                        when others =>
                                            output <= "00110110";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000111";
                                        when 1 =>
                                            output <= "11110110";
                                        when others =>
                                            output <= "11010010";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110001";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "10110000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01010101";
                                        when 1 =>
                                            output <= "00111001";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10100101";
                                        when 1 =>
                                            output <= "11001100";
                                        when others =>
                                            output <= "00000111";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10111001";
                                        when 1 =>
                                            output <= "11011101";
                                        when others =>
                                            output <= "11001010";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11001101";
                                        when 1 =>
                                            output <= "01000010";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11101010";
                                        when 1 =>
                                            output <= "10100111";
                                        when others =>
                                            output <= "00100111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11000100";
                                        when 1 =>
                                            output <= "10110101";
                                        when others =>
                                            output <= "11011110";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110001";
                                        when 1 =>
                                            output <= "11011100";
                                        when others =>
                                            output <= "11101000";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10011101";
                                        when 1 =>
                                            output <= "00111100";
                                        when others =>
                                            output <= "11101110";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01101001";
                                        when 1 =>
                                            output <= "00001010";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11000011";
                                        when 1 =>
                                            output <= "00000010";
                                        when others =>
                                            output <= "01100000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11001000";
                                        when 1 =>
                                            output <= "11111110";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                            end case;
                    end case;
                when others =>
                    case addressX is
                        when 0 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10101001";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "10000000";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01110100";
                                        when 1 =>
                                            output <= "00000111";
                                        when others =>
                                            output <= "01100001";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01110000";
                                        when 1 =>
                                            output <= "01101001";
                                        when others =>
                                            output <= "10110100";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11110000";
                                        when 1 =>
                                            output <= "01001101";
                                        when others =>
                                            output <= "01000100";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01010010";
                                        when 1 =>
                                            output <= "01011010";
                                        when others =>
                                            output <= "11111101";
                                    end case;
                            end case;
                        when 1 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110101";
                                        when 1 =>
                                            output <= "00000000";
                                        when others =>
                                            output <= "10110110";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110110";
                                        when 1 =>
                                            output <= "00110110";
                                        when others =>
                                            output <= "00111001";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00110101";
                                        when 1 =>
                                            output <= "01111111";
                                        when others =>
                                            output <= "01011001";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00111101";
                                        when 1 =>
                                            output <= "10010000";
                                        when others =>
                                            output <= "11111000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01011101";
                                        when 1 =>
                                            output <= "01001100";
                                        when others =>
                                            output <= "10100010";
                                    end case;
                            end case;
                        when 2 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000000";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "00000000";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11001011";
                                        when 1 =>
                                            output <= "01011101";
                                        when others =>
                                            output <= "11010101";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "00111000";
                                        when others =>
                                            output <= "01000001";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "11111110";
                                        when others =>
                                            output <= "10101111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00100111";
                                        when 1 =>
                                            output <= "10000000";
                                        when others =>
                                            output <= "00000001";
                                    end case;
                            end case;
                        when 3 =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01101011";
                                        when 1 =>
                                            output <= "11001110";
                                        when others =>
                                            output <= "00010110";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "11100111";
                                        when others =>
                                            output <= "00011001";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00111100";
                                        when 1 =>
                                            output <= "00111110";
                                        when others =>
                                            output <= "11111001";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11001000";
                                        when 1 =>
                                            output <= "01010011";
                                        when others =>
                                            output <= "00110000";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "01111111";
                                        when 1 =>
                                            output <= "01001001";
                                        when others =>
                                            output <= "01010000";
                                    end case;
                            end case;
                        when others =>
                            case addressY is
                                when 0 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10000111";
                                        when 1 =>
                                            output <= "00010111";
                                        when others =>
                                            output <= "11010001";
                                    end case;
                                when 1 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "00000011";
                                        when 1 =>
                                            output <= "11100001";
                                        when others =>
                                            output <= "00010000";
                                    end case;
                                when 2 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10110000";
                                        when 1 =>
                                            output <= "01001011";
                                        when others =>
                                            output <= "00011110";
                                    end case;
                                when 3 =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "11111110";
                                        when 1 =>
                                            output <= "10101011";
                                        when others =>
                                            output <= "01111111";
                                    end case;
                                when others =>
                                    case addressZ is
                                        when 0 =>
                                            output <= "10101101";
                                        when 1 =>
                                            output <= "00001111";
                                        when others =>
                                            output <= "11001101";
                                    end case;
                            end case;
                    end case;
            end case;
        end if;
    end process;
end architecture;
