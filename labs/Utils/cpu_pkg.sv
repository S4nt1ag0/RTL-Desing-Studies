package typedefs;
    parameter VERSION = "1.1";
    localparam DEFAULT_WORD_W = 8;
    localparam OPCODE_WITH = 3;
    localparam STATE_WITH = 8;
    localparam ADDR_WIDTH = 5;
   
    typedef enum logic [OPCODE_WITH-1:0] {
        HLT, //halt
        SKZ, //skip if zero
        ADD, //data + acumulator
        AND, //data & acumulator
        XOR, //data ^ acumulator
        LDA, //load acumulator
        STO, //store acumulator
        JMP //Jump to address
    } opcodes_t;

    typedef enum logic [STATE_WITH-1:0] {
        INST_ADDR,
        INST_FETCH,
        INST_LOAD,
        IDLE,
        OP_ADDR,
        OP_FETCH,
        ALU_OP,
        STORE
    } state_t;

    typedef union packed {
        logic [DEFAULT_WORD_W-1:0] full_word;  // The full instruction word
        struct packed {
            opcodes_t opcode;  // Upper bits (converted to opcodes_t)
            logic [DEFAULT_WORD_W - OPCODE_WITH - 1:0] ir_addr;  // Lower bits
        } fields;
    } ir_union_out;

endpackage