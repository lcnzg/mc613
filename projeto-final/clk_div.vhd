library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clk_div is
  port (
    clk : in std_logic;
	 period: in integer range 0 to 187;
	 oitava: in std_logic_vector(1 downto 0);
    clk_note : out std_logic
  );
end clk_div;

architecture behavioral of clk_div is
signal counter: INTEGER range 1 to 50000000;
signal aux: integer range 1 to 50000000;
signal divisao: integer range 1 to 8;
begin

	with oitava select
		divisao <= 	1 when "00",
						2 when "01",
						4 when "10",
						8 when "11",
						8 when others;

	aux <= period / divisao;
  
	process (clk)
	begin
		if( clk'event and clk = '1') then		 
			counter <= counter + 1;
			if counter >= aux then
				clk_note <= '1';
				counter <= 1;
			else
				clk_note <= '0'; 
			end if;
		end if;
	end process;
			
end behavioral;