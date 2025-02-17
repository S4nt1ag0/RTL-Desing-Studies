`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2025 01:38:28 PM
// Design Name: 
// Module Name: arithmetic_unit_tb
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


module register_tb();

    localparam CLK_PERIOD = 5ns;

    logic clk;
    logic rst_n;
    logic [7:0] data;
    logic enable;
    logic [7:0] out;
    
    register duv (
        .clk(clk),
        .rst_n(rst_n),
        .data(data),
        .enable(enable),
        .out(out)
    );
    
    initial begin
        clk = 0;
        forever begin
            #CLK_PERIOD
            clk = ~clk;
        end
    end

    initial begin
        enable = 'x; rst_n = 1; data = 'x;
        #15 
        enable = 'x; rst_n = 0; data = 'x;
        #10 
        enable = 0;  rst_n = 1; data = 'x;
        #10 
        enable = 1;  rst_n = 1; data = 8'hAA;
        #10 
        enable = 0;  rst_n = 1; data = 8'h55;
        #10 
        enable = 'x; rst_n = 0; data = 'x;
        #10 
        enable = 0;  rst_n = 1; data = 'x;
        #10 
        enable = 1;  rst_n = 1; data = 8'h55;
        #10 
        enable = 0;  rst_n = 1; data = 8'hAA;
        #10
        // End of simulation
        $finish;
    end
endmodule
