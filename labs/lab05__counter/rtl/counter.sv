`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2025 04:47:11 PM
// Design Name: 
// Module Name: counter
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


module counter(
    input logic clk,
    input logic rst_n,
    input logic [5:0] data,
    input logic load,
    input logic enable,
    output logic [5:0] count
    );
    
    
    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            count <= 0;
        end
        else begin
            if(load)
                count <= data;
            else if(enable)
                count <= count+1;
        end
                
    end
    
endmodule
