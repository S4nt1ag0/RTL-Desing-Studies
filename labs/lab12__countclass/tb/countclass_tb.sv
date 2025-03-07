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

module countclass_tb;
    Counter counter_obj;

    initial begin
        counter_obj = new();
        $display ("count = %0d", counter_obj.getcount());
        counter_obj.load(8'h9);
        $display ("count = %0d", counter_obj.getcount());
        #200 $finish;
    end
endmodule