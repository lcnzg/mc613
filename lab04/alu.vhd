library ieee;
use ieee.std_logic_1164.all;

entity alu is
  port (
    a, b : in std_logic_vector(3 downto 0);
    F : out std_logic_vector(3 downto 0);
    s0, s1 : in std_logic;
    Z, C, V, N : out std_logic
  );
end alu;

architecture behavioral of alu is
	COMPONENT ripple_carry
		  generic (
			 N : integer := 4
		  );
		  port (
			 x,y : in std_logic_vector(N-1 downto 0);
			 r : out std_logic_vector(N-1 downto 0);
			 cin : in std_logic;
			 cout : out std_logic;
			 overflow : out std_logic);
  END COMPONENT;
  
  SIGNAL Bmod : std_logic_vector(3 downto 0);
  SIGNAL Sor : std_logic_vector(3 downto 0);
  SIGNAL Sand : std_logic_vector(3 downto 0);
  SIGNAL somasub : std_logic_vector(3 downto 0);
  SIGNAL saida : std_logic_vector(3 downto 0);
  SIGNAL S : std_logic_vector(0 to 1);
  SIGNAL Ctemp : std_logic;
  SIGNAL Vtemp : std_logic;
  
begin

	Bmod(3) <= b(3) XOR s0;
	Bmod(2) <= b(2) XOR s0;
	Bmod(1) <= b(1) XOR s0;
	Bmod(0) <= b(0) XOR s0;
	
	Sor(3) <= a(3) OR b(3);
	Sor(2) <= a(2) OR b(2);
	Sor(1) <= a(1) OR b(1);
	Sor(0) <= a(0) OR b(0);
	
	Sand(3) <= a(3) AND b(3);
	Sand(2) <= a(2) AND b(2);
	Sand(1) <= a(1) AND b(1);
	Sand(0) <= a(0) AND b(0);
	
	G0: ripple_carry PORT MAP (a(3 downto 0),Bmod(3 downto 0),somasub(3 downto 0),s0,Ctemp,Vtemp);
	
	S <= s0 & s1;
	WITH S SELECT
		saida <= somasub WHEN "00",
					somasub WHEN "10",
					Sand    WHEN "01",
					Sor     WHEN "11";
					
	
	
	N <= saida(3) AND (NOT s1);
	C <= Ctemp AND (NOT s1);
	V <= Vtemp AND (NOT s1);
	Z <= NOT (saida(3) OR saida(2) OR saida(1) OR saida(0));
	
	F <= saida;

end behavioral;
