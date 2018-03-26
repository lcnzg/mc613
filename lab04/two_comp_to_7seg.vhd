library ieee;
use ieee.std_logic_1164.all;

entity two_comp_to_7seg is
  port (
    bin : in std_logic_vector(3 downto 0);
    segs : out std_logic_vector(6 downto 0); -- gfdecba
    neg : out std_logic
  );
end two_comp_to_7seg;

architecture behavioral of two_comp_to_7seg is

	SIGNAL saida : std_logic_vector(6 downto 0);

begin


WITH bin SELECT
	segs <=  "1000000" WHEN "0000", --NUM 0
				"1111001" WHEN "0001", --NUM 1
				"0100100" WHEN "0010", --NUM 2
				"0110000" WHEN "0011", --NUM 3
				"0011001" WHEN "0100", --NUM 4
				"0010010" WHEN "0101", --NUM 5
				"0000010" WHEN "0110", --NUM 6
				"1111000" WHEN "0111", --NUM 7
				"0000000" WHEN "1000", --NUM -8
				"1111000" WHEN "1001", --NUM -7
				"0000010" WHEN "1010", --NUM -6
				"0010010" WHEN "1011", --NUM -5
				"0011001" WHEN "1100", --NUM -4
				"0110000" WHEN "1101", --NUM -3
				"0100100" WHEN "1110", --NUM -2
				"1111001" WHEN "1111"; --NUM -1

	neg <= bin(3);
				
end behavioral;
