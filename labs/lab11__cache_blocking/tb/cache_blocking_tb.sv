`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2025 01:34:33 PM
// Design Name: 
// Module Name: cpu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Createdgithub
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module cache_blocking_tb;
    logic clk;
    logic reset_n;
    logic [7:0] d;
    logic [7:0] q;

    flipflop dut (
        .clk(clk),
        .reset_n(reset_n),
        .d(d),
        .q(q)
    );

    clocking cb @ (posedge clk);
        default input #1step output #2ns; 
        input q;    
        output d;     
        output reset_n;
    endclocking
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Sequência de teste
    initial begin
        $dumpfile("cache_blocking_tb.vcd");
        $dumpvars(0, cache_blocking_tb);

        cb.reset_n <= 0; 
        @cb;
        @cb;
        @cb;        
        cb.reset_n <= 1;

        for (int i = 0; i < 10; i++) begin
            @cb;
            cb.d <= i; 
        end
        
        @cb;
        @cb;
        $finish;  // Finaliza simulação
    end

endmodule