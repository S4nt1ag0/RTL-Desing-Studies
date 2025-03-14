//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2025 04:47:11 PM
// Design Name: 
// Module Name: counter
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

class memTest;
    int ADDR_WIDTH, DATA_WIDTH;
    virtual interface memory_module_intf.TB intf;

    rand bit [4:0] addr;  // Definir o tamanho explicitamente
    rand bit [7:0] data;

    int errors_amount;

    typedef enum {PRINTABLE, UPPERCASE, LOWERCASE, MIXED} constraint_mode_t;
    constraint_mode_t mode;

    constraint mode_select {
        if (mode == PRINTABLE) { data inside {[8'h20:8'h7F]}; }
        if (mode == UPPERCASE) { data inside {[8'h41:8'h5A]}; }
        if (mode == LOWERCASE) { data inside {[8'h61:8'h7A]}; }
        if (mode == MIXED) { data dist { [8'h41:8'h5A] := 80, [8'h61:8'h7A] := 20 }; }
    }

    function new(virtual interface memory_module_intf.TB intf, constraint_mode_t m);
        this.intf = intf;
        this.ADDR_WIDTH = 5; // Define manualmente o tamanho
        this.DATA_WIDTH = 8;
        this.mode = m;
        void'(this.randomize());
    endfunction

task run_tests();
    logic [intf.DATA_WIDTH-1:0] out_data;
    
    $display ("Clear memory Test");
    for(int index_clear=0; index_clear<32; index_clear++) begin
        intf.write_mem(index_clear, 0);
        intf.read_mem(index_clear, out_data);
        errors_amount += checkit(index_clear, out_data, 8'h00);
    end
    printstatus(errors_amount);

    $display("Data = Address Test");
    for(int index_data = 0; index_data <32; index_data++) begin
        intf.write_mem(index_data, index_data);
        intf.read_mem(index_data, out_data);
        errors_amount += checkit(index_data, out_data, index_data);
    end
    printstatus(errors_amount);

    $display("Random Data Test");
    for(int index_rand = 0; index_rand < 32; index_rand++) begin
        assert(this.randomize()) else $display("Randomization failed");
        intf.write_mem(this.addr, this.data);
        intf.read_mem(this.addr, out_data);
        errors_amount += checkit(this.addr, out_data, this.data);
    end
    printstatus(errors_amount);

    $finish;
endtask

function int checkit(input [intf.ADDR_WIDTH-1:0] address, 
                     input [intf.DATA_WIDTH-1:0] actual, 
                     input [intf.DATA_WIDTH-1:0] expected);
    int error_status = 0;
    if(actual !== expected) begin
        $display("ERROR: address:%d Data:%c (%d) Expected:%c (%d)", address, actual, actual, expected, expected);
        error_status = 1;
    end
    return (error_status);
endfunction

function void printstatus(input int status);
    if(status == 0)
        $display("Test Passed - No Errors!");
    else
        $display("Test Failed with %d Errors", status);
endfunction
endclass