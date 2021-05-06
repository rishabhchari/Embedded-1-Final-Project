----------------------------------------------------------------------------------
-- Company: Digilent Inc.
-- Engineer: Ryan Kim
-- 
-- Create Date:    14:35:33 10/10/2011 
-- Module Name:    PmodOLEDCtrl - Behavioral 
-- Project Name:   PmodOLED Demo
-- Tool versions:  ISE 13.2
-- Description:    Top level controller that controls the PmodOLED blocks
--
-- Revision: 1.1
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.ALL;
use ieee.std_logic_arith.all;

entity PmodOLEDCtrl is
	Port ( 
		CLK 	: in  STD_LOGIC;
		RST 	: in  STD_LOGIC;
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
		CS  	: out STD_LOGIC;
		SDIN	: out STD_LOGIC;
		SCLK	: out STD_LOGIC;
		DC		: out STD_LOGIC;
		RES	: out STD_LOGIC;
		VBAT	: out STD_LOGIC;
		VDD	: out STD_LOGIC);
end PmodOLEDCtrl;

architecture Behavioral of PmodOLEDCtrl is

component OledInit is
Port ( CLK 	: in  STD_LOGIC;
		RST 	: in	STD_LOGIC;
		EN		: in  STD_LOGIC;
		CS  	: out STD_LOGIC;
		SDO	: out STD_LOGIC;
		SCLK	: out STD_LOGIC;
		DC		: out STD_LOGIC;
		RES	: out STD_LOGIC;
		VBAT	: out STD_LOGIC;
		VDD	: out STD_LOGIC;
		FIN  : out STD_LOGIC);
end component;

component OledEx is
    Port ( CLK 	: in  STD_LOGIC;
        sig_char0 : in std_logic_vector(7 downto 0);
        sig_char1 : in std_logic_vector(7 downto 0); 
        sig_char2 : in std_logic_vector(7 downto 0); 
        sig_char3 : in std_logic_vector(7 downto 0); 
        sig_char4 : in std_logic_vector(7 downto 0); 
        sig_char5 : in std_logic_vector(7 downto 0); 
        sig_char6 : in std_logic_vector(7 downto 0);
        sig_char7 : in std_logic_vector(7 downto 0);     
		sig_char8 : in std_logic_vector(7 downto 0);  
		sig_char9 : in std_logic_vector(7 downto 0);  
		sig_char10 : in std_logic_vector(7 downto 0);  
		sig_char11 : in std_logic_vector(7 downto 0);  
		sig_char12 : in std_logic_vector(7 downto 0);  
		sig_char13 : in std_logic_vector(7 downto 0);  
		sig_char14 : in std_logic_vector(7 downto 0);  
		sig_char15 : in std_logic_vector(7 downto 0);  
		RST 	: in	STD_LOGIC;
		EN		: in  STD_LOGIC;
		CS  	: out STD_LOGIC;
		SDO		: out STD_LOGIC;
		SCLK	: out STD_LOGIC;
		DC		: out STD_LOGIC;
		FIN  : out STD_LOGIC);
end component; 

type states is (Idle,
					OledInitialize,
					OledExample,
					Done);

signal current_state 	: states := Idle;

signal init_en				: STD_LOGIC := '0';
signal init_done			: STD_LOGIC;
signal init_cs				: STD_LOGIC;
signal init_sdo			: STD_LOGIC;
signal init_sclk			: STD_LOGIC;
signal init_dc				: STD_LOGIC;

signal example_en			: STD_LOGIC := '0';
signal example_cs			: STD_LOGIC;
signal example_sdo		: STD_LOGIC;
signal example_sclk		: STD_LOGIC;
signal example_dc			: STD_LOGIC;
signal example_done		: STD_LOGIC;

begin

	Init: OledInit port map(CLK, RST, init_en, init_cs, init_sdo, init_sclk, init_dc, RES, VBAT, VDD, init_done);
	
	Example: OledEx Port map(CLK => CLK, 
                                     sig_char0 => char0_sig,
                                     sig_char1 => char1_sig,
                                     sig_char2 => char2_sig,
                                     sig_char3 => char3_sig,
                                     sig_char4 => char4_sig,
                                     sig_char5 => char5_sig,
                                     sig_char6 => char6_sig,
                                     sig_char7 => char7_sig,
                                     sig_char8 => char8_sig,
                                     sig_char9 => char9_sig,
                                     sig_char10 => char10_sig,
                                     sig_char11 => char11_sig,
                                     sig_char12 => char12_sig,
                                     sig_char13 => char13_sig,
                                     sig_char14 => char14_sig,
                                     sig_char15 => char15_sig,
                                     RST => RST,  
                                     EN => example_en, 
                                     CS => example_cs, 
                                     SDO =>  example_sdo, 
                                     SCLK => example_sclk,
                                     DC => example_dc, 
                                     FIN =>example_done);
	
	--MUXes to indicate which outputs are routed out depending on which block is enabled
	CS <= init_cs when (current_state = OledInitialize) else
			example_cs;
	SDIN <= init_sdo when (current_state = OledInitialize) else
			example_sdo;
	SCLK <= init_sclk when (current_state = OledInitialize) else
			example_sclk;
	DC <= init_dc when (current_state = OledInitialize) else
			example_dc;
	--END output MUXes
	
	--MUXes that enable blocks when in the proper states
	init_en <= '1' when (current_state = OledInitialize) else
					'0';
	example_en <= '1' when (current_state = OledExample) else
					'0';
	--END enable MUXes
	

	process(CLK)
	begin
		if(rising_edge(CLK)) then
			if(RST = '1') then
				current_state <= Idle;
			else
				case(current_state) is
					when Idle =>
						current_state <= OledInitialize;
					--Go through the initialization sequence
					when OledInitialize =>
						if(init_done = '1') then
							current_state <= OledExample;
						end if;
					--Do example and Do nothing when finished
					when OledExample =>
						if(example_done = '1') then
							current_state <= Done;
						end if;
					--Do Nothing
					when Done =>
						current_state <= Done;
					when others =>
						current_state <= Idle;
				end case;
			end if;
		end if;
	end process;
	
	
end Behavioral;

