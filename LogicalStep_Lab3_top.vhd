library ieee;
use ieee.std_logic_1164.all;


entity LogicalStep_Lab3_top is port (
	clkin_50		: in 	std_logic;
	pb_n			: in	std_logic_vector(3 downto 0);
 	sw   			: in  std_logic_vector(7 downto 0); 	
	
	----------------------------------------------------
--	HVAC_temp : out std_logic_vector(3 downto 0); -- used for simulations only. Comment out for FPGA download compiles.
	----------------------------------------------------
	
   leds			: out std_logic_vector(7 downto 0);
   seg7_data 	: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  : out	std_logic;				    		-- seg7 digit1 selector
	seg7_char2  : out	std_logic				    		-- seg7 digit2 selector
	
); 
end LogicalStep_Lab3_top;

architecture design of LogicalStep_Lab3_top is
--
-- Provided Project Components Used
------------------------------------------------------------------- 

component SevenSegment  port (
   hex	   :  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
   sevenseg :  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
); 
end component SevenSegment;


component U_D_Bin_Counter8bit port 
(
    CLK          : in std_logic ;
    RESET        : in std_logic ;
    CLK_EN       : in std_logic ;
    UP1_DOWN0    : in std_logic ;
    COUNTER_BITS : out std_logic_vector(7 downto 0) 
    ); 
end component U_D_Bin_Counter8bit ;

component segment7_mux port (
          clk        : in  std_logic := '0';
			 DIN2 		: in  std_logic_vector(6 downto 0);	
			 DIN1 		: in  std_logic_vector(6 downto 0);
			 DOUT			: out	std_logic_vector(6 downto 0);
			 DIG2			: out	std_logic;
			 DIG1			: out	std_logic
        );
end component segment7_mux;
--	
component Tester port (
 MC_TESTMODE				: in  std_logic;
 I1EQI2,I1GTI2,I1LTI2	: in	std_logic;
	input1					: in  std_logic_vector(3 downto 0);
	input2					: in  std_logic_vector(3 downto 0);
	TEST_PASS  				: out	std_logic							 
	); 
end component;
	
component HVAC 	port (
	HVAC_SIM					: in boolean;
	clk						: in std_logic; 
	run		   			: in std_logic;
	increase, decrease	: in std_logic;
	temp						: out std_logic_vector (3 downto 0)
	);
end component;
------------------------------------------------------------------
-- Add any Other Components here

component Compx4 is
	port (
		inputA 			: in std_logic_vector(3 downto 0); 
		inputB		 		: in std_logic_vector(3 downto 0); 
		AGTB				: out std_logic; -- output if A>B
		AEQB				: out std_logic; -- output if A=B
		ALTB				: out std_logic  -- output if A<B
	);

end component Compx4;

component PB_Inverters is
	port (
		pb_n 	: in  std_logic_vector(3 downto 0);
	pb 	: out  std_logic_vector(3 downto 0)
	);

end component PB_Inverters;



component Bidir_shift_reg is
		port (
		CLK			: in std_logic :='0';
		RESET			: in std_logic :='0';
	CLK_EN   : in std_logic :='0';	
		LEFT0_RIGHT1: in std_logic :='0'; 
		REG_BITS	: out std_logic_vector(7 downto 0)
		 
);

end component Bidir_shift_reg;





component TwotoOne is
port(	desiredtemp :  in  std_logic_vector(3 downto 0);   -- Concatenate input
   vacationtemp :  in  std_logic_vector(3 downto 0);   -- Sum Input
	vacationmode: in std_logic;									-- Selector	
	muxtemp	:  out  std_logic_vector(3 downto 0)   -- Output
		 
);

end component TwotoOne;



component EnergyMonitor is
	port(input1,input2,input3 : in std_logic;	
	vacationmode,MCtestmode,windowopen, dooropen : in std_logic;	
	furnace,attemp, AC,blower,window,door,vacation,decrease,increase,run : out std_logic
		 
);

end component EnergyMonitor;


 
------------------------------------------------------------------

------------------------------------------------------------------	
-- Create any additional internal signals to be used
------------------------------------------------------------------	
constant HVAC_SIM : boolean := FALSE; -- set to FALSE when compiling for FPGA download to LogicalStep board 
                                      -- or TRUE for doing simulations with the HVAC Component
------------------------------------------------------------------	

-- global clock
signal clk_in					: std_logic;
signal hex_A, hex_B 			: std_logic_vector(3 downto 0);
signal hexA_7seg, hexB_7seg: std_logic_vector(6 downto 0);
signal pb 	      : std_logic_vector(3 downto 0);
signal muxtemp : std_logic_vector(3 downto 0);
signal run: std_logic;
signal increase : std_logic;
signal decrease : std_logic;
signal currenttemp : std_logic_vector(3 downto 0);
signal AGTB : std_logic;
signal AEQB: std_logic;
signal ALTB : std_logic;


------------------------------------------------------------------- 
begin -- Here the circuit begins

clk_in <= clkin_50;	--hook up the clock input

-- temp inputs hook-up to internal busses.
hex_A <= sw(3 downto 0);
hex_B <= sw(7 downto 4);
pb <=pb(3 downto 0);




--inst5: Bidir_shift_reg port map (clk_in, NOT(pb_n(0)), sw(0), sw(1), leds(7 downto 0));
--inst6 :U_D_Bin_Counter8bit port map (clk_in, not(pb_n(0)), sw(0), sw(1), leds(7 downto 0));


tootoone: TwotoONe port map(hex_A,hex_B,pb(3),muxtemp);
inverters: PB_Inverters port map (pb_n,pb);
aitchVAC: HVAC port map (HVAC_SIM, clk_in, run, increase, decrease, currenttemp);
inst1: sevensegment port map (currenttemp, hexA_7seg);
inst2: sevensegment port map (muxtemp, hexB_7seg);
inst3: segment7_mux port map (clk_in, hexB_7seg, hexA_7seg, seg7_data, seg7_char2, seg7_char1);
inst4: Compx4 port map (muxtemp, currenttemp, AGTB, AEQB, ALTB);
testoicleser: Tester port map (pb(2),AEQB, AGTB, ALTB,hex_A,currenttemp,leds(6));
energy: EnergyMonitor port map (AGTB, AEQB, ALTB, pb(3), pb(2), pb(1), pb(0), leds(0), leds(1), leds(2), leds(3), leds(4), leds(5),leds(7), decrease, increase, run);


end design;

