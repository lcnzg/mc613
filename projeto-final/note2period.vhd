library ieee;
use ieee.std_logic_1164.all;

entity note2period is
	port (
		note: in integer range 0 to 13;
		period: out integer range 0 to 191
);
end note2period;

architecture rtl of note2period is

begin

	-- traduz as notas em frequencias
	with note select
		period <=	114 when 10, -- nota A
						107 when 11, -- nota A#
						101 when 12, -- nota B
						191 when 1, -- nota C
						180 when 2, -- nota C#
						96 when 13, -- nota C
						170 when 3, -- nota D
						161 when 4, -- nota D#
						152 when 5, -- nota E
						143 when 6, -- nota F
						135 when 7, -- nota F#
						128 when 8, -- nota G
						120 when 9, -- nota G#
						0 when others; -- desligado

end rtl;