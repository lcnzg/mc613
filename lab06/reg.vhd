library ieee;
use ieee.std_logic_1164.all;

entity reg is
  generic (
    N : integer := 4
  );
  port (
    clk : in std_logic;
    data_in : in std_logic_vector(N-1 downto 0);
    data_out : out std_logic_vector(N-1 downto 0);
    load : in std_logic; -- Write enable
    clear : in std_logic
  );
end reg;

architecture rtl of reg is

SIGNAL aux : std_logic_vector(N-1 downto 0);

begin
	PROCESS (clk, clear)
	BEGIN
		IF clk'EVENT AND clk = '1' THEN
			IF load = '1' THEN aux <= data_in;
			END IF;
		END IF;
		
		IF clear = '1' THEN 
			for i in N-1 downto 0 loop
				aux(i) <= '0';
			end loop;
		END IF;
				
		data_out <= aux;		
	END PROCESS;
end rtl;
