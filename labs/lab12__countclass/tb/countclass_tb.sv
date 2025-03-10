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
    Upcounter new_upcounter_obj;
    Downcounter downcounter_obj;
    Timer timer_obj;

    initial begin
        $display("\n=== Before Constructors ===");
        $display("UpCounter: count_instance = %0d, ", upcounter_obj.get_instance_acount());
        $display("DownCounter: count_instance = %0d, ", downcounter_obj.get_instance_acount());


        $display("\n=== Initialization ===");
         // Creating objects with custom min and max values
        upcounter_obj = new(5, 7, 3);  // count=5, min=3, max=7
        downcounter_obj = new(7, 12, 5); // count=7, min=5, max=12
        timer_obj = new(22,55,40);
        
        //$display("Counter: count = %0d, min = %0d, max = %0d", counter_obj.getcount(), counter_obj.min, counter_obj.max);
        $display("UpCounter: count = %0d, min = %0d, max = %0d", upcounter_obj.getcount(), upcounter_obj.min, upcounter_obj.max);
        $display("DownCounter: count = %0d, min = %0d, max = %0d", downcounter_obj.getcount(), downcounter_obj.min, downcounter_obj.max);

        $display("\n=== After Constructors ===");
        $display("UpCounter: count_instance = %0d, ", upcounter_obj.get_instance_acount());
        $display("DownCounter: count_instance = %0d, ", downcounter_obj.get_instance_acount());

        // Testing load with out-of-range values
        $display("\n=== Testing Load with Out-of-Range Values ===");
        upcounter_obj.load(2); // Should be set to min = 3
        downcounter_obj.load(20); // Should be set to min = 5

        $display("UpCounter after load(2): count = %0d", upcounter_obj.getcount());
        $display("DownCounter after load(20): count = %0d", downcounter_obj.getcount());

        downcounter_obj.load(10);

        // Testing next() to ensure rollover occurs at limits
        $display("\n=== Testing Next and Rollover ===");
        upcounter_obj = new(3, 5, 2);  // min = 2, max = 5
        downcounter_obj = new(5, 7, 3); // min = 3, max = 7

        $display("\n=== Testing UpCounter ===");
        repeat(5) upcounter_obj.next(); // Test rollover

        $display("\n=== Testing DownCounter ===");
        repeat(5) downcounter_obj.next(); // Test rollover

        counter_obj = upcounter_obj;
        $cast(new_upcounter_obj, counter_obj);

        $display("\n=== Testing counter virtual ===");
        repeat(5) counter_obj.next(); //Test with assign Upcounter to Counter
        repeat(5) new_upcounter_obj.next(); //Test with Counter $Cast to Upcounter

        $display("\n=== Testing Timer ===");


        repeat(900) timer_obj.next(); // Test rollover


        #200 $finish;
    end
endmodule