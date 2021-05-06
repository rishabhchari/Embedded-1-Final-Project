library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity processor is
  Port (clk,rst,en,ready,newChar : in std_logic;
        charIn : in std_logic_vector(7 downto 0); 
        char_0 : out std_logic_vector(7 downto 0);
        char_1 : out std_logic_vector(7 downto 0);
        char_2 : out std_logic_vector(7 downto 0);
        char_3 : out std_logic_vector(7 downto 0);
        char_4 : out std_logic_vector(7 downto 0);
        char_5 : out std_logic_vector(7 downto 0);
        char_6 : out std_logic_vector(7 downto 0);
        char_7 : out std_logic_vector(7 downto 0); 
        char_8 : out std_logic_vector(7 downto 0);
        char_9 : out std_logic_vector(7 downto 0);
        char_10 : out std_logic_vector(7 downto 0);
        char_11 : out std_logic_vector(7 downto 0);
        char_12 : out std_logic_vector(7 downto 0);
        char_13 : out std_logic_vector(7 downto 0);
        char_14 : out std_logic_vector(7 downto 0);
        char_15 : out std_logic_vector(7 downto 0));
end processor;

architecture processor of processor is
type state is (idle,busyA,busyB,busyC); 
    signal PS : state := idle;
    
begin

    fsm: process(clk) 
        variable count : natural := 0; 
    begin 
        if rising_edge(clk) then 
            if en = '1' then 
                if rst = '1' then 
                    char_0 <= (others => '0'); 
                    char_1  <= (others => '0'); 
                    char_2  <= (others => '0'); 
                    char_3  <= (others => '0'); 
                    char_4  <= (others => '0'); 
                    char_5  <= (others => '0'); 
                    char_6  <= (others => '0'); 
                    char_7  <= (others => '0'); 
                    char_8  <= (others => '0'); 
                    char_9  <= (others => '0'); 
                    char_10 <= (others => '0'); 
                    char_11 <= (others => '0'); 
                    char_12 <= (others => '0'); 
                    char_13 <= (others => '0'); 
                    char_14 <= (others => '0'); 
                    char_15 <= (others => '0'); 
                    count := 0; 
                    PS <= idle;
                else 
                    case PS is 
                        when idle => 
                            if newChar = '1' then 
                                if count = 0 then 
                                    char_0 <= charIn; 
                                    count := count+1; 
                                    PS <= busyA;
                                elsif count = 1 then 
                                    char_1 <= charIn;
                                    count := count+1;
                                    PS <= busyA;
                                elsif count = 2 then 
                                    char_2 <= charIn;
                                    count := count + 1;
                                    PS <= busyA;
                               elsif count = 3 then 
                                    char_3 <= charIn;
                                    count := count + 1;
                                    PS <= busyA;
                               elsif count = 4 then 
                                    char_4 <= charIn;
                                    count := count+1;
                                    PS <= busyA;
                              elsif count = 5 then 
                                    char_5 <= charIn;
                                    count := count + 1;
                                    PS <= busyA;      
                              elsif count = 6 then 
                                    char_6 <= charIn;
                                    count := count + 1;
                                    PS <= busyA;
                              elsif count = 7 then 
                                    char_7 <= charIn;
                                    count := count + 1;
                                    PS <= busyA;
                              elsif count = 8 then 
                                    char_8 <= charIn;
                                    count := count + 1;
                                    PS <= busyA;
                              elsif count = 9 then
                                    char_9 <= charIn;
                                    count := count + 1;
                                    PS <= busyA;
                              elsif count = 10 then
                                    char_10 <= charIn;
                                    count := count + 1;
                                    PS <= busyA;
                              elsif count = 11 then
                                    char_11 <= charIn;
                                    count := count + 1;
                                    PS <= busyA;   
                              elsif count = 12 then 
                                    char_12 <= charIn;
                                    count := count + 1;
                                    PS <= busyA;
                              elsif count = 13 then 
                                    char_13 <= charIn;
                                    count := count + 1;
                                    PS <= busyA;
                              elsif count = 14 then 
                                    char_14 <= charIn;
                                    count := count + 1;
                                    PS <= busyA;
                              elsif count = 15 then 
                                    char_15 <= charIn;
                                    count := count + 1;
                                    PS <= busyA;
                              else 
                                   if rst = '1' then 
                                    char_0 <= (others => '0'); 
                                    char_1  <= (others => '0'); 
                                    char_2  <= (others => '0'); 
                                    char_3  <= (others => '0'); 
                                    char_4  <= (others => '0'); 
                                    char_5  <= (others => '0'); 
                                    char_6  <= (others => '0'); 
                                    char_7  <= (others => '0'); 
                                    char_8  <= (others => '0'); 
                                    char_9  <= (others => '0'); 
                                    char_10 <= (others => '0'); 
                                    char_11 <= (others => '0'); 
                                    char_12 <= (others => '0'); 
                                    char_13 <= (others => '0'); 
                                    char_14 <= (others => '0'); 
                                    char_15 <= (others => '0'); 
                                    count := 0; 
                                    PS <= idle; 
                                  end if; 
                              end if; 
                            end if; 
                        when busyA => 
                            PS <= busyB;
                        when busyB => 
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
end processor;
