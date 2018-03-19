library ieee;
use ieee.std_logic_1164.all;

entity mux4_to_1 is
  port(d3, d2, d1, d0 : in std_logic;
       sel : in std_logic_vector(1 downto 0);
       output : out std_logic);
end mux4_to_1;

architecture rtl of mux4_to_1 is

	COMPONENT dec2_to_4 
		port(en, w1, w0: in std_logic;
			  y3, y2, y1, y0: out std_logic);
	END COMPONENT;
	
	COMPONENT extra_logic 
		port(w3, w2, w1, w0 : in std_logic;
			 y3, y2, y1, y0 : in std_logic;
			 f : out std_logic);
	END COMPONENT;
	
	SIGNAL m : std_logic_vector(0 to 3);
	
begin
    
		DEC: dec2_to_4 PORT MAP ('1', sel(1), sel(0), m(3),m(2),m(1),m(0));
		
		EL: extra_logic PORT MAP (d3, d2,d1,d0,m(3),m(2),m(1),m(0),output);
  
end rtl;

