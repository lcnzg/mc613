library ieee;

USE ieee.std_logic_1164.all;


ENTITY fsm_seq IS
	PORT(clock, reset, w : IN STD_LOGIC;
		  z					: OUT STD_LOGIC
	);
END fsm_seq;


ARCHITECTURE behavior OF fsm_seq IS

TYPE State_type IS (A, B, C, D, E);
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
						THEN y <= B;
						ELSE y <= A;
					END IF;
				WHEN B =>
					IF w = '0'
						THEN y <= B;
						ELSE y <= C;
					END IF;
				WHEN C =>
					IF w = '0'
						THEN y <= D;
						ELSE y <= A;
					END IF;
				WHEN D =>
				IF w = '0'
					THEN y <= B;
					ELSE y <= E;
				END IF;
				WHEN E =>
				IF w = '0'
					THEN y <= D;
					ELSE y <= A;
				END IF;
			END CASE;
			END IF;
		END IF;
	END PROCESS;
	
	z <= '1' WHEN y = E ELSE '0';


END BEHAVIOR;