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


module scale_mux
#(parameter DATA_WIDTH = 8)
(
    input logic [DATA_WIDTH-1:0] in_a, 
    input logic [DATA_WIDTH-1:0] in_b,
    input logic sel_b,
    output logic [DATA_WIDTH-1:0] out
    );

    always_comb begin: select_data
        if(sel_b) begin
            out <= in_b;
        end else begin
            out <= in_a;
        end
    end

endmodule