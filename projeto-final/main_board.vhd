library ieee;
use ieee.std_logic_1164.all;

entity main_board is
	port (
		CLOCK_50 : in std_logic;
		SW : in std_logic_vector(6 downto 0);
		 
		PS2_DAT : inout STD_LOGIC;
		PS2_CLK : inout STD_LOGIC;
		HEX0 : out std_logic_vector(6 downto 0);
		HEX1 : out std_logic_vector(6 downto 0);
		HEX2 : out std_logic_vector(6 downto 0);
		HEX3 : out std_logic_vector(6 downto 0)	 
	);
	
end main_board;

architecture rtl of main_board is
	component scan2note is
		port (
			key_on : in std_logic;
			key_code : in std_logic_vector(15 downto 0);
			note : out integer range 0 to 13
		);
	end component;
	
	component note2hex is
		port (
			enable: in std_logic;
			note: in integer range 0 to 13;
			hex1: out std_logic_vector(6 downto 0);
			hex2: out std_logic_vector(6 downto 0)
);
	end component;
  
	component kbdex_ctrl is
		generic(
			clkfreq : integer
		);
		port(
			ps2_data : inout std_logic;
			ps2_clk : inout std_logic;
			clk :	in std_logic;
			en : in std_logic;
			resetn : in std_logic;
			lights : in std_logic_vector(2 downto 0);
			key_on : out std_logic_vector(2 downto 0);
			key_code : out std_logic_vector(47 downto 0)
		);
	end component;
  
--   COMPONENT audio_codec
--      PORT( CLOCK_50, reset, read_s, write_s               : IN  STD_LOGIC;
--            writedata_left, writedata_right                : IN  STD_LOGIC_VECTOR(23 DOWNTO 0);
--            AUD_ADCDAT, AUD_BCLK, AUD_ADCLRCK, AUD_DACLRCK : IN  STD_LOGIC;
--            read_ready, write_ready                        : OUT STD_LOGIC;
--            readdata_left, readdata_right                  : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
--            AUD_DACDAT                                     : OUT STD_LOGIC);
--   END COMPONENT;
  
	signal key_on : std_logic_vector(2 downto 0);
	signal key_code : std_logic_vector(47 downto 0);
	signal nota1 : integer range 0 to 13;
	signal nota2 : integer range 0 to 13;
  
begin

	kbdex_ctrl_inst : kbdex_ctrl
		generic map (
			clkfreq => 50000
		)
		port map (
			ps2_data => PS2_DAT,
			ps2_clk => PS2_CLK,
			clk => CLOCK_50,
			en => '1',
			resetn => '1',
			lights => "000",
			key_on => key_on,
			key_code => key_code
		);
  
	nota1_scan : scan2note
		port map (
			key_on => key_on(0),
			key_code => key_code(15 downto 0),
			note => nota1
		);
	 
	nota2_scan : scan2note
		port map (
			key_on => key_on(1),
			key_code => key_code(31 downto 16),
			note => nota2
		);

	nota1_disp : note2hex
		port map (
			enable => key_on(0),
			note => nota1,
			hex1 => HEX1,
			hex2 => HEX0
		);

	nota2_disp : note2hex
		port map (
			enable => key_on(1),
			note => nota2,
			hex1 => HEX3,
			hex2 => HEX2
		);

end rtl;