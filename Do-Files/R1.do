# Author: Steffen Hettig
# Matrikel: 189318
# Datum: 01.06.2024

#########################
# Do File Requirement 1 #
#########################
# -- Restart Simulation 
restart -force -nolist -nowave -nobreak -nolog 
onerror {resume}

#--log all waves including the not shown ones 
log -r /*

#-- Add the waves needed to be displayed 
#-- Two ways can be used to add signals 
#-- either each signal by its name and path 
#-- or use add wave /*
add wave /*

#--------------------FORCE SIGNALS HERE ---------
#-- Syntax: force signalname value1 time1, value2 time2,… 
#-- e.g.
#-- force signal_x 0 0ns, 1 10ns, 0 30ns, Z 100ns
#-- use s, us, ms, ns, ps, fs as timescale
#-- To override the signal of a driver use –freeze
#-- default timescale is ps
#--‘-r’ is used for repetition


# Durch die fallenden Flanken von Min- und Sek-Button soll die Minuten und Sekunden erhöht werden
# Es wurde darauf geachtet, dass die Periodendauern von SEK_BUTTON und MIN_BUTTON keine Vielfache voneinander sind, um mehr "Zufälligkeit" zu generieren
# Außerdem wurde mit den gewählten Simulationswerten für CLEAR_BUTTON versucht, das sporadische Drücken (wie in der Realität auch) abzubilden

force clk 1 0, 0 {50 ps} -r {100 ps}
force SEK_BUTTON 1 0, 0 {100 ps} -r {800 ps}
force MIN_BUTTON 1 0, 0 {50 ps} -r {900 ps}
force CLEAR_BUTTON 1 0, 0 {50 ps} -r {9300 ps}

run 50000 ps
