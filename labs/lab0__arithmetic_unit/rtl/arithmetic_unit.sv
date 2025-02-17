`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2025 01:34:33 PM
// Design Name: 
// Module Name: arithmetic_unit
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


module arithmetic_unit(
input definitions::instruction_t IW,
output definitions::result_t result
);


always_comb begin: aritmethc_case
    result = 5'd0;
    case (IW.opcode)
        definitions::ADD: result = IW.a + IW.b;
        definitions::OR_BIT_BIT: result = IW.a | IW.b;
        definitions::AND_BIT_BIT: result = IW.a & IW.b;
        definitions::EXP: result = IW.a ** IW.b;
        definitions::SUB: result = IW.a - IW.b;
        definitions::MUL: result = IW.a * IW.b;
    endcase
end
endmodule
