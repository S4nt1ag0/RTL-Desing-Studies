`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2025 04:47:11 PM
// Design Name: 
// Module Name: register
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


module register
#(parameter DATA_WIDTH = 8)
(
    input logic clk,
    input logic rst_n,
    input logic [DATA_WIDTH-1 :0] data,
    input logic enable,
    output logic [DATA_WIDTH-1:0] out
    );

    always_ff @(posedge clk, negedge rst_n) begin: get_data
        if(!rst_n) begin
            out <= '0;
        end else if(enable) begin
            out <= data;
        end
    end

endmodule