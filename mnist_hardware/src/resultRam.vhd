library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;
    use IEEE.std_logic_unsigned.ALL;

    use work.Types.all;

entity resultRam is
    generic(
        depth_size: integer := 32;
        size: integer := 5;
	ram_size: integer := 28;
        
        NrOfInputs: integer := 1
);
    
    port (
        clk: in  std_logic;
        
        ena   : in  std_logic;
        wea   : in  std_logic;

        depth: in integer range 0 to depth_size-1;
        addressX: in  integer range 0 to ram_size-1;
        addressY: in integer range 0 to ram_size-1;
        
       -- dia   : in  std_logic_vector(16*NrOfInputs + 15 downto 0);
        
        dia :  in ram_input(NrOfINputs - 1 downto 0);
       -- doa   : out std_logic_vector(25*16-1 downto 0);
        doa : out MAC_inputs

    );
end entity;

architecture rtl of resultRam is
    
    subtype mem_type is std_logic_vector(15 downto 0) ;
    type mem_depth is array(integer range depth_size - 1 downto 0) of mem_type;
    type mem_x is array(integer range ram_size-1 downto 0) of mem_depth;
    type mem_y is array(integer range ram_size-1 downto 0) of mem_x;
    
    
    signal mem : mem_y ;


    
begin
    
    ramProcess: process (clk) is
    begin
        if rising_edge(clk) then
            if ena = '1' then
                For x in 0 to size - 1 loop
                    for y in 0 to size - 1 loop
                       doa(x*size + y) <= signed(mem(depth)(addressX + x)(addressY + y));
                    end loop;
                end loop;
              
                
                
                if wea = '1' then
                    for depth_count in 0 to NrOfInputs - 1 loop
                        mem(depth + depth_count)(addressX)(addressY) <= dia(depth_count);
                    end loop;
                end if;
            end if;
        end if;
    end process;

    
    
    
    
    
end architecture;