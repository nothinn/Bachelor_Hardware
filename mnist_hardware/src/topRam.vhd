library IEEE; 
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;
    use IEEE.std_logic_unsigned.all; 


    use IEEE.math_real.all;

    use work.Types.all;

entity topRam is
    generic(
        depth_size: integer := 64;
        size: integer := 5;
        ram_size: integer := 28;

        NrOfInputs: integer := 8
    );

    port (
        clk: in  std_logic;
        rst: in  std_logic;

        ena   : in  std_logic;
        wea   : in  std_logic;

        depth: in integer range 0 to depth_size-1;
        addressX: in  integer range 0 to ram_size-1;
        addressY: in integer range 0 to ram_size-1;

        dia :  in ram_input(NrOfINputs - 1 downto 0);
        doa : out MAC_inputs;
        
        ready: out std_logic

    );
end entity;

--port a is used for input.
--port b is used for output.

architecture rtl of topRam is

    component addressTranslator is
        generic (
            depth_size :  integer := depth_size;
            size       :  integer := 5;
            ram_size   :  integer := 28;
            NrOfInputs :  integer := 8
        );
        port (
            addressX   : in integer range 0 to ram_size - 1;
            addressY   : in integer range 0 to ram_size - 1;
            blocknr    : out integer range 0 to size ** 2 - 1;
            blockValid : out std_logic;
            depth_addr : out integer range 0 to integer( real(depth_size) * ((ceil(real(ram_size) / real(size)) ** 2) / real(NrOfInputs)) ) - integer(1)
        );
    end component;

    component ram is
        generic (
            depth  :  integer := 64;
            width  :  integer := 7;
            filter_width : integer := 5
        );
        port (
            clk   : in std_logic;
            ena   : in std_logic;
            enb   : in std_logic;
            addra : in integer;
            addrb : in integer;
            wea   : in std_logic;
            web   : in std_logic;
            dia   : in MAC_result;
            dib   : in MAC_result;
            doa   : out MAC_result;
            dob   : out MAC_result
        );
    end component;



    type trans_block is array(integer range size**2-1 downto 0) of integer range 0 to size **2-1;

    type trans_addr is array(integer range size**2-1 downto 0) of integer range 0 to integer( real(depth_size) * ((ceil(real(ram_size) / real(size)) ** 2) / real(NrOfInputs)) ) - integer(1);
    

    signal blocknr_arr: trans_block;
    signal blocknr_arr_reg: trans_block;
    signal depth_addr_arr: trans_addr;
    signal depth_addr_arr2: trans_addr;

    signal blocknr: integer range 0 to integer( real(depth_size) * ((ceil(real(ram_size) / real(size)) ** 2) / real(NrOfInputs)) ) - integer(1);
    signal depth_addr: integer range 0 to integer( real(depth_size) * ((ceil(real(ram_size) / real(size)) ** 2) / real(NrOfInputs)) ) - integer(1);
    signal depth_addr_added: integer range 0 to integer( real(depth_size) * ((ceil(real(ram_size) / real(size)) ** 2) / real(NrOfInputs)) ) - integer(1);

    signal latchedInput : ram_input(NrOfINputs - 1 downto 0);
    signal latchedDepth : integer range 0 to depth_size -1;
    signal latchedAddrX : integer range 0 to ram_size -1;
    signal latchedAddrY : integer range 0 to ram_size -1;

    signal blockValid : std_logic_vector( size**2 -1 downto 0);
    --
    signal counter: integer range 0 to NrOfInputs - 1;

    
    type type_doa is array (integer range 0 to size **2 -1) of MAC_result;
    type type_wea is array (integer range 0 to size **2 -1) of std_logic;
    
    
    
    signal addrB : trans_addr;
    
    
    signal muxData : MAC_result;
    
    
    signal doa_int : mac_inputs;
    signal wea_int : type_wea;
    
    
    
    signal addressX_reg: integer range 0 to ram_size-1;
    signal addressY_reg: integer range 0 to ram_size-1;
    
    
    
    
    
    
    
    
    
    
    
    ------------------------------------
    -- For OR-ing crossbar
    ------------------------------------
    type addr_result_type is array (integer range size**2-1 downto 0) of integer range 0 to integer( real(depth_size) * ((ceil(real(ram_size) / real(size)) ** 2) / real(NrOfInputs)) ) - integer(1);
    type addr_result_arr_type is array (integer range size**2-1 downto 0) of addr_result_type;
    
    

    signal translated_output : addr_result_arr_type;
    
    
    
    
    
    
    
