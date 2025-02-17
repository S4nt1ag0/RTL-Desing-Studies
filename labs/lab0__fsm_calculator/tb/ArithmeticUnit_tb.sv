`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2025 01:38:28 PM
// Design Name: 
// Module Name: ArithmeticUnit_tb
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


module ArithmeticUnit_tb();
    import definitions::*;
    
    result_t result;
    instruction_t IW;
    
    // Instantiate the ArithmeticUnit
    ArithmeticUnit duv (
        .IW(IW), 
        .result(result)
    );
    
    initial begin
        // Test case 1: Addition (opcode = 0)
        IW.a = 4'd3; IW.b = 4'd2; IW.opcode = ADD;
        #10;
        
        // Test case 2: Bitwise OR (OR_BIT_BIT)
        IW.a = 4'b1100; IW.b = 4'b1010; IW.opcode = OR_BIT_BIT;
        #10;
        
        // Test case 3: Bitwise AND (AND_BIT_BIT)
        IW.a = 4'b1100; IW.b = 4'b1010; IW.opcode = AND_BIT_BIT;
        #10;
        
        // Test case 4: Exponentiation (EXP) - Undefined behavior
        IW.a = 4'd2; IW.b = 4'd3; IW.opcode = EXP;
        #10;
        
        // Test case 5: Subtraction (SUB)
        IW.a = 4'd7; IW.b = 4'd5; IW.opcode = SUB;
        #10;
        
        // Test case 6: Multiplication (MUL)
        IW.a = 4'd3; IW.b = 4'd4; IW.opcode = MUL;
        #10;
        
        // End of simulation
        $finish;
    end
endmodule
