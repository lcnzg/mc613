library ieee;
use ieee.std_logic_1164.all;

entity note2hex is
	port (
		enable: in std_logic;
		note: in integer range 0 to 13;
		hex1: out std_logic_vector(6 downto 0); -- gfedcba
		hex2: out std_logic_vector(6 downto 0) -- gfedcba
);
end note2hex;

architecture rtl of note2hex is

signal aux : integer range 0 to 13;

begin

	aux <= 0 when enable = '0' else note;

	-- mostra as letras ou nao
	with aux select
		hex1 <=	"0001000" when 10, -- nota A
					"0001000" when 11, -- nota A#
					"0000011" when 12, -- nota B
					"1000110" when 1, -- nota C
					"1000110" when 2, -- nota C#
					"1000110" when 13, -- nota C
					"0100001" when 3, -- nota D
					"0100001" when 4, -- nota D#
					"0000110" when 5, -- nota E
					"0001110" when 6, -- nota F
					"0001110" when 7, -- nota F#
					"1000010" when 8, -- nota G
					"1000010" when 9, -- nota G#
					"1111111" when others; -- desligado
	
	-- mostra o S ou nao
	with aux select
		hex2 <=	"0010010" when 11, -- nota A#
					"0010010" when 2, -- nota C#
					"0010010" when 4, -- nota D#
					"0010010" when 7, -- nota F#
					"0010010" when 9, -- nota G#
					"1111111" when others; -- desligado

end rtl;