 -- Author Group 18, Fletcher Bunn, Areeb Khan
library ieee;
use ieee.std_logic_1164.all;



entity PB_Inverters IS 

port (
   
   pb_n 	: in  std_logic_vector(3 downto 0);--Input
	pb 	: out  std_logic_vector(3 downto 0) -- Output
	
	);



end PB_inverters;

architecture gates of PB_Inverters IS 

begin
   pb <= not(pb_n); --Inverts
						
end gates; 
