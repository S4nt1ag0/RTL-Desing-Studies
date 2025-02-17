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


module register(
    input logic clk,
    input logic rst_n,
    input logic [7:0] data,
    input logic enable,
    output logic [7:0] out
    );

    always_ff @(posedge clk, negedge rst_n) begin: get_data
        if(!rst_n) begin
            out <= 8'b0;
        end else if(enable) begin
            out <= data;
        end
    end

endmodule