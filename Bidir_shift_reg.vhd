library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Bidir_shift_reg is port (
 	CLK			: in std_logic :='0';
		RESET			: in std_logic :='0';
	CLK_EN   : in std_logic :='0';	
		LEFT0_RIGHT1: in std_logic :='0'; 
		REG_BITS	: out std_logic_vector(7 downto 0)						 
	); 
end Enitity;

architecture one of Bidir_shift_reg is

begin

PROCESS (CLK) is
 
begin
		
		IF (rising_edge(CLK))) THEN 
		
		IF(RESET='1') THEN
		sreg <= "00000000";
		
		
		ELSIF (CLK_EN = '1') THEN  
		 if(LEFT0_RIGHT ='1') THEN
				sreg(7 downto 0) <= '1' & sreg(7 downto 1);
		

		ELSE  
		
		sreg(7 downto 0) <= sreg(6 downto 0) & '0';
		
			END_IF;
			END IF;
			END_IF;
		REG_BITS<= sreg;
		
end process;

end;