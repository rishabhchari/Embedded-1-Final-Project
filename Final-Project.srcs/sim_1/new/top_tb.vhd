library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity top_tb is
end top_tb;

architecture top_tb of top_tb is
    component Top_Level 
    Port (TXD : in std_logic;
            CTS,RTS : out std_logic;
            CLK,RST : in std_logic;
            CS : out STD_LOGIC;
            SDIN : out STD_LOGIC;
            SCLK : out STD_LOGIC;
            DC : out STD_LOGIC;
            RES : out STD_LOGIC;
            VBAT : out STD_LOGIC;
            VDD : out STD_LOGIC);
    end component; 
    
    signal tb_TXD : std_logic;
    signal tb_CTS : std_logic;
    signal tb_RTS : std_logic;
    signal tb_CLK : std_logic;
    signal tb_RST : std_logic;
    signal tb_CS : std_logic;
    signal tb_SDIN : std_logic;
    signal tb_SCLK : std_logic;
    signal tb_DC : std_logic;
    signal tb_RES : std_logic;
    signal tb_VBAT : std_logic;
    signal tb_VDD : std_logic; 


begin

    dut : Top_Level 
    port map(TXD => tb_TXD,
             CTS => tb_CTS,
             RTS => tb_RTS,
             CLK => tb_CLK,
             RST => tb_RST,
             CS => tb_CS,
             SDIN => tb_SDIN,
             SCLK => tb_SCLK,
             DC => tb_DC,
             RES => tb_RES,
             VBAT => tb_VBAT,
             VDD => tb_VDD); 
    
    clock_gen : process
    begin 
        wait for 4 ns;
        tb_CLK <= '1';
        
        wait for 4 ns; 
        tb_CLK <= '0';
        
    end process clock_gen;
    
    sim : process 
    begin
        wait for 4 ms; 
        tb_TXD <= '1';
    end process sim; 
end top_tb;
