library ieee;
use ieee.std_logic_1164.all;
--use work.latches_ffs_pack.all;

entity latch_d_gated is
	port(
	    D, Clk: in std_logic;
		 Q , Q_n : out std_logic);
end latch_d_gated;


architecture behavior of latch_d_gated is
	
begin
	process (D , Clk)
	begin
			if Clk = '1'  then
				Q <= D;
			end if;
			
	end process;
end behavior;