library ieee;
    use ieee.NUMERIC_STD.all;
    use ieee.MATH_REAL.CEIL;

library std;
    use std.textio.all;

entity tb_addressTranslator is
end entity;

architecture rtl_sim of tb_addressTranslator is

    constant depth_size: integer := 32;
    constant size: integer := 5;
    constant ram_size: integer := 28;
    constant NrOfInputs: integer := 8;

    signal addressX: integer range 0 to ram_size - 1;
    signal addressY: integer range 0 to ram_size - 1;
    signal blocknr: integer range 0 to size ** 2 - 1;
    signal depth_addr: integer range 0 to integer(depth_size *((ceil(real(ram_size) / real(size)) ** 2) / NrOfInputs)) - integer(1);

begin

    addressTranslator_inst: entity work.addressTranslator
        generic map (
            depth_size => depth_size,
            size       => size,
            ram_size   => ram_size,
            NrOfInputs => NrOfInputs
        )
        port map (
            addressX   => addressX,
            addressY   => addressY,
            blocknr    => blocknr,
            depth_addr => depth_addr
        );

    stimuli_p: process is
    begin
        
        addressX <= 0;
        addressY <= 0;
        
        wait for 5 ns;
        
        for X in 0 to 27 loop
            for Y in 0 to 27 loop
                addressX <= X;
                addressY <= Y;
                wait for 5 ns;
            end loop;
        end loop;
        
        wait;
        
        report "DONE" severity failure;
    end process;

end architecture;

