library ieee;
use ieee.std_logic_1164.all;
--use work.latches_ffs_pack.all;

entity latch_sr_gated is
	port(
	    S , R , Clk: in std_logic;
		 Q , Q_n : out std_logic);
end latch_sr_gated;


architecture behavior of latch_sr_gated is
	
begin
	process (S, R , Clk)
		
		VARIABLE tempq: std_logic;
		VARIABLE tempqn: std_logic;
		
		begin
			if Clk = '1' AND S = '0' AND R = '1' then
				tempq := '0';
				tempqn := '1';		
			elsif Clk = '1' AND S = '1' AND R = '0' then 
				tempq := '1';
				tempqn := '0';
			end if;
			
			if ((S = '0' AND R = '1') OR (S = '1' AND R = '0') ) AND Clk = '1' then		
				Q <= tempq;
				Q_n <= tempqn;
			end if;
			
	end process;
end behavior;