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

class Counter;
    int count;
    int max;
    int min;

    function new(int count = 0, int max=1, int min=0);
        this.check_limit(max, min);
        this.check_set(count);
    endfunction

    function load(int count);
        this.check_set(count);
    endfunction

    function check_limit(int arg1, int arg2);
        if(arg1 > arg2) begin
            this.max = arg1;
            this.min = arg2;
        end
        else begin
            this.max = arg2;
            this.min = arg1;
        end

    endfunction

    function check_set(int arg);
        if(arg > this.max || arg < this.min) begin
            this.count = this.min;
            $display("WARNING: argument outside min-max limits, the count value is the min value: %0d", this.count);
        end
        else 
            this.count = arg;

    endfunction

    function int getcount();
        return this.count;
    endfunction
endclass

