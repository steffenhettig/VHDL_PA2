-- Author: Steffen Hettig
-- Matrikel: 189318
-- Datum: 01.06.2024

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Tonausgabe IS
PORT(
	tone_output : IN std_logic;
	clk : IN std_logic;
	dezisek_en : IN std_logic;
	tone_signal : BUFFER std_logic);
END ENTITY Tonausgabe;

ARCHITECTURE behavioral6 OF Tonausgabe IS
	SIGNAL tone_output_counter : INTEGER := 0;
BEGIN
synch: PROCESS (clk, dezisek_en)

BEGIN
			IF rising_edge(clk) THEN
				IF dezisek_en = '1' THEN
					IF tone_output = '1' THEN
						tone_output_counter <= tone_output_counter + 1;
						--toggle tone_signal
						IF tone_output_counter <= 5 THEN
							tone_signal <= tone_signal XOR '1';
						END IF;
						--Resetting takt_counter after one period
						IF tone_output_counter = 10 THEN
							tone_output_counter <= 0;
						END IF;
					ELSE
						--clear tone_signal + reset tone_output_counter
						tone_signal <= '0';
						tone_output_counter <= 0;
					END IF;
				END IF;	
		END IF;
		
END PROCESS synch;
END ARCHITECTURE behavioral6;
