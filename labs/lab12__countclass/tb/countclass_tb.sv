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
    Upcounter upcounter_obj;
    Downcounter downcounter_obj;

    initial begin
         // Creating objects with custom min and max values
        counter_obj = new(4, 10, 2);   // count=4, min=2, max=10
        upcounter_obj = new(5, 7, 3);  // count=5, min=3, max=7
        downcounter_obj = new(7, 12, 5); // count=7, min=5, max=12

        $display("\n=== Initialization ===");
        $display("Counter: count = %0d, min = %0d, max = %0d", counter_obj.getcount(), counter_obj.min, counter_obj.max);
        $display("UpCounter: count = %0d, min = %0d, max = %0d", upcounter_obj.getcount(), upcounter_obj.min, upcounter_obj.max);
        $display("DownCounter: count = %0d, min = %0d, max = %0d", downcounter_obj.getcount(), downcounter_obj.min, downcounter_obj.max);

        // Testing load with out-of-range values
        $display("\n=== Testing Load with Out-of-Range Values ===");
        counter_obj.load(15); // Should be set to min = 2
        upcounter_obj.load(2); // Should be set to min = 3
        downcounter_obj.load(20); // Should be set to min = 5

        $display("Counter after load(15): count = %0d", counter_obj.getcount());
        $display("UpCounter after load(2): count = %0d", upcounter_obj.getcount());
        $display("DownCounter after load(20): count = %0d", downcounter_obj.getcount());

        downcounter_obj.load(10);

        // Testing next() to ensure rollover occurs at limits
        $display("\n=== Testing Next and Rollover ===");
        repeat(6) begin
            upcounter_obj.next();
            downcounter_obj.next();
            $display("UpCounter: count = %0d", upcounter_obj.getcount());
            $display("DownCounter: count = %0d", downcounter_obj.getcount());
        end

        #200 $finish;
    end
endmodule