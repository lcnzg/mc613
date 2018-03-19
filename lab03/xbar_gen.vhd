library ieee;
use ieee.std_logic_1164.all;

entity xbar_gen is
	GENERIC ( N : INTEGER := 5);
	port(s: in std_logic_vector (N-1 downto 0);
			y1, y2: out std_logic);
end xbar_gen;

architecture rtl of xbar_gen is
	SIGNAL x1 : STD_LOGIC_VECTOR(0 TO N -1 ) ;
	SIGNAL x2 : STD_LOGIC_VECTOR(0 TO N -1 ) ;
	COMPONENT xbar_v1
		port(x1, x2, s: in std_logic;
			 y1, y2: out std_logic);
	END COMPONENT;
begin
	G1: FOR i IN 1 TO N-2 GENERATE
		xbars: xbar_v1 PORT MAP 
				( x1(i), x2(i) , s(i) , x1(i+1) , x2(i+1) );
	END GENERATE ;
	
	INICIAL:  xbar_v1 PORT MAP ('1' , '0', s(0),  x1(1), x2(1));
	
	CASON: xbar_v1 PORT MAP ( x1(N-1), x2(N-1), s(N-1) , y1, y2);
	
end rtl;

