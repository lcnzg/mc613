library ieee;
use ieee.std_logic_1164.all;

entity extra_logic is
  port(w3, w2, w1, w0 : in std_logic;
       y3, y2, y1, y0 : in std_logic;
       f : out std_logic);
end extra_logic;

architecture rtl of extra_logic is
	SIGNAL m : STD_LOGIC_VECTOR(0 to 3) ;
begin
	m(0) <= (w0 AND y0);
	m(1) <= (w1 AND y1);
	m(2) <= (w2 AND y2);
	m(3) <= (w3 AND y3);
	
	f <= (m(0) OR m(1) OR m(2) OR m(3));
	
end rtl;

