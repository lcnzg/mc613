-- brief : lab05 - question 2

library ieee;
use ieee.std_logic_1164.all;

entity cla_4bits is
  port(
    x    : in  std_logic_vector(3 downto 0);
    y    : in  std_logic_vector(3 downto 0);
    cin  : in  std_logic;
    sum  : out std_logic_vector(3 downto 0);
    cout : out std_logic
  );
end cla_4bits;

architecture rtl of cla_4bits is
SIGNAL c : std_logic_vector(3 downto 0);
SIGNAL g : std_logic_vector(3 downto 0);
SIGNAL p : std_logic_vector(3 downto 0);

begin
	c(0) <= cin;
	
	c(1) <= g(0) OR (p(0) AND c(0));
	
	c(2) <= g(1) OR (p(1) AND g(0)) OR (p(1) AND p(0) AND c(0));
	
	c(3) <= g(2) OR (p(2) AND g(1)) OR (p(2) AND p(1) AND g(0)) OR (p(2) AND p(1) AND p(0) AND c(0));
	
	cout <= g(3) OR (p(3) AND g(2)) OR (p(3) AND p(2) AND g(1)) OR (p(3) and p(2) AND p(1) AND g(0)) OR (p(3) AND p(2) AND p(1) AND p(0) AND c(0));
	
  G1: FOR i in 0 to 3 GENERATE
		g(i) <= x(i) AND y(i);
		p(i) <= x(i) OR y(i);
		sum(i) <= x(i) XOR y(i) XOR c(i);
	END GENERATE;
	
	
	
end rtl;

