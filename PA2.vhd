-- Author: Steffen Hettig
-- Matrikel: 189318
-- Datum: 01.06.2024

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY PA2 IS
PORT(
	clk : IN std_logic;
	MIN_BUTTON : IN std_logic;
	SEK_BUTTON : IN std_logic;
	CLEAR_BUTTON : IN std_logic;
	START_STOP_BUTTON : IN std_logic;
	dezisek_en : BUFFER std_logic := '0';
	m3, m2, m1, m0: BUFFER std_logic;
	z3, z2, z1, z0: BUFFER std_logic;
	s3, s2, s1, s0: BUFFER std_logic;
	d3, d2, d1, d0: BUFFER std_logic;
   min_g, min_f, min_e, min_d, min_c, min_b, min_a: OUT std_logic;
	zehnsek_g, zehnsek_f, zehnsek_e, zehnsek_d, zehnsek_c, zehnsek_b, zehnsek_a: OUT std_logic;
	sek_g, sek_f, sek_e, sek_d, sek_c, sek_b, sek_a: OUT std_logic;
	dezisek_g, dezisek_f, dezisek_e, dezisek_d, dezisek_c, dezisek_b, dezisek_a: OUT std_logic;
	tone_output : BUFFER std_logic;
	tone_signal : BUFFER std_logic;
	force_g, force_f, force_e, force_d, force_c, force_b, force_a: OUT std_logic);
END ENTITY PA2;

ARCHITECTURE Behavioral OF PA2 IS

	COMPONENT taktteiler
		PORT(
			clk : IN std_logic;
			takt : OUT std_logic);
	END COMPONENT;
	
	COMPONENT Kurzzeitwecker
	PORT(
		clk : IN std_logic;
		MIN_BUTTON : IN std_logic;
		SEK_BUTTON : IN std_logic;
		CLEAR_BUTTON : IN std_logic;
		START_STOP_BUTTON : IN std_logic;
		dezisek_en : IN std_logic;
		m3, m2, m1, m0: BUFFER std_logic;
		z3, z2, z1, z0: BUFFER std_logic;
		s3, s2, s1, s0: BUFFER std_logic;
		d3, d2, d1, d0: BUFFER std_logic;
		tone_output : OUT std_logic);
	END COMPONENT;

	COMPONENT ZifferDecoder
	PORT(
		b3, b2, b1, b0: IN std_logic;
		g, f, e, d, c, b, a: OUT std_logic);
	END COMPONENT;
	
	COMPONENT Tonausgabe
	PORT(
		tone_output : IN std_logic;
		clk : IN std_logic;
		dezisek_en : IN std_logic;
		tone_signal : BUFFER std_logic);
	END COMPONENT;
	
BEGIN

	force_a <= '1';
	force_b <= '1';
	force_c <= '1';
	force_d <= '1';
	force_e <= '1';
	force_f <= '1';
	force_g <= '1';

	clock_divider: COMPONENT Taktteiler PORT MAP (clk => clk, takt => dezisek_en);
	
	Kurzzeitwecker1: COMPONENT Kurzzeitwecker PORT MAP (clk => clk, MIN_BUTTON => MIN_BUTTON, SEK_BUTTON => SEK_BUTTON, CLEAR_BUTTON => CLEAR_BUTTON, START_STOP_BUTTON => START_STOP_BUTTON, dezisek_en => dezisek_en, m3 => m3, m2 => m2, m1 => m1, m0 => m0, z3 => z3, z2 => z2, z1 => z1, z0 => z0, s3 => s3, s2 => s2, s1 => s1, s0 => s0, d3 => d3, d2 => d2, d1 => d1, d0 => d0, tone_output => tone_output);
	
	min_decoder: COMPONENT ZifferDecoder PORT MAP (b3 => m3, b2 => m2, b1 => m1, b0 => m0, g => min_g, f => min_f, e => min_e, d => min_d, c => min_c, b => min_b, a => min_a);
	zehnsek_decoder: COMPONENT ZifferDecoder PORT MAP (b3 => z3, b2 => z2, b1 => z1, b0 => z0, g => zehnsek_g, f => zehnsek_f, e => zehnsek_e, d => zehnsek_d, c => zehnsek_c, b => zehnsek_b, a => zehnsek_a);
	sek_decoder: COMPONENT ZifferDecoder PORT MAP (b3 => s3, b2 => s2, b1 => s1, b0 => s0, g => sek_g, f => sek_f, e => sek_e, d => sek_d, c => sek_c, b => sek_b, a => sek_a);
	dezisek_decoder: COMPONENT ZifferDecoder PORT MAP (b3 => d3, b2 => d2, b1 => d1, b0 => d0, g => dezisek_g, f => dezisek_f, e => dezisek_e, d => dezisek_d, c => dezisek_c, b => dezisek_b, a => dezisek_a);
	Tonausgabe1: COMPONENT Tonausgabe PORT MAP (tone_output => tone_output, clk => clk, dezisek_en => dezisek_en, tone_signal => tone_signal);	
					
END ARCHITECTURE Behavioral;
