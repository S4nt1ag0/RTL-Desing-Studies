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
    
    task automatic write_mem(
        input [ADDR_WIDTH-1:0] in_addr,
        input [DATA_WIDTH-1:0] in_data
    );
        @(negedge clk);
        write <= 1'b1;
        read  <= 1'b0;
        addr  <= in_addr;
        data_in <= in_data;
        @(negedge clk);
        write <= 1'b0;
        if (debug)
            $display("Write Data | Address = %d, Data = %h", in_addr, in_data);
    endtask: write_mem

    task automatic read_mem(
        input [ADDR_WIDTH-1:0] in_addr,
        output [DATA_WIDTH-1:0] out_data
    );
        @(negedge clk);
        write <= 1'b0;
        read  <= 1'b1;
        addr  <= in_addr;
        @(negedge clk);
        out_data = data_out;
        read <= 1'b0;
        @(negedge clk); //Extra delay to ensure the read value is returned
        if (debug)
            $display("Read Data | Address = %d, Data = %h", in_addr, out_data);
    endtask: read_mem

    // From TestBench perspective
    modport TB  (
        input clk,
        output read,
        output write,
        output addr,
        output data_in,
        input  data_out,
        output out_data,
        input debug,
        import write_mem,
        import read_mem
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