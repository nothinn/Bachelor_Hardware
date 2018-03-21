library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;
    
use work.types.all;

entity top is
    port (
        clk: in  std_logic;
        SW  : in STD_LOGIC_VECTOR(15 downto 0);
        LED : out STD_LOGIC_VECTOR(15 downto 0);
        topResults: out MAC_result
    );
end entity;

architecture rtl of top is
    
    
    component weightsRom2 is
    generic(
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
    end component;
    
    signal counterX, counterY, counterZ: integer range 0 to 4;
    signal counterFilter: integer range 0 to 31;
    

   
begin
    
    
    process(clk)
    begin
        if rising_edge(clk) then
            
            counterZ <= counterZ + 1;
            
            if counterZ = 2 then
                counterZ <= 0;
                counterY <= counterY + 1;
                if counterY = 2 then
                    counterY <= 0;
                    counterX <= counterX + 1;
                    
                    if counterX = 3 then
                        counterX <= 0;
                        CounterFilter <= CounterFilter + 1;
                        
                        if CounterFilter = 31 then
                            counterFilter <= 0;
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process;



    weightsRom_inst: weightsRom2
        generic map(
            addressX => 0,
            addressY => 0
        )
        port map(
            clk     => clk,
            rst     => '0',
            
            filter => counterFilter,
            addressZ=> counterZ,
            output => topResults(15 downto 8)
        );
        
    weightsRom_inst2: weightsRom2
            generic map(
                addressX => 1,
                addressY => 0
            )
            port map(
                clk     => clk,
                rst     => '0',
                
                filter => counterFilter,
                addressZ=> counterZ,
                output => topResults(7 downto 0)
            );
    
end architecture;