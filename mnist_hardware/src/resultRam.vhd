library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;
    use IEEE.std_logic_unsigned.ALL;


    use IEEE.math_real.all;
    --use IEEE.math_real."ceil";

    use work.Types.all;

entity resultRam is
    generic(
        depth_size: integer := 32;
        size: integer := 5;
		ram_size: integer := 28;
        
        NrOfInputs: integer := 8
);
    
    port (
        clk: in  std_logic;
        
        ena   : in  std_logic;
        wea   : in  std_logic;

        depth: in integer range 0 to depth_size-1;
        addressX: in  integer range 0 to ram_size-1;
        addressY: in integer range 0 to ram_size-1;
        
        dia :  in ram_input(NrOfINputs - 1 downto 0);
        doa : out MAC_inputs
    );
end entity;

architecture rtl of resultRam is
    
    component addressTranslator is
        generic (
            depth_size :  integer := 32;
            size       :  integer := 5;
            ram_size   :  integer := 28;
            NrOfInputs :  integer := 8
        );
        port (
            addressX   : in integer range 0 to ram_size - 1;
            addressY   : in integer range 0 to ram_size - 1;
            blocknr    : out integer range 0 to size ** 2 - 1;
            depth_addr : out integer range 0 to integer( depth_size * ((ceil(real(ram_size) / real(size)) ** 2) / NrOfInputs) ) - integer(1)
        );
    end component;
        
    
    
--    type mem_type is array(integer range NrOfInputs-1 downto 0) of MAC_result;
    
--    type mem_block is array(integer range integer(ceil(real(ram_size)/real(size))) ** 2 * depth_size / NrOfInputs downto 0) of mem_type;
    
    
--    type mem_ram is array(integer range size**2-1 downto 0) of mem_block;
    
    signal memory : mem_ram := (others =>(others =>(others =>(others=>'0'))));
    
    
    
    
    
    type trans_block is array(integer range size**2-1 downto 0) of integer range 0 to size **2-1;
    
    type trans_addr is array(integer range size**2-1 downto 0) of integer range 0 to integer(depth_size * (ceil(real(ram_size) / real(size) ) ** 2)) / NrOfInputs - 1;
    
    
    
    signal blocknr: trans_block;
    signal depth_addr: trans_addr;
    
    
begin
    
    ramProcess: process (clk) is
    begin
        if rising_edge(clk) then
            if ena = '1' then
                For x in -size/2 to size/2 loop
                    for y in -size/2 to size/2 loop
                        
                        if addressX + x < 0 or addressX + x >= size or addressY + y < 0 or addressY + y >= size then
                            doa((x+2)*size + (y+2)) <= (others => '0');
                        else
                            doa((x+2)*size + (y+2)) <= memory(blocknr(x + addressX + size*(y + addressY)))  (depth_addr(x + addressX + size*(y + addressY) ) + depth/8) ( depth mod 8);
                        end if;
                       
                    end loop;
                end loop;
                
                
                if wea = '1' then
                    for depth_count in 0 to NrOfInputs - 1 loop
                        memory(blocknr((size**2-1)/2))(depth_addr((size**2-1)/2) + depth/4)(depth_count) <= dia(depth_count);
                    end loop;
                end if;
            end if;
        end if;
    end process;

    
    translateProcess: process(all) is
    begin

        
    end process;
    
    gen_trans: for I in 0 to 4 generate
        gen_trans2: for J in 0 to 4 generate
        addressTranslator_inst: addressTranslator
            generic map (
                depth_size => 32,
                size       => 5,
                ram_size   => 28,
                NrOfInputs => 8
            )
            port map (
                addressX   => addressX + (-size/2 + i),
                addressY   => addressY + (-size/2 + j),
                blocknr    => blocknr(I + j*5),
                depth_addr => depth_addr(I + j*5)
            );
        end generate;
    end generate;
    
    

    
    
end architecture;