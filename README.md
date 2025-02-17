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

Each lab contains:
- An **`rtl` folder** to store hardware designs.
- A **`tb` folder** for module testbenches.
- A **`srclist` file** that lists all the necessary modules and testbenches required to run the lab.

The lab folders follow the naming convention:  
**`lab${Number}__labName`**,  
and the main testbench for the lab should be named:  
**`labName_tb.sv`**.

With this pattern, when running the script, the code knows which module it needs to execute and which testbench is the main one for that lab.