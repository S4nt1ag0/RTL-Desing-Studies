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

class Upcounter extends Counter;

    static int instance_acount = 0;
    static function int get_instance_acount();
        return instance_acount;
        
    endfunction
    
    int carry;

    function new(int count = 0, int max=1, int min=0);
        super.new(count, max, min);
        this.carry = 0;
        instance_acount++;
    endfunction

    function next();
        if (this.count == this.max) begin
            this.carry = 1; // Set carry when reaching max
            super.check_set(this.min); // Reset to min
        end 
        else begin
            this.carry = 0;
            super.check_set(this.count + 1);
        end
        $display("UpCounter: count = %0d, carry = %0d", this.count, this.carry);
    endfunction

endclass

