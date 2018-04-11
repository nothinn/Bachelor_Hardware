library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity fsm is
    port (
        clk: in  std_logic;
        rst: in  std_logic;
        start: in std_logic;
        hold: out std_logic;
        new_calc: out std_logic;
        x : out integer;
        y : out integer;
        depth: out integer
        
    );
end entity;

architecture rtl of fsm is
begin
end architecture;