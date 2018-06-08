library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

    use IEEE.MATH_REAL.CEIL; 


entity addressTranslator is
    generic(
        depth_size: integer := 64;
        size: integer := 5;
        ram_size: integer := 28;

        NrOfInputs: integer := 8
);
    port (
        addressX: in integer range 0 to ram_size-1;
        addressY: in integer range 0 to ram_size-1;
        valid: in std_logic;
        blocknr    : out integer range 0 to size ** 2 - 1;
        blockValid : out std_logic;
        depth_addr : out integer 
        
    );
end entity;

architecture rtl of addressTranslator is

constant b : integer := depth_size * integer(CEIL(real(ram_size)/real(size)));


type rom_typex is array(0 to ram_size-1) of integer;
type rom_typey is array(0 to ram_size-1) of rom_typex;



signal rom_blocknr: rom_typey := (others => (others => 0));
signal rom_depth_addr: rom_typey  := (others => (others => 0)); 



begin
        --Fill out rom using a generate
    gen_romx: for x in 0 to ram_size-1 generate
        gen_romy: for y in 0 to ram_size-1 generate
            rom_blocknr(x)(y) <= size * ( y mod size) + x mod size;
            rom_depth_addr(x)(y) <=  ((integer(x / size) * depth_size + b * integer( y/size)));
        end generate;
    end generate;
    
    

    
    --Read from rom
    process(all)
    begin
        if valid = '0' then
            blocknr <= 0;
            depth_addr <= 0;
            blockValid <= '0';
        else
            blockValid <= '1';
            blocknr <= rom_blocknr(addressX)(addressY);
            depth_addr <= rom_depth_addr(addressX)(addressY);
        end if;
    end process;
end architecture;