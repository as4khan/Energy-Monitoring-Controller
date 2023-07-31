library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity TwotoOne is port (
   
   desiredtemp :  in  std_logic_vector(3 downto 0);   -- Concatenate input
   vacationtemp :  in  std_logic_vector(3 downto 0);   -- Sum Input
	vacationmode: in std_logic;									-- Selector	
	muxtemp	:  out  std_logic_vector(3 downto 0)   -- Output
	
); 
end TwotoOne;

architecture Behavioral of TwotoOne is


begin
   with vacationmode select						                   
	muxtemp 	<= desiredtemp when '0', -- Concatenate input is outputted due to inversion
	         vacationtemp when '1'; 
end architecture Behavioral; 