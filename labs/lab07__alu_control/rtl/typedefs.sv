package typedefs;
    parameter VERSION = "1.1";
    localparam DEFAULT_WORD_W = 8;
    localparam OPCODE_WITH = 3;
   
    typedef enum logic [OPCODE_WITH-1:0] {
        HLT, //accum
        SKZ, //accum
        ADD, //data + accum
        AND, //data & accum
        XOR, //data ^ accum
        LDA, //data
        STO, //accum
        JMP //accum
        } opcodes_t;

endpackage