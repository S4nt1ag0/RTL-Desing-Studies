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

class Downcounter extends Counter;

    function new(int count = 0, int max=1, int min=0);
        super.new(count, max, min);
    endfunction

    function next();
    super.check_set(count-1);
        $display("Counter: %0d", this.count);
    endfunction

endclass

