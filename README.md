# RTL-Design-Studies
A repository dedicated to learning and exploring digital circuits using SystemVerilog. It covers RTL design, hardware modeling, logic synthesis, and best practices for FPGA/ASIC projects.

## How to Run
Navigate to the project directory and source the Vivado or Vitis environment:
```bash
$ source /opt/Xilinx/Vitis/2024.1/settings64.sh
or
$ source /opt/Xilinx/Vivado/2024.1/.settings64-Vivado.sh 
```

Choose the lab and run the `xrun` script, like the example:
```bash
$ ./execs/xrun.sh lab0__arithmetic_unit
or
$ ./execs/xrun.sh lab0__arithmetic_unit --g
```

## Lab Structure  
Each lab contains:  
- **`rtl/`** → Hardware design files  
- **`tb/`** → Testbenches (main testbench: `labName_tb.sv`)  
- **`srclist`** → Lists required modules and testbenches  

### Usage  
Run the script to create a new lab:  
```bash
./execs/create_lab.sh <lab_number> <lab_name>
```
Example:  
```bash
./execs/create_lab.sh 1 alu
```
This generates:  
```
labs/
└── lab1__alu/
    ├── rtl/
    ├── tb/ (includes alu_tb.sv)
    └── srclist
```