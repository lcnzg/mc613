library ieee;
use ieee.std_logic_1164.all;

entity ripple_carry is
  generic (
    N : integer := 4
  );
  port (
    x,y : in std_logic_vector(N-1 downto 0);
    r : out std_logic_vector(N-1 downto 0);
    cin : in std_logic;
    cout : out std_logic;
    overflow : out std_logic
  );
end ripple_carry;

architecture rtl of ripple_carry is
	SIGNAL c : STD_LOGIC_VECTOR(0 TO N) ;
	COMPONENT full_adder 
		port (x, y : in std_logic;
		 r : out std_logic;
		 cin : in std_logic;
		 cout : out std_logic
	  );
	END COMPONENT;
	
begin
	c(0) <= cin;
  G0: FOR i in 0 to N-1 GENERATE
		fulad: full_adder PORT MAP ( x(i), y(i), r(i), c(i), c(i+1) ) ;
	END GENERATE;
	
	overflow <= c(N-1) xor C(N);
	cout <= c(N);
	
end rtl;
