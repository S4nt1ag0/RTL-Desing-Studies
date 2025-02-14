`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2025 01:00:05 PM
// Design Name: 
// Module Name: fsm_calculator_tb
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


module fsm_calculator_tb();

import definitions::*;
    
    result_t result;
    localparam CLK_PERIOD = 5ns;
    
    logic clk;
    logic rst;
    logic [DEFAULT_WORD_W-1:0] dados;
    logic iniciar;
    logic pronto;
    
    // Instantiate the ArithmeticUnit
    fsm_calculator 
    #(
        .WORD_WIDTH(DEFAULT_WORD_W)
    )
    duv (
        .clk(clk),
        .rst_n(rst),
        .iniciar(iniciar),
        .dados(dados),
        .pronto(pronto),
        .result(result)
    );

    initial begin
        clk = 0;
        forever begin
            #CLK_PERIOD
            clk = ~clk;
        end
    end
    
    initial begin
        //Limpando sinais
        rst = 1;
        #10
        rst = 0;
        #5
        rst = 1;
        
        
        // Test case 1: Addition (opcode = 0)
        iniciar = 0;
        #5;
        iniciar = 1;
        #10;
        dados = 4'd3;
        #10;
        dados = 4'd2;
        #10;
        dados = ADD;
        #10;
        iniciar = 0;

        #10;
        
        
        //Limpando sinais
        rst = 1;
        #10
        rst = 0;
        #5
        rst = 1;
        

        // Test case 2: Bitwise OR (OR_BIT_BIT)
        iniciar = 0;
        #5;
        iniciar = 1;
        #10;
        dados = 4'b1100;
        #10;
        dados = 4'b1010;
        #10;
        dados = OR_BIT_BIT;

        #10;
        
        //Limpando sinais
        rst = 1;
        #10
        rst = 0;
        #5
        rst = 1;

        // Test case 3: Bitwise AND (AND_BIT_BIT)
        iniciar = 0;
        #5;
        iniciar = 1;
        #10;
        dados = 4'b1100;
        #10;
        dados = 4'b1010;
        #10;
        dados = AND_BIT_BIT;

        #10;
        
        //Limpando sinais
        rst = 1;
        #10
        rst = 0;
        #5
        rst = 1;

        // Test case 4: Exponentiation (EXP) - Undefined behavior
        iniciar = 0;
        #5;
        iniciar = 1;
        #10;
        dados = 4'd2;
        #10;
        dados = 4'd3;
        #10;
        dados = EXP;
        
        #10;
        
        //Limpando sinais
        rst = 1;
        #10
        rst = 0;
        #5
        rst = 1;

        // Test case 5: Subtraction (SUB)
        iniciar = 0;
        #5;
        iniciar = 1;
        #10;
        dados = 4'd7;
        #10;
        dados = 4'd5;
        #10;
        dados = SUB;

        #10;
        
        //Limpando sinais
        rst = 1;
        #10
        rst = 0;
        #5
        rst = 1;

        // Test case 6: Multiplication (MUL)
        iniciar = 0;
        #5;
        iniciar = 1;
        #10;
        dados = 4'd3;
        #10;
        dados = 4'd4;
        #10;
        dados = MUL;

        #30;
        
        // End of simulation
        $finish;
    end
endmodule
