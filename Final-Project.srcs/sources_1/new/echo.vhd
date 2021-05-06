library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity echo is
  Port (clk,rst,en,ready,newChar : in std_logic;
        charIn : in std_logic_vector(7 downto 0); 
        send : out std_logic;
        charOut : out std_logic_vector(7 downto 0));
end echo;

architecture echo of echo is
type state is (idle,busyA,busyB,busyC); 
    signal PS : state := idle;
    
begin

    fsm: process(clk) 
    begin 
        if rising_edge(clk) then 
            if en = '1' then 
                if rst = '1' then 
                    send <= '0'; 
                    charOut <= (others => '0'); 
                    PS <= idle;
                else 
                    case PS is 
                        when idle => 
                            if newChar = '1' then 
                                send <= '1'; 
                                charOut <= charIn; 
                                PS <= busyA;
                            end if; 
                        when busyA => 
                            PS <= busyB;
                        when busyB => 
                            send <= '0';
                            PS <= busyC; 
                        when busyC => 
                            if ready = '1' then 
                                PS <= idle;
                            end if; 
                        when others => 
                            PS <= idle; 
                    end case; 
                end if; 
            end if;        
        end if;
    end process fsm;     
end echo;
