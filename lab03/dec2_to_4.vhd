library ieee;
use ieee.std_logic_1164.all;

entity dec2_to_4 is
  port(en, w1, w0: in std_logic;
       y3, y2, y1, y0: out std_logic);
end dec2_to_4;

architecture rtl of dec2_to_4 is
	SIGNAL Enw : STD_LOGIC_VECTOR(2 DOWNTO 0) ;
	SIGNAL Y : STD_LOGIC_VECTOR(3 DOWNTO 0) ;
begin
	Enw <= en & w1 & w0;
	WITH Enw SELECT
		Y <= "1000" WHEN "100",
			  "0100" WHEN "101",
           "0010" WHEN "110",
           "0001" WHEN "111",
           "0000" WHEN OTHERS ;
	y0 <= Y(3);
	y1 <= Y(2);
	y2 <= Y(1);
	y3 <= Y(0);
end rtl;

