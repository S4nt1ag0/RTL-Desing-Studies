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

CURRENT_DIR=`dirname $0`
CURRENT_DIR=$(realpath "$CURRENT_DIR")
LAB_FOLDER=$1 # Nome do laboratório passado como argumento
# Diretório de build (src/builds)
BUILD_DIR="${CURRENT_DIR}/../build"

cd "$BUILD_DIR" || { echo -e "${red}Erro: Não foi possível acessar o diretório de build!${clear}"; exit 1; }

list=$("${CURRENT_DIR}/srclist2path.sh" "${CURRENT_DIR}/../labs/${LAB_FOLDER}/srclists" "${CURRENT_DIR}/../labs/${LAB_FOLDER}")

echo ${list}

# Extrai o testbench (ultimo elemento da lista)
last_file=$(echo "$list" | awk '{print $NF}')  # Pega o último item
tb_name=$(basename "$last_file" .sv)    # Remove o caminho e a extensão

#xvlog  -L uvm -sv ${XILINX_VIVADO}/data/system_verilog/uvm_1.2/uvm_macros.svh ${list} > "xvlog.log" 2>&1
#xelab  riscv_small_tb --timescale 1ns/1ps -L uvm -s top_sim --debug typical --mt 16 --incr > "xelab.log" 2>&1
#xsim   top_sim -testplusarg UVM_TESTNAME=myTest $@ > "xsim.log" 2>&1
echo "#################### ANTES DO XVLOG ###########################################"
xvlog  -L uvm -sv ${XILINX_VIVADO}/data/system_verilog/uvm_1.2/uvm_macros.svh ${list}
echo "#################### ANTES DO XVLAB ###########################################"
xelab  ${tb_name} --timescale 1ns/1ps -L uvm -s top_sim --debug typical --mt 16 --incr
echo "#################### ANTES DO XSIM ###########################################"
xsim   top_sim -testplusarg UVM_TESTNAME=myTest $@