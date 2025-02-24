`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2025 01:34:33 PM
// Design Name: 
// Module Name: alu_control
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

module alu_control
import typedefs::*;
#(parameter DATA_WIDTH = DEFAULT_WORD_W)
(
    input logic clk,
    input opcodes_t opcode,
    input logic [DEFAULT_WORD_W-1:0] data,
    input logic [DEFAULT_WORD_W-1:0] accum,
    output logic [DEFAULT_WORD_W-1:0] out,
    output logic zero
);

always_comb begin: zero_statement
    if(accum == 8'b0)
        zero = 1;
    else
        zero = 0;
end

always_ff @(negedge clk) begin: alu_decode
    case (opcode)
        HLT: out <= accum;
        SKZ: out <= accum;
        ADD: out <= data + accum;
        AND: out <= data & accum;
        XOR: out <= data ^ accum;
        LDA: out <= data;
        STO: out <= accum;
        JMP: out <= accum;
    endcase
end


endmodule
