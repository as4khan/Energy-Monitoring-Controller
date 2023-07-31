library ieee;
use ieee.std_logic_1164.all;

entity Compx4 is
port (
		inputA 			: in std_logic_vector(3 downto 0); 
		inputB		 		: in std_logic_vector(3 downto 0); 
		AGTB				: out std_logic;
		AEQB				: out std_logic;
		ALTB				: out std_logic  
);

end entity Compx4;

architecture comp_main_logic of Compx4 is

component Compx1 port (        
		A			: in std_logic;
		B			: in std_logic;
		Bigger			: out std_logic;
		Equal			: out std_logic;
		Smaller			: out std_logic
		);
end component;

	signal A0GTB0	: std_logic;
	signal A0EQB0	: std_logic;
	signal A0LTB0	: std_logic;
	
	signal A1GTB1	: std_logic;
	signal A1EQB1	: std_logic;
	signal A1LTB1	: std_logic;

	signal A2GTB2	: std_logic;
	signal A2EQB2	: std_logic;
	signal A2LTB2	: std_logic;
	
	signal A3GTB3	: std_logic;
	signal A3EQB3	: std_logic;
	signal A3LTB3	: std_logic;

	

	
	

begin


	INST1 : Compx1 port map(inputA(3), inputB(3), A3GTB3, A3EQB3, A3LTB3); 
	INST2 : Compx1 port map(inputA(2), inputB(2), A2GTB2, A2EQB2, A2LTB2);
	INST3 : Compx1 port map(inputA(1), inputB(1), A1GTB1, A1EQB1, A1LTB1); 
	INST4 : Compx1 port map(inputA(0), inputB(0), A0GTB0, A0EQB0, A0LTB0);

-- Logic for getting the values of output of the 4-bit comparator
	AGTB <= A3GTB3 OR (A3EQB3 AND A2GTB2) OR ( A2EQB2 AND A3EQB3 AND A1GTB1) OR (A1EQB1 AND A2EQB2 AND A3EQB3 AND A0GTB0);
	AEQB<= A3EQB3 AND A2EQB2 AND A1EQB1 AND A0EQB0;
	ALTB <= A3LTB3 OR (A3EQB3 AND A2LTB2) OR (A2EQB2 AND A3EQB3 AND A1LTB1 ) OR (A1EQB1 AND A2EQB2 AND A3EQB3 AND A0LTB0);

end comp_main_logic;