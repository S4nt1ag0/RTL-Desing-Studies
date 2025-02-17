`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2025 11:05:34 AM
// Design Name: 
// Module Name: Alu_pkg
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


package definitions;
   parameter VERSION = "1.1";
   localparam DEFAULT_WORD_W = 8;
   localparam OPCODE_WITH = 3;
   
   typedef enum logic [OPCODE_WITH-1:0] {ADD, OR_BIT_BIT, AND_BIT_BIT, EXP, SUB, MUL} opcodes_t;
   typedef struct {
    logic [DEFAULT_WORD_W-1:0] a, b;
    opcodes_t opcode;
   } instruction_t;
   typedef logic [DEFAULT_WORD_W-1:0] result_t;
endpackage 
