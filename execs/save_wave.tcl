# Log all signals recursively
add_wave -recursive *

# Run simulation until completion
run all

# Save waveform database
save_wave_config ./waveforms.wcfg

# Check if RUN_GUI is set; if not, exit simulation
if { [expr {$::env(RUN_GUI) == 0}] } {
    quit
}