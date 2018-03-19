library ieee;
use ieee.std_logic_1164.all;

entity xbar_stage_8 is
  port(SW  : in std_logic_vector (7 downto 0);
       LEDR: out std_logic_vector(0 downto 0));
end xbar_stage_8;

architecture rtl of xbar_stage_8 is
	SIGNAL x1 : STD_LOGIC_VECTOR(0 TO 7 ) ;
	SIGNAL x2 : STD_LOGIC_VECTOR(0 TO 7 ) ;
	COMPONENT xbar_v1
		port(x1, x2, s: in std_logic;
			 y1, y2: out std_logic);
	END COMPONENT;
begin
	G1: FOR i IN 1 TO 6 GENERATE
		xbars: xbar_v1 PORT MAP 
				( x1(i), x2(i) , SW(i) , x1(i+1) , x2(i+1) );
	END GENERATE ;
	
	INICIAL:  xbar_v1 PORT MAP ('1' , '0', SW(0),  x1(1), x2(1));
	
	CASON: xbar_v1 PORT MAP ( x1(7), x2(7), SW(7) , LEDR(0), x1(0) );
	
end rtl;