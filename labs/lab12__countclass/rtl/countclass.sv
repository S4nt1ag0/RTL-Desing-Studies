`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2025 04:47:11 PM
// Design Name: 
// Module Name: counter
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

class Counter;
    rand logic [7:0] data;
    logic clk;
    logic rst_n;
    logic load;
    logic enable;
    logic [7:0] count;

    function new();
        this.clk = 0;
        this.rst_n = 0;
        this.load = 0;
        this.enable = 0;
        this.count = 0;
    endfunction

    task reset();
        rst_n = 0;
        #5 rst_n = 1;
        $display("[%0t] Reset applied", $time);
    endtask

    task load_value(input logic [7:0] value);
        load = 1;
        data = value;
        #10;
        load = 0;
        $display("[%0t] Loaded value: %h", $time, value);
    endtask

    task enable_count();
        enable = 1;
        $display("[%0t] Counter enabled", $time);
    endtask

    task disable_count();
        enable = 0;
        $display("[%0t] Counter disabled", $time);
    endtask

    task simulate();
        fork
            forever begin
                #5 clk = ~clk;
            end
        join_none
        reset();
        load_value(8'h10);
        enable_count();
        repeat (10) #10;
        disable_count();
    endtask
endclass

