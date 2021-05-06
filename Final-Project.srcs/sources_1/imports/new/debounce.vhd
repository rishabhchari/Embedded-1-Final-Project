library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity debounce is
 port (clk : in std_logic;
       btn : in std_logic;
       dbnc : out std_logic);
end debounce;

architecture debounce_arc of debounce is
   signal shift_reg : std_logic_vector(1 downto 0);
   signal count : std_logic_vector(21 downto 0) := (others => '0'); -- 125MHz clock with 20ms debounce time, max value = 2.5 Million ticks
begin

process(clk) 
begin 
    if(rising_edge(clk)) then
      shift_reg(0) <= btn;
      shift_reg(1) <= shift_reg(0);
      if(shift_reg(1) = '1') then  
        count <= std_logic_vector(unsigned(count) + 1); 
        if(unsigned(count) = 2500000) then 
            dbnc <= '1';
            count <= std_logic_vector(unsigned(count));
        else 
            dbnc <= '0';
        end if; 
      else
        count <= (others => '0');  
        dbnc <= '0'; 
      end if;
    end if;
end process;

end debounce_arc;
