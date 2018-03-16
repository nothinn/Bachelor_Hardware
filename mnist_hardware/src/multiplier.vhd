----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.03.2018 10:09:24
-- Design Name: 
-- Module Name: multiplier - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
    use IEEE.STD_LOGIC_1164.all;
--use IEEE.STD_LOGIC_SIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
    use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity multiplier is
    port ( clk : in std_logic;--Main clock
           SW : in STD_LOGIC_VECTOR (15 downto 0);
           LED : out STD_LOGIC_VECTOR (15 downto 0));
end multiplier;



architecture Behavioral of multiplier is

    type state_type is(idle, one, two);



    signal B : signed(15 downto 0) ;
    signal A : signed(15 downto 0) ;
    signal D : signed(15 downto 0);

    signal t1, t2: signed(15 downto 0);


    signal m1, m2: signed(15 downto 0);

    signal p, mout : signed(31 downto 0);

    
    signal try: signed(3 downto 0) := "1000";
    
begin


    B <= signed(mout(15 downto 0));
    A <= signed(sw);

    D <= (others=> '0');

    t1 <= A;
    t2 <= D;
    p <= mout;
    Multiplier: process(clk)
    begin
        if rising_edge(clk) then

            m2 <= t1 - t2;
            m1 <= B;
            
            mout <= m1 * m2;



        end if;
    end process;
    
    process(all)
    begin

    end process;

    LED <= std_logic_vector(p(15 downto 0));

end Behavioral;
