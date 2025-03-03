#!/bin/bash
# Color variables
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'
# Clear the color after that
clear='\033[0m'

echo "Use: ./run_sim.sh <lab_folder_name> --R to run all, --g to gui, and -view top_sim.wcfg to load waveforms"

# Verifica se o parâmetro foi passado
if [ -z "$1" ]; then
    echo -e "${red}Erro: Você precisa passar o nome da pasta do laboratório como argumento!${clear}"
    exit 1
fi

# Get the current script directory
CURRENT_DIR=`dirname $0`
CURRENT_DIR=$(realpath "$CURRENT_DIR")

# Name of the lab passed as an argument
LAB_FOLDER=$1

# Define the build directory
BUILD_DIR="${CURRENT_DIR}/../build"

# Navigate to the build directory or display an error if it fails
cd "$BUILD_DIR" || { echo -e "${red}Error: Unable to access the build directory!${clear}"; exit 1; }

# Retrieve the list of source files using srclist2path.sh
list=$("${CURRENT_DIR}/srclist2path.sh" "${CURRENT_DIR}/../labs/${LAB_FOLDER}/srclists" "${CURRENT_DIR}/../labs/${LAB_FOLDER}")

# Display the list of retrieved source files
echo ${list}

# Extract the testbench file name based on the lab name
tb_name=$(echo "$LAB_FOLDER" | cut -d'_' -f3-)
export tb_file="${tb_name}""_tb"

# Compile the SystemVerilog files with UVM support
xvlog  -L uvm -sv ${XILINX_VIVADO}/data/system_verilog/uvm_1.2/uvm_macros.svh ${list}

# Elaborate the testbench and generate the simulation using Xilinx xsim
xelab  ${tb_file} --timescale 1ns/1ps -L uvm -s top_sim --debug typical --mt 16 --incr

# Check if the program will run with a graphical interface or not  
if [[ " ${@:2} " =~ " --g " ]] || [[ "${@:2} " =~ " --gui" ]]; then
    export RUN_GUI=1  # Enable GUI mode
else
    export RUN_GUI=0  # Disable GUI mode (run in batch mode)
fi

# Run the simulation in Xilinx xsim with additional arguments
xsim   top_sim -testplusarg UVM_TESTNAME=myTest ${@:2} --tclbatch ../execs/save_wave.tcl