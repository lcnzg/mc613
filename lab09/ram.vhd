library ieee;
use ieee.std_logic_1164.all;

entity ram is
  port (
    Clock : in std_logic;
    Address : in std_logic_vector(9 downto 0);
    DataIn : in std_logic_vector(31 downto 0);
    DataOut : out std_logic_vector(31 downto 0);
    WrEn : in std_logic
  );
end ram;

architecture rtl of ram is

component ram_block
	port(
	 Clock : in std_logic;
    Address : in std_logic_vector(6 downto 0);
    Data : in std_logic_vector(7 downto 0);
    Q : out std_logic_vector(7 downto 0);
    WrEn : in std_logic
	);
end component;

	signal WrEn_dec : std_logic_vector(1 downto 0);
	signal q1 : std_logic_vector(31 downto 0);
	signal q2 : std_logic_vector(31 downto 0);
	
begin

	R1:	ram_block port map(Clock, Address(6 downto 0), DataIn(7 downto 0), q1(7 downto 0), WrEn_dec(0));
	R2:	ram_block port map(Clock, Address(6 downto 0), DataIn(15 downto 8), q1(15 downto 8), WrEn_dec(0));
	R3:	ram_block port map(Clock, Address(6 downto 0), DataIn(23 downto 16), q1(23 downto 16), WrEn_dec(0));
	R4:	ram_block port map(Clock, Address(6 downto 0), DataIn(31 downto 24), q1(31 downto 24), WrEn_dec(0));
	
	R5:	ram_block port map(Clock, Address(6 downto 0), DataIn(7 downto 0), q2(7 downto 0), WrEn_dec(1));
	R6:	ram_block port map(Clock, Address(6 downto 0), DataIn(15 downto 8), q2(15 downto 8), WrEn_dec(1));
	R7:	ram_block port map(Clock, Address(6 downto 0), DataIn(23 downto 16), q2(23 downto 16), WrEn_dec(1));
	R8:	ram_block port map(Clock, Address(6 downto 0), DataIn(31 downto 24), q2(31 downto 24), WrEn_dec(1));
	
	with Address(9 downto 7) select
		DataOut <= 	q1 when "000",
						q2 when "001",
						(OTHERS=> 'Z') when others;
				
	with Address(9 downto 7) select
		WrEn_dec(0) <= '1' and WrEn when "000",
							'0' and WrEn when "001",
							'0' when others;
						
	with Address(9 downto 7) select
		WrEn_dec(1) <= '0' and WrEn when "000",
							'1' and WrEn when "001",
							'0' when others;
						
end rtl;
