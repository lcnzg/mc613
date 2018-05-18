library ieee;
use ieee.std_logic_1164.all;

entity shift_register is
generic (N : integer := 6);
port(
    clk     : in  std_logic;
    mode    : in  std_logic_vector(1 downto 0);
    ser_in  : in  std_logic;
    par_in  : in  std_logic_vector((N - 1) downto 0);
    par_out : out std_logic_vector((N - 1) downto 0)
  );
end shift_register;

architecture rtl of shift_register is
  SIGNAL temporary : std_logic_vector(N-1 downto 0);
begin
  PROCESS
  BEGIN
    WAIT UNTIL clk'EVENT AND clk = '1';
	 IF mode = "11" then temporary <= par_in;
	 ELSIF mode = "01" then
		leftshift: FOR i in 0 to N-2 LOOP
			temporary(i) <= temporary(i+1);
		END LOOP;
		temporary(N-1) <= ser_in;
    ELSIF mode = "10" then
		rightshift: FOR i in 0 to N-2 LOOP
			temporary(i+1) <= temporary(i);
		END LOOP;
		temporary(0) <= ser_in;
	 END IF;
	END PROCESS;
	
	par_out <= temporary;
	
end rtl;
