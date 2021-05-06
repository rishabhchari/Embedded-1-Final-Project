library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity gcd2digits is
  Port (clk,rst : in std_logic; 
        gcd : in std_logic_vector(3 downto 0); 
        dig_1 : out std_logic_vector(7 downto 0); 
        dig_10 : out std_logic_vector(7 downto 0)); 
end gcd2digits;

architecture gcd2digits of gcd2digits is

begin

    process(clk,rst) 
    begin 
        if rst = '1' then 
            dig_1 <= (others => '0'); 
            dig_10 <= (others => '0'); 
        elsif(rising_edge(clk)) then 
            dig_1 <= std_logic_vector(to_unsigned((to_integer(unsigned(gcd)) mod 10),8) + 48); 
            
            if unsigned(gcd) < to_unsigned(10,8) then 
                dig_10 <= X"20";  -- if gcd is less than 10 then there is no 10's digit
            elsif unsigned(gcd) < to_unsigned(20,8) then 
                dig_10 <= X"31"; -- if gcd is greater than 10 then the 10's digit = 1. 
            end if; 
            
        end if; 
    end process; 
end gcd2digits;
