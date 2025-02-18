`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2025 01:38:28 PM
// Design Name: 
// Module Name: scale_mux_tb
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


module scale_mux_tb();

   
    logic [7:0] in_a;
    logic [7:0] in_b;
    logic sel_a;
    logic [7:0] out;
    
    scale_mux duv (
        .in_a(in_a),
        .in_b(in_b),
        .sel_a(sel_a),
        .out(out)
    );

    initial begin
        in_a = 8'h0; in_b = 8'h0; sel_a = '0;
        #1 
        in_a = 8'h0; in_b = 8'h0; sel_a = '1;
        #1
        in_a = 8'h0; in_b = 8'hff; sel_a = '0;
        #1
        in_a = 8'h0; in_b = 8'hff; sel_a = '1;
        #1
        in_a = 8'hff; in_b = 8'h00; sel_a = '0;
        #1
        in_a = 8'hff; in_b = 8'h00; sel_a = '1;
        #1
        in_a = 8'hff; in_b = 8'hff; sel_a = '0;
        #1
        in_a = 8'hff; in_b = 8'hff; sel_a = '1;
        #1
        // End of simulation
        $finish;
    end
endmodule
