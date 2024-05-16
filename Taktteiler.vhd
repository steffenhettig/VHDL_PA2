-- Author: Steffen Hettig
-- Matrikel: 189318

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Taktteiler IS
PORT(
	clk : IN std_logic;
	takt : OUT std_logic);
END ENTITY Taktteiler;

ARCHITECTURE behavioral1 OF Taktteiler IS
	CONSTANT CLK_FREQ : INTEGER := 50;--000000; --Frequency in Hz
	CONSTANT TAKT_FREQ : INTEGER := 10; --Frequency in Hz
BEGIN
synch: PROCESS (clk)
		VARIABLE takt_counter : INTEGER := 0;
BEGIN
		IF rising_edge(clk) THEN
				takt_counter := takt_counter + 1;
				
				--Set takt to '1' or '0' depending on the clock cycle
				IF takt_counter <= 1 THEN
					takt <= '1';
				ELSE
					takt <= '0';
				END IF;
				
				--Resetting takt_counter after one period
				IF takt_counter = (CLK_FREQ/TAKT_FREQ) THEN
					takt_counter := 0;
				END IF;
		END IF;
END PROCESS synch;
END ARCHITECTURE behavioral1;
