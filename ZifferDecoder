-- Author: Steffen Hettig
-- Matrikel: 189318
-- Datum: 01.06.2024

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY ZifferDecoder IS
PORT (	
	b3, b2, b1, b0: IN std_logic;
   g, f, e, d, c, b, a: OUT std_logic);
END ENTITY ZifferDecoder;

ARCHITECTURE behavioral3 OF ZifferDecoder is
SIGNAL output_vector: std_logic_vector (6 DOWNTO 0); -- Vektor g, f, e, d, c, b, a
SIGNAL b_vector: std_logic_vector(3 DOWNTO 0); -- Vektor b4,b3,b2,b1,b0 

BEGIN
b_vector <= (b3,b2,b1,b0); -- Aggregat zur Buendelung von einzelnen Bits 
with b_vector select
    output_vector <= 
                "1000000" when "0000", --0
                "1111001" when "0001", --1
                "0100100" when "0010", --2
                "0110000" when "0011", --3
                "0011001" when "0100", --4
                "0010010" when "0101", --5
                "0000010" when "0110", --6
                "1111000" when "0111", --7
                "0000000" when "1000", --8
                "0010000" when "1001", --9
                "0000110" when others; --others: E(rror)

					
g <= output_vector(6);
f <= output_vector(5);
e <= output_vector(4);
d <= output_vector(3);
c <= output_vector(2);
b <= output_vector(1);
a <= output_vector(0);

END behavioral3;
