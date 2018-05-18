library ieee;
use ieee.std_logic_1164.all;

entity dec3_to_8 is
  port (
    data_in : in std_logic_vector(2 downto 0);
    data_out : out std_logic_vector(7 downto 0)
  );
end dec3_to_8;

architecture behavior of dec3_to_8 is
begin
	
	WITH data_in SELECT 
		data_out <= "10000000" WHEN "111", --7
						"01000000" WHEN "110", --6
						"00100000" WHEN "101", --5
						"00010000" WHEN "100", --4
						"00001000" WHEN "011", --3
						"00000100" WHEN "010", --2
						"00000010" WHEN "001", --1
						"00000001" WHEN "000"; --0

end behavior;