library ieee;
use ieee.std_logic_1164.all;

entity scan2note is
	port (
		key_on : in std_logic;
		key_code : in std_logic_vector(15 downto 0);
		note : out integer range 0 to 13
	);
end scan2note;

architecture rtl of scan2note is

signal aux : integer range 0 to 13;

begin

	with key_code select
		aux <=	1 when x"001C", -- letra a, nota c
					2 when x"001D", -- letra w, nota c#
					3 when x"001B", -- letra s, nota d
					4 when x"0024", -- letra e, nota d
					5 when x"0023", -- letra d, nota d
					6 when x"002B", -- letra f, nota d
					7 when x"002C", -- letra t, nota d
					8 when x"0034", -- letra g, nota d
					9 when x"0035", -- letra y, nota d
					10 when x"0033", -- letra h, nota d
					11 when x"003C", -- letra u, nota d
					12 when x"003B", -- letra j, nota d
					13 when x"0042", -- letra k, nota d					
					0 when others;
					
	note <= aux when key_on = '1' else 0;

end rtl;