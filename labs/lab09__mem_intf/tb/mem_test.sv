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
            read_mem(index_clear,intf.out_data, intf.debug);
            errors_amount = checkit(index_clear, intf.out_data, 8'h00);
        end

        printstatus(errors_amount);

        $display("Data = Address Test");
        for(int index_data = 0; index_data <32; index_data++) begin
            write_mem(index_data,index_data, intf.debug);
            read_mem(index_data,intf.out_data,intf. debug);
            errors_amount = checkit(index_data, intf.out_data, index_data);
        end
        printstatus(errors_amount);
        $finish;
    end: memtest


    task write_mem(
        input [ADDR_WIDTH-1:0] in_addr,
        input [DATA_WIDTH-1:0] in_data,
        input debug=0
        );

        @(negedge intf.clk);
        intf.write <= 1'b1;
        intf.read <= 1'b0;
        intf.addr <= in_addr;
        intf.data_in <= in_data;
        @(negedge intf.clk);
        intf.write <= 1'b0;
        if(intf.debug)
            $display("Write Data | Address= %d  Data= %h", in_addr, in_data);
        
    endtask: write_mem


    task read_mem(
        input [ADDR_WIDTH-1:0] in_addr,
        output [DATA_WIDTH-1:0] out_data,
        input debug=0
        );

        @(negedge intf.clk);
        intf.write <= 1'b0;
        intf.read <= 1'b1;
        intf.addr <= in_addr;
        @(negedge intf.clk);
        out_data <= intf.data_out;
        intf.read <= 1'b0;
        @(negedge intf.clk); //Extra delay to ensure the read value is returned
        if(intf.debug)
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

