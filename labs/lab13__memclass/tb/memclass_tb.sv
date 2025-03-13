`timescale 1ns/100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2025 01:34:33 PM
// Design Name: 
// Module Name: memory_module_tb
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

module memclass_tb();
    localparam ADDR_WIDTH = 5;
    localparam DATA_WIDTH = 8;
    localparam CLK_PERIOD = 5ns;
    localparam DEBUG_MODE = 0;

    logic clk;
    
    // Instanciando a interface
    memory_module_intf #(.ADDR_WIDTH (ADDR_WIDTH), .DATA_WIDTH (DATA_WIDTH), .DEBUG_MODE(DEBUG_MODE)) memoryIntf (clk);

    // Instanciando o DUT
    memory_module #(.ADDR_WIDTH (ADDR_WIDTH), .DATA_WIDTH (DATA_WIDTH)) dut (memoryIntf.DUT);

    // Geração do clock
    initial begin
        clk = 1;
        forever begin
            #CLK_PERIOD clk = ~clk;
        end
    end

    // Testbench principal
    memTest test; // Declarando a variável sem instanciar

    initial begin
        $dumpfile("lab_13.vcd");
        $dumpvars(0, memclass_tb);

        // Fazendo a instância da classe separadamente
        test = new(memoryIntf, memTest::constraint_mode_t'(memTest::MIXED));
        test.run_tests();
    end

endmodule