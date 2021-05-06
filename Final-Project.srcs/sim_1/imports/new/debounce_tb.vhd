library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
Use IEEE.NUMERIC_STD.ALL;

entity debounce_tb is
end debounce_tb;

architecture debounce_tb_arc of debounce_tb is

     component debounce is 
        port(clk : in std_logic;
             btn : in std_logic;
             dbnc : out std_logic);   
     end component; 
    
    signal tb_clk :  std_logic := '0';
    signal tb_btn :  std_logic := '0';
    signal tb_dbnc : std_logic := '0';
    
begin
    -- Generate 125MHz Clock 
    clk_gen : process
    begin 
        wait for 4 ns;
        tb_clk <= '1';
        
        wait for 4 ns; 
        tb_clk <= '0';
        
    end process clk_gen;

    sim : process
    begin 
        tb_btn <= '1';
        wait for 100 ms; 
        tb_btn <= '0';
    
    end process sim;
    
    dut: debounce
    port map( clk => tb_clk,
              btn => tb_btn,
              dbnc => tb_dbnc);
     
             
      
              
end debounce_tb_arc;
