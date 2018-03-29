-- brief : lab05 - question 2

library ieee;
use ieee.std_logic_1164.all;

entity cla_8bits is
  port(
    x    : in  std_logic_vector(7 downto 0);
    y    : in  std_logic_vector(7 downto 0);
    cin  : in  std_logic;
    sum  : out std_logic_vector(7 downto 0);
    cout : out std_logic
  );
end cla_8bits;

architecture rtl of cla_8bits is

SIGNAL c : std_logic_vector(8 downto 0);
SIGNAL g : std_logic_vector(7 downto 0);
SIGNAL p : std_logic_vector(7 downto 0);

begin
	c(0) <= cin;
	
	c(1) <= g(0) OR (p(0) AND c(0));
	
	c(2) <= g(1) OR (p(1) AND g(0)) OR (p(1) AND p(0) AND c(0));
	
	c(3) <= g(2) OR (p(2) AND g(1)) OR (p(2) AND p(1) AND g(0)) OR (p(2) AND p(1) AND p(0) AND c(0));
	
	c(4) <= g(3) OR (p(3) AND g(2)) OR (p(3) AND p(2) AND g(1)) OR (p(3) and p(2) AND p(1) AND g(0)) OR (p(3) AND p(2) AND p(1) AND p(0) AND c(0));
	
	c(5) <= g(4) or (p(4) and g(3)) OR (p(4) and p(3) AND g(2)) OR (p(4) and p(3) AND p(2) AND g(1)) OR (p(4) and p(3) and p(2) AND p(1) AND g(0)) OR (p(4) and p(3) AND p(2) AND p(1) AND p(0) AND c(0));
	
	c(6) <= g(5) or (p(5) and g(4)) or (p(5) and p(4) and g(3)) OR (p(5) and p(4) and p(3) AND g(2)) OR (p(5) and p(4) and p(3) AND p(2) AND g(1)) OR (p(5) and p(4) and p(3) and p(2) AND p(1) AND g(0)) OR (p(5) and p(4) and p(3) AND p(2) AND p(1) AND p(0) AND c(0));

	c(7) <= g(6) or (p(6) and g(5)) or (p(6) and p(5) and g(4)) or (p(6) and p(5) and p(4) and g(3)) OR (p(6) and p(5) and p(4) and p(3) AND g(2)) OR (p(6) and p(5) and p(4) and p(3) AND p(2) AND g(1)) OR (p(6) and p(5) and p(4) and p(3) and p(2) AND p(1) AND g(0)) OR (p(6) and p(5) and p(4) and p(3) AND p(2) AND p(1) AND p(0) AND c(0));

	cout <= g(7) or (p(7) and g(6)) or (p(7) and p(6) and g(5)) or (p(7) and p(6) and p(5) and g(4)) or (p(7) and p(6) and p(5) and p(4) and g(3)) OR (p(7) and p(6) and p(5) and p(4) and p(3) AND g(2)) OR (p(7) and p(6) and p(5) and p(4) and p(3) AND p(2) AND g(1)) OR (p(7) and p(6) and p(5) and p(4) and p(3) and p(2) AND p(1) AND g(0)) OR (p(7) and p(6) and p(5) and p(4) and p(3) AND p(2) AND p(1) AND p(0) AND c(0));

  G1: FOR i in 0 to 7 GENERATE
		g(i) <= x(i) AND y(i);
		p(i) <= x(i) OR y(i);

		sum(i) <= x(i) XOR y(i) XOR c(i);
	END GENERATE;
		
end rtl;

