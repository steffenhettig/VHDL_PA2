-- Author: Steffen Hettig
-- Matrikel: 189318
-- Datum: 01.06.2024

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY vector_casting IS
PORT (	
	Dezimalzahl : IN INTEGER;
	b3, b2, b1, b0: OUT std_logic);
END ENTITY vector_casting;

ARCHITECTURE behavioral5 OF vector_casting is
   SIGNAL b_vector: std_logic_vector(3 DOWNTO 0); -- Vektor b3,b2,b1,b0 

BEGIN

WITH Dezimalzahl SELECT
            b_vector <= "0000" WHEN 0,
                        "0001" WHEN 1,
                        "0010" WHEN 2,
                        "0011" WHEN 3,
                        "0100" WHEN 4,
                        "0101" WHEN 5,
                        "0110" WHEN 6,
                        "0111" WHEN 7,
                        "1000" WHEN 8,
                        "1001" WHEN 9,
                        "0000" WHEN OTHERS;

b3 <= b_vector(3);
b2 <= b_vector(2);
b1 <= b_vector(1);
b0 <= b_vector(0);

END behavioral5;
