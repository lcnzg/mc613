library ieee;

USE ieee.std_logic_1164.all;


ENTITY fsm_diag IS
	PORT(clock, reset, w : IN STD_LOGIC;
		  z					: OUT STD_LOGIC
	);
END fsm_diag;


ARCHITECTURE behavior OF fsm_diag IS

TYPE State_type IS (A, B, C, D);
SIGNAL y : State_type;

BEGIN
	PROCESS (reset, clock)
	BEGIN
					
		IF (clock'EVENT AND clock = '1') THEN		
			IF reset = '1' THEN -- A é o estado inicial
				y <= A;
			ELSE		
			CASE y IS
				WHEN A =>
					IF w = '0'
						THEN y <= A;
						ELSE y <= B;
					END IF;
				WHEN B =>
					IF w = '0'
						THEN y <= C;
						ELSE y <= B;
					END IF;
				WHEN C =>
					IF w = '0'
						THEN y <= C;
						ELSE y <= D;
					END IF;
				WHEN D =>
				IF w = '0'
					THEN y <= A;
					ELSE y <= D;
				END IF;
			END CASE;
			END IF;
		END IF;
	END PROCESS;
	
	z <= '1' WHEN y = B ELSE '0';

END BEHAVIOR;