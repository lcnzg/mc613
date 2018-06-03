library ieee;
use ieee.std_logic_1164.all;

entity octave2hex is
	port (
		oitava: in std_logic_vector(1 downto 0);
		hex: out std_logic_vector(6 downto 0) -- gfedcba
);
end octave2hex;

architecture rtl of octave2hex is

signal aux : integer range 0 to 13;

begin
	-- mostra a oitava atual
	with oitava select
		hex <=	"1111001" when "00", -- oitava 1
					"0100100" when "01", -- oitava 2
					"0110000" when "10", -- oitava 3
					"0011001" when "11", -- oitava 4
					"1111111" when others; -- desligado
end rtl;