begin
    
    
    
    --We make a latch here, because of the blockValid. Not perfect. Consider what to do.
    /* process(all) is
begin
    for i in 0 to size**2-1 loop
        if blockValid(i) = '1' then
            depth_addr_arr(blocknr_arr(i)) <= depth_addr_arr2(i) + depth;
        end if;
    end loop;
    end process;*/


    --This implementation can be seen as a crossbar or as an OR gate network. Let synthesis tool decode it.
    /* This is tested and works in simulation.
    process(all) is
    begin
        for i in 0 to size**2-1 loop
            depth_addr_arr(i) <= 0;
        end loop;

        for j in 0 to size**2-1 loop
            if blockValid(j) = '1' then
                depth_addr_arr(blocknr_arr(j)) <= depth_addr_arr2(j) + depth;
            end if;
        end loop;
    end process;*/
    
    gen_crossbar: 
    for i in 0 to size**2-1 generate
        gen_crossbar2:
        for j in 0 to size**2-1 generate
            process(all) is
            begin
                if blockValid(i) = '0' then
                    translated_output(i)(j) <= 0;
                else
                    if blocknr_arr(i) = j then
                        translated_output(i)(j) <= depth_addr_arr2(j) + depth;
                    else
                        translated_output(i)(j) <= 0;
                    end if;
                end if;
            end process;
        end generate;
    end generate;
    
    gen_crossbar_receive:
    for i in 0 to size**2-1 generate
        process(all) is 
            variable tmp : unsigned(10 downto 0) ;
        begin
            tmp := (others => '0');
            for j in 0 to size**2-1 loop
                tmp := tmp OR to_unsigned(translated_output(i)(j),11);
            end loop;
            
            depth_addr_arr(i) <= to_integer(tmp);
        end process;
    end generate;

    
    
    process(clk, rst) is
    begin
        
        if rst = '1' then
            latchedInput <= (others => (others => '0'));
            latchedDepth <= 0;
            latchedAddrX <= 0;
            latchedAddrY <= 0;

            counter <= NrOfInputs - 1;
            
            addressX_reg <= 0;
            addressY_reg <= 0;
                        
            
            blocknr_arr_reg <= (others => 0);
        elsif rising_edge(clk) then
            addressX_reg <= addressX;
            addressY_reg <= addressY;       
        
            blocknr_arr_reg <= blocknr_arr;
        
            if wea  = '1' then
                latchedInput <= dia;
                latchedDepth <= depth;
                latchedAddrX <= addressX;
                latchedAddrY <= addressY;
                


                counter <= 0;
            elsif counter < NrOfInputs - 1 then
                counter <= counter + 1;
            end if;
        end if;
    end process;
    
    ready <= '1' when counter = NrOfInputs - 1 else '0';
    
    
    process(all) is
    begin
        if counter < NrOfInputs then
            
        else
            
        end if;
    end process;
    
    ramGen : for i in 0 to size **2 - 1 generate
        ram_inst: ram
            generic map (
                depth  => depth_size,
                width  => ram_size,
                filter_width => size
            )
            port map (
                clk   => clk,
                ena   => ena,
                enb   => ena,--enb,
                addra => depth_addr_added,
                addrb => depth_addr_arr(i),--addrb,
                wea   => wea_int(i),
                web   => '0',--web,
                dia   => muxData,
                dib   => (others => '0'),--dib,
                doa   => open,
                dob   => doa_int(i)
            );
    end generate;
    
    
    
    depth_addr_added <= depth_addr + counter + latchedDepth;
    
    process(all) is
    begin
        muxData <= latchedInput(counter);
    end process;

    
    
    ramProcess: process (all) is
    begin
        --if ena = '1' then
            for x in -size/2 to size/2 loop
                for y in -size/2 to size/2 loop
                 
                    if addressX_reg + x < 0 or addressX_reg + x >= ram_size or addressY_reg + y < 0 or addressY_reg + y >= ram_size then
                        doa((x+2)*size + (y+2)) <= (others => '0');
                    else
                        doa((x+2)*size + (y+2)) <= doa_int(blocknr_arr_reg((x+2)*size + y + 2));
                    end if;
                end loop;
            end loop;
        --end if;
    end process;

    

    
    
    
    

    --Generate translators for all the outputs of portB.
    gen_trans: for I in 0 to size - 1 generate
        gen_trans2: for J in 0 to size - 1 generate
            addressTranslator_inst: addressTranslator
                generic map (
                    depth_size => depth_size,
                    size       => size,
                    ram_size   => ram_size,
                    NrOfInputs => NrOfInputs
                )
                port map (
                    addressX   => addressX + (-size/2 + i),
                    addressY   => addressY + (-size/2 + j),
                    blocknr    => blocknr_arr(I + j*size),
                    blockValid => blockValid(I + j*size),
                    depth_addr => depth_addr_arr2(I + j*size)
                );
        end generate;
    end generate; 
    
    

    
   
    --We only look at a single address on the way in.
    addressTranslator_inst: addressTranslator
        generic map (
                depth_size => depth_size,
                size       => size,
                ram_size   => ram_size,
                NrOfInputs => NrOfInputs
        )
        port map (
            addressX   => latchedAddrX,
            addressY   => latchedAddrY,
            blocknr    => blocknr,
            blockValid => open,
            depth_addr => depth_addr
        );
   
    --We look at the translated address and decode if it should be a write enable.
    process(all) is
    begin
        --Set we to low as default.
        for i in 0 to size**2 - 1 loop
            wea_int(i) <= '0';
        end loop;
        
        --enable the ram corresponding to the chosen block.
        wea_int(blocknr) <= '1';
        
    end process;

end architecture;