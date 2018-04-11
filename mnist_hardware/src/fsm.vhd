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
        depth: out integer;
        done: out std_logic
        
    );
end entity;

architecture rtl of fsm is
    
    constant XMAX, YMAX: integer := 28;
    

    type state_type is(idle, prep, add, save, finished);
    
    signal state, state_next : state_type;
    
    signal count, count_next: integer;
    
    
    signal xint, xint_next, yint, yint_next, depthin, depthin_next: integer;
    
    signal new_calcint, new_calcint_next: std_logic;
    
begin
    
    x <= xint;
    y <= yint;
    depth <= depthin;
    hold <= '0';
    new_calc <= new_calcint;
    
    process(all)
    begin
        state_next <= state;
        done <= '0';
        new_calcint_next <= '0';
        count_next <= count;
        
        case state is
            when idle =>
                xint_next <= 0;
                yint_next <= 0;
                depthin_next <= 0;
                count_next <= 0;
                
                if start = '1' then
                    state_next <= prep;
                end if;
                
            when prep =>
                new_calcint_next <= '1';
                depthin_next <= 0;
                --count_next <= 0;
                
                state_next <= add;

            when add =>
                
                depthin_next <= depthin +1 ;
                
                if depth = 32 then
                    state_next <= save;
                end if;

            when save =>
                
                count_next <= count + 8;
                
                if count < 32 then
                    state_next <= prep;
                else
                    if xint = XMAX then
                        if yint = YMAX then
                            state_next <= finished;
                        else
                            xint_next <= 0;
                            yint_next <= yint + 1;
                            state_next <= prep;
                        end if;
                        
                    else
                        xint_next <= xint + 1;
                        state_next <= prep;
                    end if;
                end if;
                
                
            when finished =>
                done <= '1';
                if start = '0' then
                    state_next <= idle;
                end if;
        end case;
    end process;
    
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                state <= idle;
                xint <= 0;
                yint <= 0;
                depthin <= 0;
                count <= 0;
                new_calcint <= '0';
            else
                state <= state_next;
                xint <= xint_next;
                yint <= yint_next;
                depthin <= depthin_next;
                count <= count_next;
                new_calcint <= new_calcint_next;
            end if;
        end if;
    end process;
    
end architecture;