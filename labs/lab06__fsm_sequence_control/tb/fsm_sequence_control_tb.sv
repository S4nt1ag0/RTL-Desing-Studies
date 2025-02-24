`timescale 1ns/100ps
import typedefs::*;

module fsm_sequence_control_tb;

    logic mem_rd;
    logic load_ir;
    logic halt;
    logic inc_pc;
    logic load_ac;
    logic load_pc;
    logic mem_wr;

    logic clk = 1'b1;
    logic rst_n = 1'b1;

    logic zero;
    opcodes_t opcode; 

    state_t  lstate;

    integer         response_num;
    integer         stimulus_num;
    logic   [6:0]   response_mem    [1:550];
    logic   [3:0]   stimulus_mem    [1:64];
    logic   [3:0]   stimulus_reg;
    logic   [6:0]   response_net;

    `define PERIOD 10
    always #(`PERIOD/2) clk = ~clk;

    fsm_sequence_control dut_controller(
        .clk        (clk        ),
        .rst_n      (rst_n       ),
        .zero       (zero       ),
        .opcode     (opcode     ),
        .mem_rd     (mem_rd     ),
        .load_ir    (load_ir    ),
        .halt       (halt       ),
        .inc_pc     (inc_pc     ),
        .load_ac    (load_ac    ),
        .load_pc    (load_pc    ),
        .mem_wr     (mem_wr     )
    );

    assign response_net = { mem_rd, load_ir, halt, inc_pc, load_ac, load_pc, mem_wr };
    assign zero = stimulus_reg[3];

    // check your type name if you get an error here:-
    assign opcode = opcodes_t'(stimulus_reg[2:0]);
    // temp variable to monitor state
    assign lstate = dut_controller.state;

    // Monitor Results
    initial begin
        $timeformat ( -9, 1, "ns", 9 );
        $monitor ("%t rst_n=%b ph=%s \t zer=%b op=%s rd=%b l_ir=%b hlt=%b inc=%b l_ac=%b l_pc=%b wr=%b",
                    $time, rst_n, lstate.name(), zero, opcode.name(),
                    mem_rd, load_ir, halt, inc_pc, load_ac, load_pc, mem_wr );
        // SystemVerilog: time units in literals
        #12000ns
        $display ( "CONTROLLER TEST TIMEOUT" );
        $finish;
    end

    string fullpath = `__FILE__;
    string dirname;

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
        $readmemb ( {dirname,"stimulus.pat"}, stimulus_mem );
        $readmemb ( {dirname,"response.pat"}, response_mem );
        stimulus_reg = 0;
        stimulus_num = 0;
        response_num = 0;
        @ ( negedge clk ) rst_n = 0;
        @ ( negedge clk ) rst_n = 1;
        
        // SystemVerilog: do...while loop and named block
        do begin : ApplyStim
            @(negedge clk);
            response_num = response_num + 1 ;
            if ( response_net !== response_mem[response_num] ) begin
            $display("CONTROLLER TEST FAILED" );
            $display("{mem_rd,load_ir,halt,inc_pc,load_ac,load_pc,mem_wr}" );
            $display("is        %b", response_net );
            $display("should be %b", response_mem[response_num] );
            // cannot currently use name method on a hierarchical path
            $display ( "state: %s   opcode: %s  zero: %b", lstate.name(), opcode.name(), zero);
            $stop;
            end // response_net
            
            if (response_num[2:0] == 3'b111) begin
                stimulus_num++;
                stimulus_reg = stimulus_mem[stimulus_num];
            end
        end : ApplyStim     // SystemVerilog: end named block
        
        while ( stimulus_num <= 64 );
        $display ( "CONTROLLER TEST PASSED" );
        $finish;
    end

    initial begin
        $dumpfile("lab06.vcd");
        $dumpvars(0, fsm_sequence_control);
    end

endmodule