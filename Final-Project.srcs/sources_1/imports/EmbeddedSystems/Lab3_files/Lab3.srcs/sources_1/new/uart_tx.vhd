library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity uart_tx is
  Port ( clk,en,send,rst : in std_logic;
         char : in std_logic_vector(7 downto 0);
         ready,tx : out std_logic);
end uart_tx;

architecture fsm of uart_tx is
    type state is (idle,start,data);
    signal PS : state := idle;
    signal d : std_logic_vector(7 downto 0) := (others => '0');

        
begin
    fsm : process(clk)
        variable count : integer := 0; 
    begin 
        if(rising_edge(clk)) then 
            if(rst = '1') then
                d <= (others => '0');
                count := 0;
                tx <= '1';
                ready <= '1';
                PS <= idle;
            elsif( en = '1') then 
                case PS is     
                    when idle => 
                        tx <= '1';
                        ready <= '1';
                        if (send = '1') then 
                            d <= char;
                            PS <= start;
                        else 
                            PS <= idle;
                        end if;
                    when start => 
                        ready <= '0';
                        count := 0;
                        tx <= '0'; --start bit 
                        PS <= data;
                    when data => 
                        if (count < 8) then 
                            tx <= d(count); -- 8 data bits 
                            count := count + 1;
                            PS <= data;
                        else
                            tx <= '1'; --stop bit
                            count := 0;  
                            PS <= idle; 
                        end if;
                   when others =>  
                        PS <= idle;
                end case; 
            end if;
        end if;           
    end process;                 
                        
end fsm;
