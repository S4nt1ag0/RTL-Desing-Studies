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
#(
    parameter DEFAULT_WORD_W = 8,
    parameter ADDR_WIDTH = 5
)
(
    input logic clk,
    input logic rst_n
);



logic zero;
logic mem_rd;
logic mem_wr;
logic halt;
logic fetch;

logic load_ac;
logic load_ir;
logic load_pc;
logic inc_pc;

logic [DEFAULT_WORD_W-1:0] data_out;
logic [DEFAULT_WORD_W-1:0] accum;
logic [DEFAULT_WORD_W-1:0] alu_out;
ir_union_out ir_out;


logic [ADDR_WIDTH-1:0] pc_addr;
logic [ADDR_WIDTH-1:0] addr;

memory_module #(.ADDR_WIDTH(ADDR_WIDTH),.DATA_WIDTH(DEFAULT_WORD_W)) memory
(
    .clk      (clk      ),
    .read     (mem_rd     ),
    .write    (mem_wr    ),
    .addr     (addr     ),
    .data_in  (alu_out  ),
    .data_out (data_out )
);


register #(.DATA_WIDTH(DEFAULT_WORD_W)) accumulator_register(
    .clk(clk),
    .rst_n(rst_n),
    .data(alu_out),
    .enable(load_ac),
    .out(accum)
);

register #(.DATA_WIDTH(DEFAULT_WORD_W)) intruction_register(
    .clk(clk),
    .rst_n(rst_n),
    .data(data_out),
    .enable(load_ir),
    .out(ir_out)
);

alu_control #(.DATA_WIDTH(DEFAULT_WORD_W)) alu
(
    .clk(clk),
    .opcode(ir_out.fields.opcode),
    .data(data_out),
    .accum(accum),
    .out(alu_out),
    .zero(zero)
);

counter #(.DATA_WIDTH(ADDR_WIDTH)) program_counter (
    .clk(clk),
    .rst_n(rst_n),
    .data(ir_out.fields.ir_addr),
    .load(load_pc),
    .enable(inc_pc),
    .count(pc_addr)
    );

    scale_mux #(.DATA_WIDTH(ADDR_WIDTH)) mux (
        .in_a(pc_addr),
        .in_b(ir_out.fields.ir_addr),
        .sel_b(fetch),
        .out(addr)
    );

    fsm_sequence_control #(.WORD_WIDTH(DEFAULT_WORD_W)) controller(
        .clk        (clk        ),
        .rst_n      (rst_n      ),
        .zero       (zero       ),
        .opcode     (ir_out.fields.opcode     ),
        .mem_rd     (mem_rd     ),
        .load_ir    (load_ir    ),
        .halt       (halt       ),
        .inc_pc     (inc_pc     ),
        .load_ac    (load_ac    ),
        .load_pc    (load_pc    ),
        .mem_wr     (mem_wr     ),
        .fetch      (fetch      )
    );


















endmodule