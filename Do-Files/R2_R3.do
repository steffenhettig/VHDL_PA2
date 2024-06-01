# Author: Steffen Hettig
# Matrikel: 189318
# Datum: 01.06.2024

###############################
# Do File Requirement 2 und 3 #
###############################
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


# Durch die fallenden Flanken von Min-Button soll die Minuten erhöht werden, um eine Start-Zeit einzustellen
# Anschließend mit einer fallenden Flanke von Start-Stop-Button die Zeitmessung gestartet
# Außerdem wurde mit den gewählten Simulationswerten für START_STOP_BUTTON versucht, das sporadische Drücken (wie in der Realität auch) abzubilden

force clk 1 0, 0 {50 ps} -r {100 ps}
force MIN_BUTTON 1 0, 0 {50 ps} -r {200 ps}
force START_STOP_BUTTON 1 0, 0 {50 ps} -r {5100 ps}

run 30000 ps
