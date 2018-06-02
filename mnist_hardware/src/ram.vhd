library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;
    use work.Types.all;
    use IEEE.MATH_REAL.all;  
entity ram is
    generic(
        depth: integer := 64;
        width: integer := 7;
        filter_width: integer := 5
    );
    port (
        clk: in  std_logic;

        ena: in std_logic;
        enb: in std_logic;
        
        addra: in integer;
        addrb: in integer;
        
        wea: in std_logic;
        web: in std_logic;
        
        
        dia: in MAC_result;
        dib: in MAC_result;
        
        doa: out MAC_result;
        dob: out MAC_result
        
    );  
end entity;

architecture rtl of ram is
   
    shared variable RAM : mem_block((depth * integer((Ceil(real(width)/real(filter_width)))) **2 - 1) downto 0);

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if ena = '1' then
                doa <= ram(addra mod (depth * integer((Ceil(real(width)/real(filter_width)))) **2 ));
                if wea = '1' then
                    ram(addra) := dia;
                end if;
            end if;
        end if;
    end process;
    
    process(clk)
    begin
        if rising_edge(clk) then
            if enb = '1' then
                dob <= RAM(addrb mod (depth * integer((Ceil(real(width)/real(filter_width)))) **2 ));
                if web = '1' then
                    ram(addrb) := dib;
                end if;
            end if;
        end if;
    end process; 
end architecture;