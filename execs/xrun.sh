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

echo "Use --R to run all, --g to gui, and -view top_sim.wcfg to load waveforms"

CURRENT_DIR=`dirname $0`
list=`${CURRENT_DIR}/srclist2path.sh "${CURRENT_DIR}/../srclist/riscv_small_tb.srclist"`
echo ${list}

${CURRENT_DIR}/../bin/compile_tests.sh
if [ $? == 1 ]; then
    echo -e "${red}ERROR: Error detected on compiling test!${clear}"
    exit 1
fi

xvlog  -L uvm -sv ${XILINX_VIVADO}/data/system_verilog/uvm_1.2/uvm_macros.svh ${list}
xelab  riscv_small_tb --timescale 1ns/1ps -L uvm -s top_sim --debug typical --mt 16 --incr
xsim   top_sim -testplusarg UVM_TESTNAME=myTest $@