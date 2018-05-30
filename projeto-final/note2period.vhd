library ieee;
use ieee.std_logic_1164.all;

entity note2period is
	port (
		note: in integer range 0 to 13;
		period: out integer range 0 to 187
);
end note2period;

architecture rtl of note2period is

begin

	-- traduz as notas em frequencias
	with note select
		period <=	111 when 10, -- nota A
						105 when 11, -- nota A#
						99 when 12, -- nota B
						187 when 1, -- nota C
						176 when 2, -- nota C#
						93 when 13, -- nota C
						166 when 3, -- nota D
						157 when 4, -- nota D#
						148 when 5, -- nota E
						140 when 6, -- nota F
						132 when 7, -- nota F#
						125 when 8, -- nota G
						118 when 9, -- nota G#
						0 when others; -- desligado

end rtl;