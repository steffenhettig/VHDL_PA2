-- Author: Steffen Hettig
-- Matrikel: 189318

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.numeric_bit.ALL;

ENTITY Kurzzeitwecker IS
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
END ENTITY Kurzzeitwecker;


ARCHITECTURE behavioral2 OF Kurzzeitwecker IS
	TYPE T_STATE IS (idle, setup_time, time_running, time_finish);

	SIGNAL min_output : INTEGER := 0;
	SIGNAL zehnsek_output : INTEGER := 0;
	SIGNAL sek_output : INTEGER := 0;
	SIGNAL dezisek_output : INTEGER := 0;
	
	SIGNAL min_mem : INTEGER := 0;
	SIGNAL zehnsek_mem : INTEGER := 0;
	SIGNAL sek_mem : INTEGER := 0;
	SIGNAL dezisek_mem : INTEGER := 0;
	
	SIGNAL min_counter : INTEGER := 0;
	
	SIGNAL m_vector : std_logic_vector(4 DOWNTO 0); --zur Bündelung von m4 bis m0
	SIGNAL z_vector : std_logic_vector(4 DOWNTO 0); --zur Bündelung von z4 bis z0
	SIGNAL s_vector : std_logic_vector(4 DOWNTO 0); --zur Bündelung von s4 bis s0
	SIGNAL d_vector : std_logic_vector(4 DOWNTO 0); --zur Bündelung von d4 bis d0
	
	COMPONENT vector_casting
	PORT(
		Dezimalzahl: IN INTEGER;
		b3, b2, b1, b0: OUT BIT);
	END COMPONENT;

BEGIN


output_logic : PROCESS (clk, dezisek_en) --Beschreibt, was im Zustand ausgeführt werden soll

VARIABLE SEK_last_state : std_logic := '0';
VARIABLE MIN_last_state : std_logic := '0';
VARIABLE CLEAR_last_state : std_logic := '0';
VARIABLE START_STOP_last_state : std_logic := '0';
VARIABLE leave_idle_flag : std_logic := '0';
VARIABLE counting_finish_flag : std_logic := '0';
VARIABLE back_to_setup_flag : std_logic := '0';
VARIABLE time_locked_flag : std_logic := '0';

VARIABLE current_state: T_StATE := idle;
VARIABLE next_state: T_STATE := idle;


BEGIN

	IF rising_edge(clk) THEN
	
	
	IF (current_state = time_running) THEN
		time_locked_flag := '1';
		IF (dezisek_en = '1') THEN
										dezisek_output <= dezisek_output -1;
									END IF;	
									IF(dezisek_output = -1) THEN
											dezisek_output <= 9;
											sek_output <= sek_output - 1;
											END IF;
									IF(sek_output = -1) THEN
												sek_output <= 9;
												zehnsek_output <= zehnsek_output - 1;
												END IF;
									IF(zehnsek_output = -1) THEN
													zehnsek_output <= 5;
													min_output <= min_output - 1;
												END IF;
											
											
										
									IF((min_output = 0) AND (zehnsek_output = 0) AND (sek_output = 0) AND (dezisek_output = 0)) THEN
										next_state := time_finish;
									END IF;

	END IF;
	
	IF (current_state = idle) THEN
		min_output <= 0;
		zehnsek_output <= 0;
		sek_output <= 0;
		dezisek_output <= 0;
	END IF;
	
	IF (current_state = setup_time) THEN
		IF (time_locked_flag = '0') THEN
			min_mem <= min_output;
			zehnsek_mem <= zehnsek_output;
			sek_mem <= sek_output;
			dezisek_mem <= dezisek_output;
		END IF;
		
	END IF;
	
	IF (current_state = time_finish) THEN
		IF (dezisek_en = '1') THEN
		min_counter <= min_counter + 1;
									
		tone_output <= '1';
		END IF;
		IF(min_counter > 60) THEN
			tone_output <= '0';
			min_counter <= 0;
			min_output <= min_mem;
			zehnsek_output <= zehnsek_mem;
			sek_output <= sek_mem;
			dezisek_output <= dezisek_mem;
			
			next_state := setup_time;
		END IF;
	END IF;
	
		-- If Sek-Button is pressed
		IF (SEK_last_state = '1') AND (SEK_BUTTON = '0') THEN
		
		CASE current_state IS
			WHEN idle =>
				time_locked_flag := '0';
				sek_output <= sek_output + 1;
				--leave_idle_flag <= '1';
				next_state := setup_time;
				
			WHEN setup_time =>
				time_locked_flag := '0';
				dezisek_output <= 0;
				sek_output <= sek_output + 1;
				
			WHEN OTHERS =>	
		END CASE;
		END IF;
		
		IF (sek_output = 10) THEN
			zehnsek_output <= zehnsek_output + 1;
			sek_output <= 0;
		END IF;
		IF (zehnsek_output = 6) THEN
			zehnsek_output <= 0;
		END IF;
		
		
		
		-- If Min-Button is pressed
		IF (MIN_last_state = '1') AND (MIN_BUTTON = '0') THEN
		
		CASE current_state IS
			WHEN idle =>
				min_output <= min_output + 1;
				next_state := setup_time;
				
			WHEN setup_time =>
				time_locked_flag := '0';
				dezisek_output <= 0;
				min_output <= min_output + 1;
				IF (min_output = 9) THEN
					min_output <= 0;
				END IF;
				
			WHEN OTHERS =>	
		END CASE;
		END IF;
		
	
	-- If Clear-Button is pressed
	IF (CLEAR_last_state = '1') AND (CLEAR_BUTTON = '0') THEN
		
		CASE current_state IS
				
			WHEN setup_time =>
				next_state := idle;
				
			WHEN OTHERS =>	
		END CASE;
		END IF;
	

	-- If Start-Stop-Button is pressed
	IF (START_STOP_last_state = '1') AND (START_STOP_BUTTON = '0') THEN
		
		CASE current_state IS
				
			WHEN setup_time =>
				next_state := time_running;
				
			WHEN time_running =>
				next_state := setup_time;
				
			WHEN time_finish =>
				tone_output <= '0';
				min_counter <= 0;
				min_output <= min_mem;
				zehnsek_output <= zehnsek_mem;
				sek_output <= sek_mem;
				dezisek_output <= dezisek_mem;
				
				next_state := setup_time;
				
			WHEN OTHERS =>	
		END CASE;
		END IF;	
		

	
		-- Zuweisungen, um die fallenden Flanken zu erkennen
		CLEAR_last_state := CLEAR_BUTTON;
		MIN_last_state := MIN_BUTTON;
		SEK_last_state := SEK_BUTTON;
		START_STOP_last_state := START_STOP_BUTTON;
		
		
		
		current_state := next_state;
		
	END IF;
	
	

		
END PROCESS output_logic;


				m_casting: COMPONENT vector_casting PORT MAP (Dezimalzahl => min_output, b3 => m3, b2 => m2, b1 => m1, b0 => m0);		
				z_casting: COMPONENT vector_casting PORT MAP (Dezimalzahl => zehnsek_output, b3 => z3, b2 => z2, b1 => z1, b0 => z0);
				s_casting: COMPONENT vector_casting PORT MAP (Dezimalzahl => sek_output, b3 => s3, b2 => s2, b1 => s1, b0 => s0);	
				d_casting: COMPONENT vector_casting PORT MAP (Dezimalzahl => dezisek_output, b3 => d3, b2 => d2, b1 => d1, b0 => d0);	

END behavioral2;
