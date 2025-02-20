interface memory_module_intf
#(parameter ADDR_WIDTH = 5, parameter DATA_WIDTH = 8)
(
    input clk,
    input debug
);

    logic read;
    logic write;
    logic [ADDR_WIDTH-1:0] addr;
    logic [DATA_WIDTH-1:0] data_in;
    logic [DATA_WIDTH-1:0] data_out;
    logic [DATA_WIDTH-1:0] out_data;
    
    // From TestBench perspective
    modport TB  (
        input clk,
        output read,
        output write,
        output addr,
        output data_in,
        input  data_out,
        output out_data,
        input debug
    );

    // From DUT perspective
    modport DUT (
        input clk,
        input read,
        input write,
        input addr,
        input data_in,
        output data_out
    );
endinterface