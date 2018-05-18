LIBRARY ieee ; 
USE ieee.std_logic_1164.all ; 

package latches_ffs_pack is

component latch_sr_nand
	port(
	    S_n , R_n: in std_logic;
		 Qa , Qb : out std_logic);
    end component;


component latch_sr_gated
	port(
	    S , R , Clk: in std_logic;
		 Q , Q_n : out std_logic);
    end component;
	 
component latch_d_gated
	port(
	    D, Clk: in std_logic;
		 Q , Q_n : out std_logic);
    end component;
	 

component ff_d
	PORT ( 
		D, Clk, Preset, Clear : IN STD_LOGIC ; 
		Q ,Q_n : OUT STD_LOGIC) ; 
    end component;
	 

component ff_jk
	PORT ( 
		J,K,Clk,Preset,Clear : IN STD_LOGIC ; 
		Q ,Q_n : OUT STD_LOGIC) ; 
    end component;
	 

component ff_t
	PORT ( 
		T, Clk, Preset, Clear : IN STD_LOGIC ; 
		Q ,Q_n : OUT STD_LOGIC) ; 
    end component;
	 

end latches_ffs_pack;