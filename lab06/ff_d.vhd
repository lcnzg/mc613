LIBRARY ieee ; 
USE ieee.std_logic_1164.all ; 


ENTITY ff_d IS 
	PORT ( 
		D, Clk: IN STD_LOGIC ;
		Q ,Q_n : OUT STD_LOGIC ;
		Preset, Clear : IN STD_LOGIC
	);
END ff_d ;

ARCHITECTURE Behavior OF ff_d IS    
BEGIN
	PROCESS (Clk) 
	VARIABLE temp: std_logic;
	
	BEGIN 
		IF Clk'EVENT AND Clk = '1' THEN 
			temp := D ;		
		END IF ;
		
		IF Clk'EVENT AND Clk = '1' AND Preset = '1' THEN 
			temp := '1' ;
		END IF ;
		
		IF Clk'EVENT AND Clk = '1' AND Clear = '1' THEN 
			temp := '0' ;
		END IF ;
			
		Q <= temp;
		Q_n <= NOT temp;	
		
	END PROCESS ; 
END Behavior ; 
