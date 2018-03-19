library ieee;
use ieee.std_logic_1164.all;

entity xbar_v2 is
  port(x1, x2, s: in std_logic;
       y1, y2: out std_logic);
end xbar_v2;

architecture rtl of xbar_v2 is
	BEGIN
	y1 <= x1 WHEN s = '0' ELSE	x2 ;
	y2 <= x2 WHEN s = '0' ELSE	x1 ;	
end rtl;

