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
        depth_addr : out integer range 0 to integer( depth_size * ((ceil(real(ram_size) / real(size)) ** 2) / NrOfInputs) ) - integer(1)
        
    );
end entity;

architecture rtl of addressTranslator is

constant b : integer := depth_size * integer(CEIL(real(ram_size)/real(size)));


type rom_typex is array(0 to ram_size-1) of integer;
type rom_typey is array(0 to ram_size-1) of rom_typex;



signal rom_blocknr: rom_typey;
signal rom_depth_addr: rom_typey;



begin
        --Fill out rom using a generate
    gen_romx: for x in 0 to ram_size-1 generate
        gen_romy: for y in 0 to ram_size-1 generate
            rom_blocknr(x)(y) <= size * ( y mod size) + x mod size;
            rom_depth_addr(x)(y) <=  ((integer(x / size) * depth_size + b *integer( y/size)))/8;
        end generate;
    end generate;
    
    
    

    
    --Read from rom
    blocknr <= rom_blocknr(addressX)(addressY);
    depth_addr <= rom_depth_addr(addressX)(addressY);

end architecture;