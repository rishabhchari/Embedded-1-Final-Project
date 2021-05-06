library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Top_Level is
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
end Top_Level;

architecture Top_Level of Top_Level is
      component clk_div 
      port ( clk : in std_logic;
             div : out std_logic);
      end component;
      
      component debounce
      port (clk : in std_logic;
            btn : in std_logic;
            dbnc : out std_logic);
      end component;
      
      
      component uart 
      port (clk, en, send, rx, rst      : in std_logic;
            charSend                    : in std_logic_vector (7 downto 0);
            ready, tx, newChar          : out std_logic;
            charRec                     : out std_logic_vector (7 downto 0));
      end component;
      
      component processor 
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
      end component;
      
      
      
      component PmodOLEDCtrl
      Port ( 
              CLK     : in  STD_LOGIC;
              RST     : in  STD_LOGIC;
              char0_sig : in std_logic_vector(7 downto 0);
              char1_sig : in std_logic_vector(7 downto 0); 
              char2_sig : in std_logic_vector(7 downto 0); 
              char3_sig : in std_logic_vector(7 downto 0); 
              char4_sig : in std_logic_vector(7 downto 0); 
              char5_sig : in std_logic_vector(7 downto 0); 
              char6_sig : in std_logic_vector(7 downto 0); 
              char7_sig : in std_logic_vector(7 downto 0); 
              char8_sig : in std_logic_vector(7 downto 0); 
              char9_sig : in std_logic_vector(7 downto 0);
              char10_sig : in std_logic_vector(7 downto 0);  
              char11_sig : in std_logic_vector(7 downto 0); 
              char12_sig : in std_logic_vector(7 downto 0); 
              char13_sig : in std_logic_vector(7 downto 0); 
              char14_sig : in std_logic_vector(7 downto 0); 
              char15_sig : in std_logic_vector(7 downto 0); 
              CS      : out STD_LOGIC;
              SDIN    : out STD_LOGIC;
              SCLK    : out STD_LOGIC;
              DC        : out STD_LOGIC;
              RES    : out STD_LOGIC;
              VBAT    : out STD_LOGIC;
              VDD    : out STD_LOGIC);
      end component;
        
    signal div_en : std_logic;
    signal dbnc_rst : std_logic;
    signal intr_charRec : std_logic_vector(7 downto 0); 
    signal intr_newChar : std_logic; 
    signal dbnc_send : std_logic; 
    
    signal intr_ready : std_logic;
    signal intr_send : std_logic;
    signal intr_charSend : std_logic_vector(7 downto 0); 

    signal intr_char0 : std_logic_vector(7 downto 0); 
    signal intr_char1 : std_logic_vector(7 downto 0); 
    signal intr_char2 : std_logic_vector(7 downto 0);
    signal intr_char3 : std_logic_vector(7 downto 0);
    signal intr_char4 : std_logic_vector(7 downto 0);
    signal intr_char5 : std_logic_vector(7 downto 0);
    signal intr_char6 : std_logic_vector(7 downto 0);
    signal intr_char7 : std_logic_vector(7 downto 0); 
    signal intr_char8 : std_logic_vector(7 downto 0); 
    signal intr_char9 : std_logic_vector(7 downto 0);
    signal intr_char10 : std_logic_vector(7 downto 0); 
    signal intr_char11 : std_logic_vector(7 downto 0); 
    signal intr_char12 : std_logic_vector(7 downto 0); 
    signal intr_char13 : std_logic_vector(7 downto 0); 
    signal intr_char14 : std_logic_vector(7 downto 0); 
    signal intr_char15 : std_logic_vector(7 downto 0);  
   
begin

                
Debounce_RST : debounce 
port map(clk => CLK, 
         btn => RST, 
         dbnc => dbnc_RST); 
         
en : clk_div 
port map(clk => CLK, 
         div => div_en); 
         

         
            
U_Art : uart 
port map(clk => CLK, 
         en => div_en, 
         rx => TXD,
         rst => dbnc_RST, 
         send => '0',
         charSend => (others => '0'),
         charRec => intr_charRec,
         newChar => intr_newChar,
         ready => intr_ready, 
         tx => open); 
          
        
pRoc : processor         
port map(clk => CLK,
         rst => dbnc_RST,
         en => div_en,
         ready => intr_ready, 
         newChar => intr_newChar,
         charIn => intr_charRec, 
         char_0 => intr_char0,
         char_1 => intr_char1,
         char_2 => intr_char2,
         char_3 => intr_char3,
         char_4 => intr_char4,
         char_5 => intr_char5,
         char_6 => intr_char6,
         char_7 => intr_char7,
         char_8 => intr_char8,
         char_9 => intr_char9,
         char_10 => intr_char10,
         char_11 => intr_char11,
         char_12 => intr_char12,
         char_13 => intr_char13,
         char_14 => intr_char14,
         char_15 => intr_char15); 
         
            

OLED : PmodOLEDCtrl
port map(CLK => CLK,     
         RST => dbnc_RST,    
         char0_sig => intr_char0,
         char1_sig => intr_char1 ,
         char2_sig => intr_char2 ,
         char3_sig => intr_char3,
         char4_sig => intr_char4,
         char5_sig => intr_char5,
         char6_sig => intr_char6,
         char7_sig => intr_char7,
         char8_sig => intr_char8,
         char9_sig => intr_char9,
         char10_sig => intr_char10,
         char11_sig => intr_char11,
         char12_sig => intr_char12,
         char13_sig => intr_char13,
         char14_sig => intr_char14,
         char15_sig => intr_char15,
         CS => CS,
         SDIN => SDIN,
         SCLK => SCLK,
         DC => DC,
         RES => RES,
         VBAT => VBAT,
         VDD => VDD);
         
          
CTS <= '0'; 
RTS <= '0';          

end Top_Level;

