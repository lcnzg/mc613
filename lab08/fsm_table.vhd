library ieee;
USE ieee.std_logic_1164.all;


ENTITY fsm_table IS
	PORT(clock, reset, w : IN STD_LOGIC;
		  z					: OUT STD_LOGIC
	);
END fsm_table;


ARCHITECTURE behavior OF fsm_table IS

TYPE State_type IS (A, B, C, D);
SIGNAL y : State_type := A;

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
						THEN y <= C;
						ELSE y <= B;
					END IF;
				WHEN B =>
					IF w = '0'
						THEN y <= D;
						ELSE y <= C;
					END IF;
				WHEN C =>
					IF w = '0'
						THEN y <= B;
						ELSE y <= C;
					END IF;
				WHEN D =>
					IF w = '0' THEN
						y <= A; 
					ELSE
						y <= C;
				END IF;
			END CASE;
		END IF;
	END IF;
END PROCESS;

PROCESS (y, w)
BEGIN
	CASE y IS
		WHEN A =>
			z <= '1';
		WHEN B =>
			IF w = '0' THEN
				z <= '1';
			ELSE
				z <= '0';
			END IF;
		WHEN C =>
			z <= '0';
		WHEN D =>
			IF w = '0' THEN
				z <= '0';
			ELSE
				z <= '1';
			END IF;
	END CASE;
END PROCESS;

END BEHAVIOR;