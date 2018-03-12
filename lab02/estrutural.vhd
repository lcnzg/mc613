LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY lab_2_non_minimized IS
	PORT ( A , B , C , D , E : IN STD_LOGIC ;
			 F : OUT STD_LOGIC ) ;
END lab_2_non_minimized ;

ARCHITECTURE Behavior OF lab_2_non_minimized IS
	SIGNAL ent : STD_LOGIC_VECTOR(4 DOWNTO 0) ;
BEGIN
	ent <=  A & B & C & D & E;
	WITH ent SELECT
		F <=  '1' WHEN "00000", --MINTERMO 0
				'1' WHEN "00010", --MINTERMO 2 
				'1' WHEN "00101", --MINTERMO 5
				'1' WHEN "01000", --MINTERMO 8
				'1' WHEN "01101", --MINTERMO 13
				'1' WHEN "01111", --MINTERMO 15
				'1' WHEN "10010", --MINTERMO 18
				'1' WHEN "10101", --MINTERMO 21
				'1' WHEN "11000", --MINTERMO 24
				'1' WHEN "11101", --MINTERMO 29
				'1' WHEN "11111", --MINTERMO 31
				'0' WHEN OTHERS;  --DEMAIS CASOS
END Behavior ;