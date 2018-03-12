LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

entity bin2dec is
	port (
		SW: in std_logic_vector(3 downto 0);
		HEX0: out std_logic_vector(6 downto 0) -- gfdecba
);
end bin2dec;

ARCHITECTURE Behavior OF bin2dec IS
BEGIN
WITH SW SELECT
	HEX0 <=  "1000000" WHEN "0000", --NUM 0
				"1111001" WHEN "0001", --NUM 1
				"0100100" WHEN "0010", --NUM 2
				"0110000" WHEN "0011", --NUM 3
				"0011001" WHEN "0100", --NUM 4
				"0010010" WHEN "0101", --NUM 5
				"0000010" WHEN "0110", --NUM 6
				"1111000" WHEN "0111", --NUM 7
				"0000000" WHEN "1000", --NUM 8
				"0011000" WHEN "1001", --NUM 9
				"0000110" WHEN OTHERS ; -- ERROR
END Behavior ;


	