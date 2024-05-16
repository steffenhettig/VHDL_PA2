-- Author: Steffen Hettig
-- Matrikel: 189318

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY PA2 IS
PORT(
	clk : IN std_logic;
	MIN_BUTTON_Hardware : IN std_logic;
	SEK_BUTTON_Hardware : IN std_logic;
	CLEAR_BUTTON_Hardware : IN std_logic;
	START_STOP_BUTTON_Hardware : IN std_logic;
	dezisek_en : BUFFER std_logic := '0';
	m3, m2, m1, m0: BUFFER BIT;
	z3, z2, z1, z0: BUFFER BIT;
	s3, s2, s1, s0: BUFFER BIT;
	d3, d2, d1, d0: BUFFER BIT;
   min_g, min_f, min_e, min_d, min_c, min_b, min_a: OUT BIT;
	zehnsek_g, zehnsek_f, zehnsek_e, zehnsek_d, zehnsek_c, zehnsek_b, zehnsek_a: OUT BIT;
	sek_g, sek_f, sek_e, sek_d, sek_c, sek_b, sek_a: OUT BIT;
	dezisek_g, dezisek_f, dezisek_e, dezisek_d, dezisek_c, dezisek_b, dezisek_a: OUT BIT;
	tone_output : BUFFER std_logic;
	tone_signal : BUFFER std_logic);
END ENTITY PA2;

ARCHITECTURE Behavioral OF PA2 IS

	SIGNAL MIN_BUTTON : std_logic := '0';
	SIGNAL SEK_BUTTON : std_logic := '0';
	SIGNAL CLEAR_BUTTON : std_logic := '0';
	SIGNAL START_STOP_BUTTON : std_logic := '0';

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
		m3, m2, m1, m0: BUFFER BIT;
		z3, z2, z1, z0: BUFFER BIT;
		s3, s2, s1, s0: BUFFER BIT;
		d3, d2, d1, d0: BUFFER BIT;
		tone_output : OUT std_logic);
	END COMPONENT;

	COMPONENT ZifferDecoder
	PORT(
		b3, b2, b1, b0: IN BIT;
		g, f, e, d, c, b, a: OUT BIT);
	END COMPONENT;
	
	COMPONENT Tonausgabe
	PORT(
		tone_output : IN std_logic;
		clk : IN std_logic;
		dezisek_en : IN std_logic;
		tone_signal : BUFFER std_logic);
	END COMPONENT;
	
	COMPONENT Debouncing
	PORT(
		Button_Hardware: IN std_logic;
		Button_Software: OUT std_logic);
	END COMPONENT;
	
	
BEGIN
--	Min_Button_Debouncing: COMPONENT Debouncing PORT MAP (Button_Hardware => MIN_BUTTON_Hardware, Button_Software => MIN_BUTTON);
--	Sek_Button_Debouncing: COMPONENT Debouncing PORT MAP (Button_Hardware => SEK_BUTTON_Hardware, Button_Software => SEK_BUTTON);	
--	Clear_Button_Debouncing: COMPONENT Debouncing PORT MAP (Button_Hardware => CLEAR_BUTTON_Hardware, Button_Software => CLEAR_BUTTON);	
--	Start_Stop_Button_Debouncing: COMPONENT Debouncing PORT MAP (Button_Hardware => START_STOP_BUTTON_Hardware, Button_Software => START_STOP_BUTTON);

	MIN_BUTTON <= NOT MIN_BUTTON_Hardware;
	SEK_BUTTON <= NOT SEK_BUTTON_Hardware;
	CLEAR_BUTTON <= NOT CLEAR_BUTTON_Hardware;
	START_STOP_BUTTON <= NOT START_STOP_BUTTON_Hardware;


	clock_divider: COMPONENT Taktteiler PORT MAP (clk => clk, takt => dezisek_en);
	
	Kurzzeitwecker1: COMPONENT Kurzzeitwecker PORT MAP (clk => clk, MIN_BUTTON => MIN_BUTTON, SEK_BUTTON => SEK_BUTTON, CLEAR_BUTTON => CLEAR_BUTTON, START_STOP_BUTTON => START_STOP_BUTTON, dezisek_en => dezisek_en, m3 => m3, m2 => m2, m1 => m1, m0 => m0, z3 => z3, z2 => z2, z1 => z1, z0 => z0, s3 => s3, s2 => s2, s1 => s1, s0 => s0, d3 => d3, d2 => d2, d1 => d1, d0 => d0, tone_output => tone_output);
	
	min_decoder: COMPONENT ZifferDecoder PORT MAP (b3 => m3, b2 => m2, b1 => m1, b0 => m0, g => min_g, f => min_f, e => min_e, d => min_d, c => min_c, b => min_b, a => min_a);
	zehnsek_decoder: COMPONENT ZifferDecoder PORT MAP (b3 => z3, b2 => z2, b1 => z1, b0 => z0, g => zehnsek_g, f => zehnsek_f, e => zehnsek_e, d => zehnsek_d, c => zehnsek_c, b => zehnsek_b, a => zehnsek_a);
	sek_decoder: COMPONENT ZifferDecoder PORT MAP (b3 => s3, b2 => s2, b1 => s1, b0 => s0, g => sek_g, f => sek_f, e => sek_e, d => sek_d, c => sek_c, b => sek_b, a => sek_a);
	dezisek_decoder: COMPONENT ZifferDecoder PORT MAP (b3 => d3, b2 => d2, b1 => d1, b0 => d0, g => dezisek_g, f => dezisek_f, e => dezisek_e, d => dezisek_d, c => dezisek_c, b => dezisek_b, a => dezisek_a);
--	Tonausgabe1: COMPONENT Tonausgabe PORT MAP (tone_output => tone_output,
--																clk => clk,
--																dezisek_en => dezisek_en,
--																tone_signal => tone_signal);	

--deb_process : PROCESS (MIN_BUTTON_Hardware)
--BEGIN
----	IF (MIN_BUTTON_Hardware = '1') THEN
----		tone_signal <= '1';
----	ELSE
----		tone_signal <= '0';
----	END IF;
--	MIN_BUTTON <= NOT MIN_BUTTON_Hardware;
--	SEK_BUTTON <= NOT SEK_BUTTON_Hardware;
--	CLEAR_BUTTON <= NOT CLEAR_BUTTON_Hardware;
--	START_STOP_BUTTON <= NOT START_STOP_BUTTON_Hardware;
--
--END PROCESS deb_process;		
						
END ARCHITECTURE Behavioral;
