`timescale 1ns/100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2025 01:34:33 PM
// Design Name: 
// Module Name: memory_module_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module memory_module_tb();
    localparam ADDR_WIDTH = 5;
    localparam DATA_WIDTH = 8;
    localparam CLK_PERIOD = 5ns;

    logic clk;
    logic read;
    logic write;
    logic [ADDR_WIDTH-1:0] addr;
    logic [DATA_WIDTH-1:0] data_in;
    logic [DATA_WIDTH-1:0] data_out;

    bit debug=0;
    logic [DATA_WIDTH-1:0] out_data;

    initial begin
        clk = 1;
        forever begin
            #CLK_PERIOD
            clk = ~clk;
        end
    end

    memory_module #(.ADDR_WIDTH (ADDR_WIDTH), .DATA_WIDTH (DATA_WIDTH)) dut(
        .clk      (clk      ),
        .read     (read     ),
        .write    (write    ),
        .addr     (addr     ),
        .data_in  (data_in  ),
        .data_out (data_out )
    );

    mem_test #(.ADDR_WIDTH (ADDR_WIDTH), .DATA_WIDTH (DATA_WIDTH)) tb(
        .clk      (clk      ),
        .read     (read     ),
        .write    (write    ),
        .addr     (addr     ),
        .data_in  (data_in  ),
        .data_out (data_out ),
        .out_data (out_data),
        .debug (debug)
    );

    initial begin
        $dumpfile("lab_08.vcd");
        $dumpvars(0, tb);
    end

endmodule

