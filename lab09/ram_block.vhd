library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_block is
  port (
    Clock : in std_logic;
    Address : in std_logic_vector(6 downto 0);
    Data : in std_logic_vector(7 downto 0);
    Q : out std_logic_vector(7 downto 0);
    WrEn : in std_logic
  );
end ram_block;


architecture direct of ram_block is

	subtype word_t is std_logic_vector(7 downto 0);
	type memory_t is array(2**7 downto 0) of word_t;

	-- Declare the RAM signal.	
	signal ram : memory_t;

	-- Register to hold the address 
	signal addr_reg : natural range 0 to 2**7;

begin

	-- Converte Address Bin to Integer
	addr_reg <= to_integer(unsigned(Address));

	process(Clock)
	begin	
		if(Clock'event and Clock = '1') then
			if(WrEn = '1') then
				ram(addr_reg) <= Data;
			end if;
		end if;
		
	end process;
	
	-- Register the address for reading
	Q <= ram(addr_reg);

end direct;