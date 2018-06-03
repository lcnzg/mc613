library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity main_board is
	port (
		CLOCK_50, CLOCK2_50, AUD_DACLRCK		: IN		STD_LOGIC;
      AUD_ADCLRCK, AUD_BCLK, AUD_ADCDAT	: IN		STD_LOGIC;
		SW 											: in		std_logic_vector(6 downto 0);
		PS2_DAT										: inout	STD_LOGIC;
		PS2_CLK										: inout	STD_LOGIC;		
      FPGA_I2C_SDAT								: INOUT	STD_LOGIC;
      FPGA_I2C_SCLK, AUD_DACDAT, AUD_XCK	: OUT		STD_LOGIC;
		HEX0											: out		std_logic_vector(6 downto 0);
		HEX1											: out		std_logic_vector(6 downto 0);
		HEX2											: out		std_logic_vector(6 downto 0);		
		HEX3											: out		std_logic_vector(6 downto 0);
		HEX5											: out		std_logic_vector(6 downto 0)
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
	
	component octave2hex is
		port (
			oitava: in std_logic_vector(1 downto 0);
			hex: out std_logic_vector(6 downto 0)
);
	end component;
	
	component note2period is
		port (
			note: in integer range 0 to 13;
			period: out integer range 0 to 187
);
	end component;
	
	component clk_div is
	  port (
			clk : in std_logic;
			period: in integer range 0 to 187;
			oitava: in std_logic_vector(1 downto 0);
			clk_note : out std_logic
	  );
	end component;
	
	component sine_wave is
		port (
			indice: in integer range 0 to 4095;
			amplitude: out integer range -2097152 to 2097152
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
  
   COMPONENT clock_generator
      PORT( CLOCK_27 : IN STD_LOGIC;
            reset    : IN STD_LOGIC;
            AUD_XCK  : OUT STD_LOGIC);
   END COMPONENT;

   COMPONENT audio_and_video_config
      PORT( CLOCK_50, reset : IN    STD_LOGIC;
            I2C_SDAT        : INOUT STD_LOGIC;
            I2C_SCLK        : OUT   STD_LOGIC);
   END COMPONENT;   
  
   COMPONENT audio_codec
      PORT( CLOCK_50, reset, read_s, write_s               : IN  STD_LOGIC;
            writedata_left, writedata_right                : IN  STD_LOGIC_VECTOR(23 DOWNTO 0);
            AUD_ADCDAT, AUD_BCLK, AUD_ADCLRCK, AUD_DACLRCK : IN  STD_LOGIC;
            read_ready, write_ready                        : OUT STD_LOGIC;
            readdata_left, readdata_right                  : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
            AUD_DACDAT                                     : OUT STD_LOGIC);
   END COMPONENT;
  
	signal key_on : std_logic_vector(2 downto 0);
	signal key_code : std_logic_vector(47 downto 0);
	signal nota1 : integer range 0 to 13;
	signal nota2 : integer range 0 to 13;
	signal write_s : STD_LOGIC;
	signal write_ready : STD_LOGIC;
	signal amplitude1: integer range -2097152 to 2097152;
	signal amplitude2: integer range -2097152 to 2097152;
	signal amplitude: integer range -2097152 to 2097152;
	signal indice1 : integer range 0 to 4095 := 0;
	signal indice2 : integer range 0 to 4095 := 0;
	signal audio_data : std_logic_vector (23 downto 0);
	signal period1 : integer range 0 to 187;
	signal period2 : integer range 0 to 187;
	signal clk_note1 : STD_LOGIC;
	signal clk_note2 : STD_LOGIC;
	signal oitava : std_logic_vector(1 downto 0);
  
begin

	oitava <= SW(1) & SW(0);
	amplitude <= (amplitude1 + amplitude2)/2;
	
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
		
	octave_disp : octave2hex
		port map (
			oitava => oitava,
			hex => HEX5
		);		

	nota1_period : note2period
		port map (
			nota1, period1
		);
		
	nota2_period : note2period
		port map (
			nota2, period2
		);
		
	sine1 : sine_wave
		port map (
			indice1, amplitude1
		);
		
	sine2 : sine_wave
		port map (
			indice2, amplitude2
		);
		
	clk1 : clk_div
		port map (
			CLOCK_50, period1, oitava, clk_note1
		);
	
	clk2 : clk_div
		port map (
			CLOCK_50, period2, oitava, clk_note2
		);
		
	PROCESS(CLOCK_50)
		BEGIN
			IF(CLOCK_50'event and CLOCK_50 = '1') THEN			
				IF(write_ready='1') THEN
					write_s <= '1';           --writes to buffer in audio codec
					audio_data <= std_logic_vector(to_signed(amplitude, 24));
				else
					write_s<='0';				
				END IF;
				
				IF(clk_note1='1') THEN 
					indice1 <= indice1+1;
				END IF;
				if (nota1 = 0) then
					indice1 <= 0;
				end if;
				
				IF(clk_note2='1') THEN 
				indice2 <= indice2+1;
				END IF;
				if (nota2 = 0) then
					indice2 <= 0;
				end if;				
			END IF;
	END PROCESS;	
	

	my_clock_gen: clock_generator PORT MAP (CLOCK2_50, '0', AUD_XCK);
	
   cfg: audio_and_video_config PORT MAP (CLOCK_50, '0', FPGA_I2C_SDAT, FPGA_I2C_SCLK);

	
   codec: audio_codec PORT MAP (CLOCK_50, '0', '0', write_s, audio_data, 
	                             audio_data, AUD_ADCDAT, AUD_BCLK, AUD_ADCLRCK,
										  AUD_DACLRCK, open, write_ready, open, 
										  open, AUD_DACDAT);
end rtl;