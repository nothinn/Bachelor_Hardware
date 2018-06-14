library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;
    use work.Types.all;

entity pipeRamInput is
    generic(
        nrOfDelays : integer := 1    
    );
    port (
        clk: in  std_logic;
        rst: in  std_logic;
        
        we_ram : in std_logic;
        addressXout : in integer;
        addressYout : in integer;
        filter      : in integer;
        ram_data    : in ram_input(NrOfINputs - 1 downto 0);
        
        we_ram_piped : out std_logic;
        addressXout_piped : out integer;
        addressYout_piped : out integer;
        filter_piped      : out integer;
        ram_data_piped    : out ram_input(NrOfINputs - 1 downto 0)
        
    );
end entity;

architecture rtl of pipeRamInput is
    
    type we_ram_type is array(nrOfDelays downto 0) of std_logic;
    type addressXout_type is array(nrOfDelays downto 0) of integer;
    type addressYout_type is array(nrOfDelays downto 0) of integer;
    type filter_type is array(nrOfDelays downto 0) of integer;
    type ram_data_type is array(nrOfDelays downto 0) of ram_input(NrOfINputs - 1 downto 0);

    
    signal we_ram_mid : we_ram_type;
    signal addressXout_mid : addressXout_type;
    signal addressYout_mid : addressXout_type;
    signal filter_mid : filter_type;
    signal ram_data_mid : ram_data_type;

begin
    process(all) is
    begin
        we_ram_mid(0) <= we_ram;
        addressXout_mid(0) <= addressXout;
        addressYout_mid(0) <= addressYout;
        filter_mid(0) <= filter;
        ram_data_mid(0) <= ram_data;
        
        if rst = '0' then
            we_ram_mid <= (others => '0');
            addressXout_mid <= (others => 0);
            addressYout_mid <= (others => 0);
            filter_mid <= (others => 0);
            ram_data_mid <= (others => (others => (others => '0')));
            
        elsif rising_edge(clk) then
            
            for i in 1 to nrOfDelays loop
                we_ram_mid(i) <= we_ram_mid(i-1);
                addressXout_mid(i) <= addressXout_mid(i-1);
                addressYout_mid(i) <= addressYout_mid(i-1);
                filter_mid(i) <= filter_mid(i-1);
                ram_data_mid(i) <= ram_data_mid(i-1);
            end loop;
            
        end if;
        
        we_ram_piped <= we_ram_mid(nrOfDelays);
        addressXout_piped <= addressXout_mid(nrOfDelays);
        addressYout_piped <= addressYout_mid(nrOfDelays);
        filter_piped <= filter_mid(nrOfDelays);
        ram_data_piped <= ram_data_mid(nrOfDelays);
            
    end process;
end architecture;