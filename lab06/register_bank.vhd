library ieee;
use ieee.std_logic_1164.all;

entity register_bank is
  port (
    clk : in std_logic;
    data_in : in std_logic_vector(3 downto 0);
    data_out : out std_logic_vector(3 downto 0);
    reg_rd : in std_logic_vector(2 downto 0);
    reg_wr : in std_logic_vector(2 downto 0);
    we : in std_logic;
    clear : in std_logic
  );
end register_bank;

architecture structural of register_bank is
  
	component reg 
		GENERIC ( N : INTEGER := 4) ;
		 port (
			clk : in std_logic;
			data_in : in std_logic_vector(N-1 downto 0);
			data_out : out std_logic_vector(N-1 downto 0);
			load : in std_logic; -- Write enable
			clear : in std_logic
  );
  end component;

	component dec3_to_8 
		 port (
			data_in : in std_logic_vector(2 downto 0);
			data_out : out std_logic_vector(7 downto 0)
  );
   end component;
  
  component zbuffer
  GENERIC ( N : INTEGER := 4) ;
		PORT (X: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
		E: IN STD_LOGIC ;
		F: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0) ) ;
	end component;

	
	SIGNAL D2R : std_logic_vector (7 downto 0);
	SIGNAL R2D : std_logic_vector (7 downto 0);
	
	SIGNAL REG0_OUT : std_logic_vector (3 downto 0);
	SIGNAL REG1_OUT : std_logic_vector (3 downto 0);
	SIGNAL REG2_OUT : std_logic_vector (3 downto 0);
	SIGNAL REG3_OUT : std_logic_vector (3 downto 0);
	SIGNAL REG4_OUT : std_logic_vector (3 downto 0);
	SIGNAL REG5_OUT : std_logic_vector (3 downto 0);
	SIGNAL REG6_OUT : std_logic_vector (3 downto 0);
	SIGNAL REG7_OUT : std_logic_vector (3 downto 0);
	
begin

	DEC_IN: dec3_to_8 port map (reg_wr(2 downto 0), D2R(7 downto 0));
	DEC_OUT: dec3_to_8 port map (reg_rd(2 downto 0), R2D(7 downto 0));
	
	REG0: reg port map (clk, data_in (3 downto 0), REG0_OUT (3 downto 0),we and D2R(0), clear and D2R(0));
	REG1: reg port map (clk, data_in (3 downto 0), REG1_OUT (3 downto 0),we and D2R(1), clear and D2R(1));
	REG2: reg port map (clk, data_in (3 downto 0), REG2_OUT (3 downto 0),we and D2R(2), clear and D2R(2));
	REG3: reg port map (clk, data_in (3 downto 0), REG3_OUT (3 downto 0),we and D2R(3), clear and D2R(3));
	REG4: reg port map (clk, data_in (3 downto 0), REG4_OUT (3 downto 0),we and D2R(4), clear and D2R(4));
	REG5: reg port map (clk, data_in (3 downto 0), REG5_OUT (3 downto 0),we and D2R(5), clear and D2R(5));
	REG6: reg port map (clk, data_in (3 downto 0), REG6_OUT (3 downto 0),we and D2R(6), clear and D2R(6));
	REG7: reg port map (clk, data_in (3 downto 0), REG7_OUT (3 downto 0),we and D2R(7), clear and D2R(7));
	
	tri0: zbuffer port map(REG0_OUT, R2D(0), data_out);
	tri1: zbuffer port map(REG1_OUT, R2D(1), data_out);
	tri2: zbuffer port map(REG2_OUT, R2D(2), data_out);
	tri3: zbuffer port map(REG3_OUT, R2D(3), data_out);
	tri4: zbuffer port map(REG4_OUT, R2D(4), data_out);
	tri5: zbuffer port map(REG5_OUT, R2D(5), data_out);
	tri6: zbuffer port map(REG6_OUT, R2D(6), data_out);
	tri7: zbuffer port map(REG7_OUT, R2D(7), data_out);
	



end structural;
