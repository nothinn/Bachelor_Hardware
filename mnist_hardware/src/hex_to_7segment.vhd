library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.Numeric_std.ALL;

Entity hex_to_7segment is
	port (	clk: in std_logic;
	        reset: in std_logic;
	        value: in std_logic_vector(15 downto 0);
			segment: out std_logic_vector(6 downto 0);
			an : out std_logic_vector(3 downto 0)
			);
end hex_to_7segment;

architecture behaviour of hex_to_7segment is




signal tick_gen, tick_gen_next : unsigned(32 downto 0);

signal tick_gen_two , tick_gen_two_next : unsigned (32 downto 0);


signal tick, tick_two : std_logic;

signal counter, counter_next : std_logic_vector(15 downto 0);

type state_type is (State1, state2, state3, state4);

signal state, state_next : state_type;

signal pre_segment: std_logic_vector(6 downto 0);

signal input : std_logic_vector(3  downto 0);
begin

    

    process(reset, clk)
    begin
        if reset = '1' then
            counter <=  (others => '0');
            tick_gen <= (others => '0');
            state <= state1;
            tick_gen_two <= (others => '0');
        elsif rising_edge(clk) then
            tick_gen_two <= tick_gen_two_next;
            state <= state_next;
            tick_gen <= tick_gen_next;
            if tick = '1' then
                counter <= counter_next;
            else
                counter <= counter;
            end if;
        end if;
    end process;
    
    
    
    
    
    counter_next <= counter + 1;
    
    process(tick_gen)
    begin
        if tick_gen = 1000000 then
            tick_gen_next <= (others => '0');
            tick <= '1';
        else
            tick_gen_next <= tick_gen + 1;
            tick <= '0';
        end if;
    end process;
    
    
    
    process(tick_gen_two)
    begin
        if tick_gen_two = 1 then -- 00000 then
            tick_gen_two_next <= (others => '0');
            tick_two <= '1';
        else
            tick_gen_two_next <= tick_gen_two + 1;
            tick_two <= '0';
        end if;
    end process;
    
    
    process(state, tick_two,value)
    begin
            state_next <= state;
            -- State for multiplexing
                case state is
                    
                    when state1 =>
                        an <= "1110";
                        input <= value(3 downto 0);
                        if tick_two = '1' then
                            state_next <= state2;
                        end if;
                     when state2 =>
                        an <= not "0010";
                        input <= value(7 downto 4);
                      if tick_two = '1' then
                         state_next <= state3;
                     end if;
                     
                     when state3 =>
                        an <=not "0100";
                        input <= value(11 downto 8);
                        if tick_two = '1' then
                            state_next <= state4;
                        end if;
                     when others =>
                        an <= not "1000";
                        input <= value(15 downto 12);
                        if tick_two = '1' then
                            state_next <= state1;
                        end if;
                  end case;
                  
         end process;
    
--    ____
--   |    |
--   |____|
--   |    |
--   |____|

	with input select
		pre_segment <= 	"1111110" when "0000", --0
						"0110000" when "0001", --1
						"1101101" when "0010", --2
						"1111001" when "0011", --3
						"0110011" when "0100", --4
						"1011011" when "0101", --5
						"1011111" when "0110", --6
						"1110000" when "0111", --7
						"1111111" when "1000", --8
						"1111011" when "1001", --9
						"1110111" when "1010", --A
						"0011111" when "1011", --B
						"1001110" when "1100", --C
						"0111101" when "1101", --D
						"1001111" when "1110", --E
						"1000111" when others; --F
							
	segment (6 downto 0) <= not pre_segment (6 downto 0);
	
end behaviour;