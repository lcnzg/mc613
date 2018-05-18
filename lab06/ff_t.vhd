LIBRARY ieee ; 
USE ieee.std_logic_1164.all ; 


ENTITY ff_t IS 
	PORT ( 
		T, Clk : IN STD_LOGIC ; 
		Q ,Q_n : OUT STD_LOGIC;
		Preset, Clear : IN STD_LOGIC
		);
END ff_t ;


ARCHITECTURE Behavior OF ff_t IS  

	SIGNAL temp: std_logic;

  
BEGIN
	PROCESS (Clk)
	
	BEGIN 
		IF Clk'EVENT AND Clk = '1' AND T = '1' THEN 
			temp <= NOT temp ;
			
		ELSIF Clk'EVENT AND Clk = '1' AND T = '0' THEN
			temp <= temp ;			
		END IF ;
		
		IF Clk'EVENT AND Clk = '1' AND Preset = '1' THEN 
			temp <= '1' ;
		END IF ;
		
		IF Clk'EVENT AND Clk = '1' AND Clear = '1' THEN 
			temp <= '0' ;
		END IF ;
			
		Q <= temp;
		Q_n <= NOT temp;	
		
	END PROCESS ; 
END Behavior ; 
