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

    static int instance_acount = 0;
    static function int get_instance_acount();
        return instance_acount;
        
    endfunction
    
    int borrow;
    
    function new(int count = 0, int max=1, int min=0);
        super.new(count, max, min);
        this.borrow = 0;
        instance_acount++;
    endfunction

    function next();
        if (this.count == this.min) begin
            this.borrow = 1; // Set borrow when reaching min
            super.check_set(this.max); // Reset to max
        end 
        else begin
            this.borrow = 0;
            super.check_set(this.count - 1);
        end
        $display("DownCounter: count = %0d, borrow = %0d", this.count, this.borrow);
    endfunction

endclass

