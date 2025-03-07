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

class Downcounter;
    int count;

    function new(int count = 0);
        this.count = count;
    endfunction

    function load(int count);
        this.count = count;
    endfunction

    function int getcount();
        return this.count;
    endfunction
endclass

