library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sinewave_testbench is
end sinewave_testbench;


architecture behavioral of sinewave_testbench is

	component sine_wave is
		port (
			indice: in integer range 0 to 7999;
			amplitude: out integer range -2097152 to 2097152
		);
	end component;
	
	signal indice: integer range 0 to 7999 := 0;
	signal amplitude: integer range -2097152 to 2097152;
	
begin

	sine : sine_wave
		port map (
			indice, amplitude
		);
   
	process(indice)
	begin
	
		--wait for 10 ns;
		--indice <= indice +1 after 10 ns;
		
	end process;
			
end behavioral;
