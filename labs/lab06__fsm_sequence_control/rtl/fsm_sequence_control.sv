`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2025 04:47:11 PM
// Design Name: 
// Module Name: fsm_calculator
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

module fsm_sequence_control
    import typedefs::*;
#(
    parameter WORD_WIDTH = DEFAULT_WORD_W
)
(
    input opcodes_t opcode,
    input logic rst_n,
    input logic clk,
    input logic zero,
    output logic mem_rd,
    output logic mem_wr,
    output logic load_ir,
    output logic load_ac,
    output logic load_pc,
    output logic inc_pc,
    output logic halt,
    output logic fetch
    );

    state_t state = INST_ADDR, next_state;

    always_comb begin: process_next_state
        next_state = state;
        case (state)
            INST_ADDR: next_state = INST_FETCH;
            INST_FETCH: next_state = INST_LOAD;
            INST_LOAD: next_state = IDLE;
            IDLE: next_state = OP_ADDR;
            OP_ADDR: next_state = OP_FETCH;
            OP_FETCH: next_state = ALU_OP;
            ALU_OP: next_state = STORE;
            STORE: next_state = INST_ADDR;
        endcase  
    end

    always_ff @(posedge clk, negedge rst_n) begin : proc_stage
        if(!rst_n) begin
            state <= INST_ADDR;
        end else begin 
            state <= next_state;
        end
    end

    

    always_comb begin: state_decode
        mem_rd = 1'b0;
        load_ir = 1'b0;
        halt = 1'b0;
        inc_pc = 1'b0;
        load_ac = 1'b0;
        load_pc = 1'b0;
        mem_wr = 1'b0;
        fetch = 0'b0;

        case (state)
            INST_ADDR: begin
                mem_rd = 1'b0;
                load_ir = 1'b0;
                halt = 1'b0;
                inc_pc = 1'b0;
                load_ac = 1'b0;
                load_pc = 1'b0;
                mem_wr = 1'b0;
            end
            INST_FETCH: begin
                mem_rd = 1'b1;
                if(opcode == JMP)
                    fetch = 1'b1;
            end
            INST_LOAD: begin
                mem_rd = 1'b1;
                load_ir = 1'b1;
            end
            IDLE: begin
                mem_rd = 1'b1;
                load_ir = 1'b1;
            end
            OP_ADDR: begin
                inc_pc = 1'b1;
                if(opcode == HLT)
                    halt = 1'b1;
            end
            OP_FETCH: begin
                if(opcode == ADD || opcode == AND || opcode == XOR || opcode == LDA)
                    mem_rd = 1'b1;
                if(opcode == LDA)
                    fetch = 1'b1;
            end
            ALU_OP: begin
                if(opcode == ADD || opcode == AND || opcode == XOR || opcode == LDA) begin
                    mem_rd = 1'b1;
                    load_ac = 1'b1;
                    fetch = 1'b1;
                end
                else if( opcode == SKZ && zero)
                    inc_pc = 1'b1;
                else if(opcode == JMP)
                    load_pc = 1'b1; 
            end
            STORE: begin
                if(opcode == ADD || opcode == AND || opcode == XOR || opcode == LDA) begin
                    mem_rd = 1'b1;
                    load_ac = 1'b1;
                    fetch = 1'b1;
                end
                else if(opcode == JMP) begin
                    inc_pc = 1'b1;
                    load_pc = 1'b1;
                end
                else if(opcode == STO) begin
                    mem_wr = 1'b1;
                    fetch = 1'b1;
                end
            end
        endcase  
    end

    

endmodule