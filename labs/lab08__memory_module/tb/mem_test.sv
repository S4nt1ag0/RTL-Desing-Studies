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
    input logic clk,
    output logic read,
    output logic write,
    output logic [ADDR_WIDTH-1:0] addr,
    output logic [DATA_WIDTH-1:0] data_in,
    input logic [DATA_WIDTH-1:0] data_out,
    output logic [DATA_WIDTH-1:0] out_data,
    input bit debug
    
);

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
            write_mem(index_clear,0);
            read_mem(index_clear,out_data, debug);
            errors_amount = checkit(index_clear, out_data, 8'h00);
        end

        printstatus(errors_amount);

        $display("Data = Address Test");
        for(int index_data = 0; index_data <32; index_data++) begin
            write_mem(index_data,index_data, debug);
            read_mem(index_data,out_data, debug);
            errors_amount = checkit(index_data, out_data, index_data);
        end
        printstatus(errors_amount);
        $finish;
    end: memtest


    task write_mem(
        input [ADDR_WIDTH-1:0] in_addr,
        input [DATA_WIDTH-1:0] in_data,
        input debug=0
        );

        @(negedge clk);
        write <= 1'b1;
        read <= 1'b0;
        addr <= in_addr;
        data_in <= in_data;
        @(negedge clk);
        write <= 1'b0;
        if(debug)
            $display("Write Data | Address= %d  Data= %h", in_addr, in_data);
        
    endtask: write_mem


    task read_mem(
        input [ADDR_WIDTH-1:0] in_addr,
        output [DATA_WIDTH-1:0] out_data,
        input debug=0
        );

        @(negedge clk);
        write <= 1'b0;
        read <= 1'b1;
        addr <= in_addr;
        @(negedge clk);
        out_data <= data_out;
        read <= 1'b0;
        @(negedge clk); //Extra delay to ensure the read value is returned
        if(debug)
            $display("Read Data | Address= %d  Data= %h", in_addr, out_data);
    endtask: read_mem


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

