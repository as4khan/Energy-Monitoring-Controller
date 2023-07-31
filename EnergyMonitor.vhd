library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity EnergyMonitor is port (
   
   input1,input2,input3 : in std_logic;	
	vacationmode,MCtestmode,windowopen, dooropen : in std_logic;	
	furnace,attemp, AC,blower,window,door,vacation,decrease,increase,run : out std_logic
	
); 
end entity;

architecture Behavioral of EnergyMonitor is


begin
		
		run <=not(input2 or windowopen or dooropen or MCtestmode);
		
	
		
		AC<= input3;
		furnace <= input1;		
		attemp <= input2;
	
		
		blower <= not(input2 or ((MCtestmode)) or (windowopen) or (dooropen));
		
		door <=dooropen;
		window <= windowopen;
		vacation <= vacationmode;
		increase<= input1;
		decrease<=input3;
		
		
		
		
		
		
						
end architecture Behavioral; 