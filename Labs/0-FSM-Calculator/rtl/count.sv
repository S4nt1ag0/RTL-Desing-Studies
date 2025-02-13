`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2025 04:47:11 PM
// Design Name: 
// Module Name: count
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


module count(
    input logic clk,
    input logic rst,
    input logic [3:0] pulsos,
    input logic iniciar,
    output logic pronto
    );
    
    logic [3:0] amount = 0;
    logic started = 0;
    
    always_ff @(posedge clk or negedge rst) begin
        if(~rst) begin
            amount <= 0;
            pronto <= 0;
            started <= 0;
        end
        else begin
            pronto <= 0;
            if(iniciar == 1)
                started <= 1;
            if(pronto == 1) begin
                amount <= 0;
                pronto <= 0;
            end    
            if(started == 1 && pronto != 1)
                amount <= amount+1;
                if(amount == pulsos) begin 
                    pronto <= 1;
                end

        end
                
    end
    
endmodule
