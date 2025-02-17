module fsm_calculator
    import definitions::*;
#(
    parameter WORD_WIDTH = 8
)
(
    input logic clk,
    input logic rst_n,
    input logic iniciar,
    input logic [WORD_WIDTH-1:0] dados,
    output logic pronto,
    output result_t result
    );



    instruction_t IW;
    result_t result_inner;
    
    arithmetic_unit arithmeticUnitInstance (
        .IW(IW), 
        .result(result_inner)
    );

    localparam STATE_WIDTH = 3;

    //Data path
    logic [WORD_WIDTH-1:0] value_a, value_b;

    //Control path
    logic rega_en, regb_en, regopc_en, calc_en;
    definitions::opcodes_t opcode;

    enum logic [STATE_WIDTH-1:0]
    {
        IDLE,
        GET_VALUE_A,
        GET_VALUE_B,
        GET_OPCODE,
        CALC,
        DONE
    } state = IDLE, next_state;

    always_comb begin: process_next_state
        next_state = state;
        case (state)
            IDLE:
                if(iniciar)
                    next_state = GET_VALUE_A;
            GET_VALUE_A: begin
                next_state = GET_VALUE_B;
                end
            GET_VALUE_B: begin
                next_state = GET_OPCODE;
                end
            GET_OPCODE: begin
                next_state = CALC;
                end
            CALC:
                next_state = DONE;
            DONE:
                next_state = IDLE;
        endcase  
    end

    always_ff @( posedge clk, negedge rst_n ) begin : get_date
        if (!rst_n) begin
            value_b <= '0;
            value_a <= '0;
            opcode <= definitions::ADD;
        end
        if (rega_en) begin
            value_a <= dados[3:0];
        end
        if (regb_en) begin
            value_b <= dados[3:0];
        end
        if (regopc_en) begin
            opcode = opcodes_t'(dados[2:0]);
        end
        if (calc_en) begin
            IW.a = value_a;
            IW.b = value_b;
            IW.opcode = opcode;
        end
    end

    always_comb begin: state_decode
        rega_en = 1'b0;
        regb_en = 1'b0;
        regopc_en = 1'b0;
        calc_en = 1'b0;
        case (state)
            IDLE:
                pronto = 0;
            GET_VALUE_A:
                rega_en = 1'b1;
            GET_VALUE_B:
                regb_en = 1'b1;
            GET_OPCODE:
                regopc_en = 1'b1;
            CALC:
                calc_en = 1'b1;
            DONE:begin
                pronto = 1'b1;
                result = result_inner;
                end
        endcase  
    end

    always_ff @(posedge clk, negedge rst_n) begin : proc_stage
    if(!rst_n) begin
        state <= IDLE;
    end else begin 
        state <= next_state;
    end
    end

endmodule