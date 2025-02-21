`timescale 1ns/100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2025 01:34:33 PM
// Design Name: 
// Module Name: cpu
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
module cpu
import typedefs::*;
#(parameter DEFAULT_WORD_W = 8)
(
    input logic clk,
    input logic rst_n
);



logic zero;
opcodes_t opcode;
logic mem_rd;
logic mem_wr;
logic halt;

logic load_ac;
logic load_ir;
logic load_pc;
logic inc_pc;


logic [DEFAULT_WORD_W-1:0] data_out;
logic [DEFAULT_WORD_W-1:0] accum;
logic [DEFAULT_WORD_W-1:0] alu_out;
logic [DEFAULT_WORD_W-1:0] ir_out;

logic [ADDR_WIDTH-1:0] ir_addr;
logic [ADDR_WIDTH-1:0] pc_addr;
logic [ADDR_WIDTH-1:0] addr;

memory_module memory
(
    .clk      (clk      ),
    .read     (mem_rd     ),
    .write    (mem_wr    ),
    .addr     (addr     ),
    .data_in  (alu_out  ),
    .data_out (data_out )
);


register accumulator_register(
    .clk(clk),
    .rst_n(rst_n),
    .data(alu_out),
    .enable(load_ac),
    .out(accum)
);

register intruction_register(
    .clk(clk),
    .rst_n(rst_n),
    .data(data_out),
    .enable(load_ir),
    .out(ir_out)
);

opcode = opcodes_t'(ir_out[DEFAULT_WORD_W-1:DEFAULT_WORD_W-OPCODE_WITH]);
ir_addr = ir_out[(DEFAULT_WORD_W-OPCODE_WITH - 1) : 0];

alu_control alu(
    .clk(clk),
    .opcode(opcode),
    .data(data_out),
    .accum(accum),
    .out(alu_out),
    .zero(zero)
);

counter program_counter (
    .clk(clk),
    .rst_n(rst_n),
    .data(ir_addr),
    .load_pc(load_pc),
    .inc_pc(inc_pc),
    .count(pc_addr)
    );

    scale_mux mux (
        .in_a(ir_addr),
        .in_b(pc_addr),
        .sel_a(), //quem é fetch?
        .out(addr)
    );

    fsm_sequence_control controller( //quem é fetch?
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


















endmodule