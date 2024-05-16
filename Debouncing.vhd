-- Author: Steffen Hettig
-- Matrikel: 189318

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY Debouncing IS
PORT (	
	Button_Hardware: IN BIT;
   Button_Software: OUT std_logic);
END ENTITY Debouncing;

ARCHITECTURE behavioral7 OF Debouncing is
	SIGNAL ticks : INTEGER := 0;
	SIGNAL last_tick : INTEGER := 0;

BEGIN

deb_process : PROCESS (Button_Hardware)
BEGIN

	IF (Button_Hardware = '1') THEN
		IF (ticks - last_tick) > 9 THEN
			Button_Software <= '1';
		ELSE
			Button_Software <= '0';
		END IF;
		last_tick <= ticks;
	END IF;
	ticks <= ticks + 1;
	
END PROCESS deb_process;

END behavioral7;
