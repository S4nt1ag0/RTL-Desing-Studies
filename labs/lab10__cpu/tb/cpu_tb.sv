`timescale 1ns/100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2025 01:34:33 PM
// Design Name: 
// Module Name: cpu_tb
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
import typedefs::*;

module cpu_tb;

    // Parameters
    localparam  DEFAULT_WORD_W = 8;
    localparam ADDR_WIDTH = 5;
    localparam CLK_PERIOD = 5ns;

    //Ports
    logic clk;
    logic rst_n;

  cpu # (
    .DEFAULT_WORD_W(DEFAULT_WORD_W),
    .ADDR_WIDTH(ADDR_WIDTH),
    .OPCODE_WITH(OPCODE_WITH)
  )
  cpu_inst (
    .clk(clk),
    .rst_n(rst_n)
  );

  logic   [DEFAULT_WORD_W-1:0]   memory_content    [0:(2**ADDR_WIDTH)-1];
  integer memory_index;


  task write_mem(
        input [ADDR_WIDTH-1:0] in_addr,
        input [DEFAULT_WORD_W-1:0] in_data
    );
        @(negedge clk);
        force cpu_inst.memory.write = 1'b1;
        force cpu_inst.memory.read = 1'b0;
        force cpu_inst.memory.addr = in_addr;
        force cpu_inst.memory.data_in = in_data;
        @(negedge clk);
        force cpu_inst.memory.write  = 1'b0;
        @(negedge clk);
        // Liberar os sinais forçados
        release cpu_inst.memory.write;
        release cpu_inst.memory.read;
        release cpu_inst.memory.addr;
        release cpu_inst.memory.data_in;
        $display("Write Data | Address = %d, Data = %h", in_addr, in_data);

    endtask: write_mem



    string fullpath = `__FILE__;
    string dirname;

    initial begin
        $timeformat ( -9, 1, "ns", 9 );
        // SystemVerilog: time units in literals
        #12000ns
        $display ( "CPU TEST TIMEOUT" );
        $finish;
    end

    initial begin
        int idx = fullpath.len() - 1;

        // Encontrar a última ocorrência de '/'
        while (idx >= 0 && fullpath[idx] != "/") begin
            idx--;
        end

        // Separar o nome do arquivo e o diretório
        if (idx >= 0) begin
            dirname = fullpath.substr(0, idx);       // Diretório sem a barra final
        end else begin
            dirname = ".";  // Se não houver '/', assume diretório atual
        end
    end

    // Apply & check Stimulus
    initial begin
        $readmemb ( {dirname,"cpuTest01.pat"}, memory_content );
        memory_index = 0;
        rst_n = 0; // Mantém o reset ativo
        repeat(2) @(negedge clk);
        while (memory_index <= (2**ADDR_WIDTH)-1) begin
            write_mem(memory_index, memory_content[memory_index]);
            memory_index++;
        end

        @(negedge clk);
        rst_n = 1;
    end

    initial begin
        clk = 1;
        forever begin
            #CLK_PERIOD
            clk = ~clk;
        end
    end

    initial begin
        $dumpfile("lab_10.vcd");
        $dumpvars(0, cpu_tb);
    end

endmodule