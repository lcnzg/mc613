library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clk_div is
  port (
    clk : in std_logic;
	 period: in integer range 0 to 191;
	 oitava: in std_logic_vector(3 downto 0);
    clk_note : out std_logic
  );
end clk_div;

architecture behavioral of clk_div is
signal counter: INTEGER range 1 to 50000000;
signal aux: integer range 1 to 50000000;
signal divisao: integer range 2 to 128;
begin

	with oitava select
		divisao <= 	2 when "0001",
						4 when "0010",
						8 when "0011",
						16 when "0100",
						32 when "0101",
						64 when "0110",
						128 when "0111",
						16 when others;

	aux <= period / divisao;
  
	process (clk)
	begin
		if( clk'event and clk = '1') then		 
			counter <= counter + 1;
			if counter = aux then
				clk_note <= '1';
				counter <= 1;
			else
				clk_note <= '0'; 
			end if;
		end if;
	end process;
			
end behavioral;