`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2025 04:47:55 PM
// Design Name: 
// Module Name: counter_tb
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


module counter_tb(

    );
    localparam CLK_PERIOD = 5ns;
    localparam RST_PERIOD = 1000ns;
    
    logic clk;
    logic rst_n;
    logic [5:0] data;
    logic load;
    logic enable;
    logic [5:0] count;

    counter duv(
        .clk(clk),
        .rst_n(rst_n),
        .data(data),
        .load(load),
        .enable(enable),
        .count(count)
    );

    initial begin
        clk = 1;
        forever begin
            #CLK_PERIOD
            clk = ~clk;
        end
    end

    initial begin
        rst_n = 'x; load = 'x; enable = 'x; data = 'x;
        #5ns 
        rst_n = 0; load = 'x; enable = 'x; data = 'x;
        #5ns 
        rst_n = 0; load = 'x; enable = 'x; data = 'x;
        #5ns 
        rst_n = 1; load = 0; enable = 1; data = 'x;
        #5ns 
        rst_n = 1; load = 0; enable = 1; data = 'x;
        #5ns 
        rst_n = 1; load = 0; enable = 1; data = 'x;
        #5ns 
        rst_n = 1; load = 0; enable = 1; data = 'x;
        #500ns
        rst_n = 1; load = 0; enable = 1; data = 'x;
        #5ns
        rst_n = 1; load = 0; enable = 1; data = 'x;
        #5ns
        rst_n = 1; load = 0; enable = 1; data = 'x;
        #5ns
        rst_n = 1; load = 0; enable = 1; data = 'x;
        #5ns
        rst_n = 1; load = 0; enable = 1; data = 'x;
        #5ns
        rst_n = 1; load = 0; enable = 1; data = 'x;
        #1500ns
        // End of simulation
        $finish;
end

    

endmodule
