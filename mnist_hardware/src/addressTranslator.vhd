library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

    use IEEE.MATH_REAL.CEIL;

entity addressTranslator is
    generic(
        depth_size: integer := 32;
        size: integer := 5;
        ram_size: integer := 28;

        NrOfInputs: integer := 8
);
    port (
        addressX: in integer range 0 to ram_size-1;
        addressY: in integer range 0 to ram_size-1;
        
        blocknr    : out integer range 0 to size ** 2 - 1;
        depth_addr : out integer range 0 to (integer( real(depth_size) * ((ceil(real(ram_size) / real(size)) ** 2) / Real(NrOfInputs)) ) - integer(1))
        
    );
end entity;

architecture rtl of addressTranslator is

constant b : integer := depth_size * integer(CEIL(real(ram_size)/real(size)));
begin
    
    
    process(all)
        
    begin
        blocknr <= 0;
        depth_addr <= 0;
        
        for x in 0 to ram_size - 1 loop
            for y in 0 to ram_size - 1 loop
                
                if addressX = x and addressY = y then
                    blocknr <= size * ( y mod size) + x mod size;
                    
                    
                    depth_addr <= ((integer(x / size) * depth_size + b *integer( y/size)))/8;
                end if;
            end loop;
            
            
        end loop;
        
    end process;
    
    
end architecture;