library ieee;
use ieee.std_logic_1164.all;

entity note2freq is
	port (
		note: in integer range 0 to 13;
		freq: out integer range 0 to 523
);
end note2freq;

architecture rtl of note2freq is

begin

	-- traduz as notas em frequencias
	with note select
		freq <=	440 when 10, -- nota A
					466 when 11, -- nota A#
					494 when 12, -- nota B
					262 when 1, -- nota C
					277 when 2, -- nota C#
					523 when 13, -- nota C
					294 when 3, -- nota D
					311 when 4, -- nota D#
					330 when 5, -- nota E
					350 when 6, -- nota F
					370 when 7, -- nota F#
					392 when 8, -- nota G
					415 when 9, -- nota G#
					400 when others; -- desligado

end rtl;