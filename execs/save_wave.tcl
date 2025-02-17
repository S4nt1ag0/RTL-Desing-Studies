# Log all signals recursively
log_wave -recursive *

# Run simulation until completion
run all

# Save waveform database
save_wave_database ./waveforms.wdb

# Close simulation
quit