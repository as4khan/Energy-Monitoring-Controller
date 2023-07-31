library ieee;
use ieee.std_logic_1164.all;

entity Compx1 is
		port (
		A			: in std_logic;
		B			: in std_logic; 
		Bigger			: out std_logic; 
		Equal			: out std_logic; 
		Smaller	: out std_logic 
);

end entity Compx1;

architecture comparator of Compx1 is

begin

	Bigger <= A AND NOT(B); 
	Equal <= A XNOR B; 
	Smaller <= NOT(A) AND B; 
	end comparator;