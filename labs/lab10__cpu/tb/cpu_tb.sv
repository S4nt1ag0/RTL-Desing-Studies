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
    logic halt;

  cpu # (
    .DEFAULT_WORD_W(DEFAULT_WORD_W),
    .ADDR_WIDTH(ADDR_WIDTH)
  )
  cpu_inst (
    .clk(clk),
    .rst_n(rst_n),
    .halt(halt)
  );

  logic [31:0]   test_number;  

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

    // Alimenta memoria com as instruções
    initial begin
        

        $display ( "" );
        $display ( "****************************************" );
        $display ( "THE FOLLOWING DEBUG TASKS ARE AVAILABLE:" );
        $display ( "1- The basic CPU diagnostic.            " );
        $display ( "2- The advanced CPU diagnostic.         " );
        $display ( "3- The Fibonacci program.               " );
        $display ( "****************************************" );
        $display ( "" );
        //$display ( "Enter ' deposit test_number # ; run' \n" );
        test_number = 1;
        //$stop; // wait for test number
        
        if ( test_number > 3 )
          begin
            $display ( "Test number %d is not between 1 and 3", test_number );
          end
        else
       //for (int test_number = 1; test_number<3; test_number++)
          begin
            case ( test_number )
              1: begin
                   $display ( "CPUtest1 - BASIC CPU DIAGNOSTIC PROGRAM \n" );
                   $display ( "THIS TEST SHOULD HALT WITH THE PC AT 17 hex\n" );
                 end
              2: begin
                   $display ( "CPUtest2 - ADVANCED CPU DIAGNOSTIC PROGRAM\n" );
                   $display ( "THIS TEST SHOULD HALT WITH THE PC AT 10 hex\n" );
                 end
              3: begin
                   $display ( "CPUtest3 - FIBONACCI NUMBERS to 144\n" );
                   $display ( "THIS TEST SHOULD HALT WITH THE PC AT 0C hex\n" );
                 end
            endcase

            rst_n = 0; // Mantém o reset ativo
            $readmemb ( {dirname,"CPUtest1.dat"}, cpu_inst.memory.mem_block);
            repeat (2) @(negedge clk);
            rst_n = 1;
            $display("     TIME       PC    INSTR    OP   ADR   DATA\n");
            $display("  ----------    --    -----    --   ---   ----\n");
            while ( !halt )
            @( posedge clk );

            if ( test_number == 1 && cpu_inst.pc_addr !== 5'h17
              || test_number == 2 && cpu_inst.pc_addr !== 5'h10
              || test_number == 3 && cpu_inst.pc_addr !== 5'h0C 
              || cpu_inst.pc_addr === 5'hXX)
              begin
                $display ( "CPU TEST FAILED" );
                $display("Falha ao executar a instrução próximo à posição %d da memória", cpu_inst.addr);
                $finish;
              end
            $display ( "\nCPU TEST %0d PASSED",test_number );
        end
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