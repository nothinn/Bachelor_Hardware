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
    
    component multiplier is
        port (
            clk : in std_logic;
            SW  : in STD_LOGIC_VECTOR(15 downto 0);
            LED : out STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;
    
    component mac is
    	port(
        clk     : in  std_logic;
        rst     : in  std_logic;
        weight  : in  MAC_weights;
        neurons : in  MAC_inputs;
        results : out MAC_result
    );
    
    end component;
    
    
    	
    signal topWeights: MAC_weights;
    signal topInputs: MAC_inputs;
    signal topResult: MAC_result;
    
    signal counter: signed(7 downto 0);
    
    signal ledd: std_logic;
begin
    
    
    multiplier_inst: multiplier
        port map (
            clk => clk,
            SW  => SW,
            LED => LED
        );


    process(clk)
    begin
        if rising_edge(clk) then
        counter <= counter+1;
        end if;
    end process;

	fill: for I in 0 to 24 generate
		topWeights(I) <= to_signed(I,8) + counter ;
		topInputs(I) <= to_signed(I,16)+ counter ;
	end generate fill;
	
	--    fill: for I in 0 to 24 generate
    --        weight(i) <= to_signed(I,8) + counter;
    --            neurons(i) <= to_signed(I*2,16) + counter;
    --    end generate fill;
	
	ledd <= topResult(15);
	MAC1: MAC
		port map(
			clk     => clk,
			rst     => '0',
			weight  => topweights,
			neurons => topInputs,
			results => topResult
		);
		
		topResults <= topResult;

    
end architecture;