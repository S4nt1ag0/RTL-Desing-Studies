`timescale 1ns/100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2025 01:34:33 PM
// Design Name: 
// Module Name: mem_test
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

module mem_test
#(parameter ADDR_WIDTH = 5, parameter DATA_WIDTH = 8)
(
    memory_module_intf intf
);

    logic [DATA_WIDTH-1:0] out_data;
    initial begin
        $timeformat( -9, 0, "ns", 9);
        #4000ns
        $display("Memory test Timeout");
        $finish;
    end

    initial begin: memtest
        int errors_amount;
        $display ("Clear memory Test");

        for(int index_clear=0; index_clear<32; index_clear++) begin
            intf.write_mem(index_clear,0);
            intf.read_mem(index_clear,out_data);
            errors_amount = checkit(index_clear, out_data, 8'h00);
        end

        printstatus(errors_amount);

        $display("Data = Address Test");
        for(int index_data = 0; index_data <32; index_data++) begin
            intf.write_mem(index_data,index_data);
            intf.read_mem(index_data,out_data);
            errors_amount = checkit(index_data, out_data, index_data);
        end
        printstatus(errors_amount);
        $finish;
    end: memtest

    function int checkit (
        input [4:0] address, 
        input [7:0] actual, 
        expected);
        static int error_status;
        if(actual !== expected) begin
            $display("ERROR: address:%h Data:%h Expected:%h", address, actual, expected);
            error_status++;
        end
        return (error_status);
    endfunction: checkit

    function void printstatus (input int status);
        if(status == 0)
            $display("Test Passed - No Erros!");
        else
            $display("Test Failed with %d Erros", status);
    endfunction: printstatus

endmodule

