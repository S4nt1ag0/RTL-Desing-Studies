`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2025 04:47:55 PM
// Design Name: 
// Module Name: count_tb
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


module count_tb(

    );
    localparam CLK_PERIOD = 5ns;
    localparam RST_PERIOD = 1000ns;
    
    logic clk;
    logic rst;
    logic [3:0] pulsos;
    logic iniciar;
    logic pronto;

    count duv(
        .clk(clk),
        .rst(rst),
        .pulsos(pulsos),
        .iniciar(iniciar),
        .pronto(pronto)
    );

    initial begin
        clk = 0;
        forever begin
            #CLK_PERIOD
            clk = ~clk;
        end
    end

    initial begin
        rst = 1;
        #200
        rst = 0;
        #50
        rst = 1;
        #200
        rst = 0;
    end

    initial begin
        iniciar = 0;
        pulsos = 3'd3;

        //Liberando contagem até 3 pulsos
        #50;

        iniciar = 1;
        #10;
        iniciar = 0;

        wait(pronto);
        #10
        wait(!pronto);

        pulsos = 3'd2;


        #20;
        iniciar = 1'b1;
        #100;

    end

    

endmodule
