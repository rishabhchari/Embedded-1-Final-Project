library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_div_tb is
end clk_div_tb;

architecture testbench of clk_div_tb is
    
    component clk_div is 
        port(clk :  in std_logic;
             div : out std_logic);     
    end component; 
    
    signal tb_clk  : std_logic := '0';
    signal tb_div : std_logic;
    
begin
    clock_gen : process
    begin 
        wait for 4 ns;
        tb_clk <= '1';
        
        wait for 4 ns; 
        tb_clk <= '0';
        
    end process clock_gen;
    
      
    dut : clk_div
    port map( clk => tb_clk,
              div => tb_div);
                
end testbench;