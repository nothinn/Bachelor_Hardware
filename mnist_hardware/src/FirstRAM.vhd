 library IEEE; 
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;
    use IEEE.std_logic_unsigned.all; 


    use IEEE.math_real.all;

    use work.Types.all;

entity topFirstRam is
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

        deptha: in integer range 0 to depth_size-1;
        addressXa: in  integer range 0 to ram_size-1;
        addressYa: in integer range 0 to ram_size-1;

        depthb: in integer range 0 to depth_size-1;
        addressXb: in  integer range 0 to ram_size-1;
        addressYb: in integer range 0 to ram_size-1;

        dia :  in ram_input(NrOfINputs - 1 downto 0);
        doa : out MAC_inputs;
        
        ready: out std_logic

    );
end entity;

--port a is used for input.
--port b is used for output.

architecture rtl of topFirstRam is

    component addressTranslator is
        generic (
            depth_size :  integer := depth_size;
            size       :  integer := 5;
            ram_size   :  integer := 28;
            NrOfInputs :  integer := 8
        );
        port (
            clk        : in std_logic;
            addressX   : in integer range 0 to ram_size - 1;
            addressY   : in integer range 0 to ram_size - 1;
            valid      : out std_logic;
            blocknr    : out integer range 0 to size ** 2 - 1;
            blockValid : out std_logic;
            depth_addr : out integer
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

    type trans_addr is array(integer range size**2-1 downto 0) of integer;
    
    
    signal depthb_reg : integer range 0 to depth_size-1;

    signal blocknr_arr: trans_block;
    signal blocknr_arr_reg: trans_block;
    signal depth_addr_arr: trans_addr;
    signal depth_addr_arr2: trans_addr;

    signal blocknr: integer;
    signal depth_addr: integer;
    signal depth_addr_added: integer;

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
    signal addressX_reg2: integer range 0 to ram_size-1;
    signal addressY_reg2: integer range 0 to ram_size-1;
    
    
    
    
    
    
    
    
    
    
    ------------------------------------
    -- For OR-ing crossbar
    ------------------------------------
    type addr_result_type is array (integer range size**2-1 downto 0) of integer;
    type addr_result_arr_type is array (integer range size**2-1 downto 0) of addr_result_type;
    
    

    signal translated_output : addr_result_arr_type;
    
    
    
    
    signal blocknr_reg : integer;
    signal depth_addr_reg : integer;



    signal ready2 : std_logic;


    type block_valid_type is array(0 to size**2-1, 0 to size**2-1) of std_logic;
    signal block_valid : block_valid_type;
    
    signal wea_reg : std_logic;
    
    
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
                        translated_output(i)(j) <= depth_addr_arr2(i) + depthb_reg;
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
                tmp := tmp OR to_unsigned(translated_output(j)(i),11);
            end loop;
            
            depth_addr_arr(i) <= to_integer(tmp);
        end process;
    end generate;

    
    
    process(clk, rst) is
    begin
        
        if rst = '1' then
            ready2 <= '1';
            latchedInput <= (others => (others => '0'));
            latchedDepth <= 0;
            latchedAddrX <= 0;
            latchedAddrY <= 0;

            counter <= NrOfInputs - 1;
            
            addressX_reg <= 0;
            addressY_reg <= 0;
            addressX_reg2 <= 0;
            addressY_reg2 <= 0;
                        
            
            blocknr_arr_reg <= (others => 0);
            blocknr_reg <= 0;
            
            depthb_reg <= 0;
            depth_addr_reg <= 0;
            
            wea_reg <= '0';
        elsif rising_edge(clk) then
            ready2 <= ready;
            addressX_reg <= addressXb;
            addressY_reg <= addressYb;       
            addressX_reg2 <= addressX_reg;
            addressY_reg2 <= addressY_reg; 
            blocknr_arr_reg <= blocknr_arr;
            
            depthb_reg <= depthb;
            
            wea_reg <= wea;
            
            if counter = 0 then

                blocknr_reg <= blocknr;
                depth_addr_reg <= depth_addr;
            end if;
            
            if wea  = '1' then
                latchedInput <= dia;
                latchedDepth <= deptha;
                latchedAddrX <= addressXa;
                latchedAddrY <= addressYa;
                


                counter <= 0;
            elsif counter < NrOfInputs - 1 then
                counter <= counter + 1;
            end if;
        end if;
    end process;
    
    ready <= '1' when counter = NrOfInputs - 1 else '0';
    
    
    
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
    
    
    
    
    process(all) is
    begin

        depth_addr_added <= depth_addr + counter + latchedDepth;
            
        for i in 0 to size**2 - 1 loop
            wea_int(i) <= '0';
        end loop;

        --enable the ram corresponding to the chosen block.
        if wea_reg = '1' then
            wea_int(blocknr) <= '1';
        else
            wea_int(blocknr) <= '0';
        end if;

        
        muxData <= latchedInput(counter);
    end process;

    
    
    ramProcess: process (all) is
    begin
        --if ena = '1' then
            for x in -size/2 to size/2 loop
                for y in -size/2 to size/2 loop
                 
                    if addressX_reg2 + x < 0 or addressX_reg2 + x >= ram_size or addressY_reg2 + y < 0 or addressY_reg2 + y >= ram_size then
                        doa((x+2) + (y+2)*size) <= (others => '0');
                    else
                        doa((x+2) + (y+2)*size) <= doa_int(blocknr_arr_reg((x+2) + (y + 2)*size));
                    end if;
                end loop;
            end loop;
        --end if;
    end process;

    
    translateValidProcess: process (all) is
    begin
        --if ena = '1' then
        for x in -size/2 to size/2 loop
            for y in -size/2 to size/2 loop
                if (addressXB + x) < 0 or (addressXB + x) >= ram_size or (addressYB + y) < 0 or (addressYB + y) >= ram_size  then
                    block_valid(x+2,y+2) <= '0';
                else
                    block_valid(x+2,y+2) <= '1';
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
                    clk        => clk,
                    addressX   => addressXb + (-size/2 + i),
                    addressY   => addressYb + (-size/2 + j),
                    valid      => block_valid(i, j),
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
            clk        => clk,
            addressX   => addressXa,
            addressY   => addressYa,
            valid      => wea,
            blocknr    => blocknr,
            blockValid => open,
            depth_addr => depth_addr
        );
   


end architecture;