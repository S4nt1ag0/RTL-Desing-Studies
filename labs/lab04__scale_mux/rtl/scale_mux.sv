`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2025 04:47:11 PM
// Design Name: 
// Module Name: scale_mux
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


module scale_mux(
    input logic [7:0] in_a, 
    input logic [7:0] in_b,
    input logic sel_a,
    output logic [7:0] out
    );

    always_comb begin: select_data
        if(!sel_a) begin
            out <= in_b;
        end else begin
            out <= in_a;
        end
    end

endmodule