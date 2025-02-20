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
    memory_module_intf intf
);

logic [DATA_WIDTH-1:0] mem_block [0:(2**ADDR_WIDTH)-1];

always_ff @(posedge intf.clk) begin: write_or_read

if(intf.write==1 && intf.read == 0)
    mem_block[intf.addr] <= intf.data_in;
else if(intf.write == 0 && intf.read == 1)
    intf.data_out <= mem_block[intf.addr];
end
endmodule