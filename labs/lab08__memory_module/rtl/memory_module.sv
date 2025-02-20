`timescale 1ns/100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2025 01:34:33 PM
// Design Name: 
// Module Name: memory_module
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

module memory_module
#(parameter ADDR_WIDTH = 5, parameter DATA_WIDTH = 8)
(
    input logic clk,
    input logic read,
    input logic write,
    input logic [ADDR_WIDTH-1:0] addr,
    input logic [DATA_WIDTH-1:0] data_in,
    output logic [DATA_WIDTH-1:0] data_out
);

logic [DATA_WIDTH-1:0] mem_block [0:(2**ADDR_WIDTH)-1];

always_ff @(posedge clk) begin: write_or_read

if(write==1 && read == 0)
    mem_block[addr] <= data_in;
else if(write == 0 && read == 1)
    data_out <= mem_block[addr];
end
endmodule