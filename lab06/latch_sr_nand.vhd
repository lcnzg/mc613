library ieee;
use ieee.std_logic_1164.all;
--use work.latches_ffs_pack.all;

entity latch_sr_nand is
	port(
	    S_n , R_n: in std_logic;
		 Qa , Qb : out std_logic);
end latch_sr_nand;


architecture behavior of latch_sr_nand is
	
begin
	process (S_n, R_n)
		
		VARIABLE tempa: std_logic;
		VARIABLE tempb: std_logic;
		
		begin
			if S_n = '0' AND R_n = '1' then
				tempa := '1';
				tempb := '0';		
			elsif S_n = '1' AND R_n = '0' then 
				tempa := '0';
				tempb := '1';		
			elsif S_n = '0' AND R_n = '0' then 
				tempa := '1';
				tempb := '1';
			end if;
			
			if not (S_n = '1' AND R_n = '1') then		
				Qa <= tempa;
				Qb <= tempb;
			end if;
			
	end process;
end behavior;