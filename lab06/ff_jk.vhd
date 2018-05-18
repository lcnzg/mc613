LIBRARY ieee ; 
USE ieee.std_logic_1164.all ; 

ENTITY ff_jk IS 
	PORT ( 
		J,K,Clk : IN STD_LOGIC ; 
		Q ,Q_n : OUT STD_LOGIC ; 
		Preset,Clear : IN STD_LOGIC
	);
END ff_jk;



ARCHITECTURE Behavior of ff_jk is      
BEGIN
	PROCESS (Clk) 
	VARIABLE temp: std_logic;
	VARIABLE jk: std_logic_vector (2 downto 1);
	BEGIN
		jk := J & K;
		IF (Clk'event and Clk='1') then                        
		CASE (jk) is
			WHEN "11" => temp := not (temp);
			WHEN "10" => temp := '1';
			WHEN "01" => temp := '0';
			WHEN others => temp := temp; 
		END CASE;
		END IF;
		
		IF Clk'EVENT AND Clk = '1' AND Preset = '1' THEN 
			temp := '1' ;
		END IF ;
		
		IF Clk'EVENT AND Clk = '1' AND Clear = '1' THEN 
			temp := '0' ;
		END IF ;
		
		Q <= temp;
		Q_n <= NOT temp;	
	
	END PROCESS;
END Behavior;
