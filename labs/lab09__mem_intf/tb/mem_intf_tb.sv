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

module mem_intf_tb();
    localparam ADDR_WIDTH = 5;
    localparam DATA_WIDTH = 8;
    localparam CLK_PERIOD = 5ns;

    logic clk;
    bit debug=0;
    
    memory_module_intf #(.ADDR_WIDTH (ADDR_WIDTH), .DATA_WIDTH (DATA_WIDTH)) memoryIntf (clk, debug);

    memory_module #(.ADDR_WIDTH (ADDR_WIDTH), .DATA_WIDTH (DATA_WIDTH)) dut (memoryIntf.DUT);

    mem_test #(.ADDR_WIDTH (ADDR_WIDTH), .DATA_WIDTH (DATA_WIDTH)) tb(memoryIntf.TB);

    initial begin
        clk = 1;
        forever begin
            #CLK_PERIOD
            clk = ~clk;
        end
    end

    initial begin
        $dumpfile("lab_08.vcd");
        $dumpvars(0, tb);
    end

endmodule

