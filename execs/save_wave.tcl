if {[file exists "$::env(tb_file).wcfg"]} {
    # Load existing waveform configuration
    open_wave_config "$::env(tb_file).wcfg"
} else {
    # Default configuration if the file does not exist
    add_wave -recursive *
    save_wave_config "./waveforms.wcfg"
}

# Run simulation until completion
run all

# Check if RUN_GUI is set; if not, exit simulation
if { [expr {$::env(RUN_GUI) == 0}] } {
    quit
}