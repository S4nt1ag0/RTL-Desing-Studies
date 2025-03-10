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

class Timer;

Upcounter hours;
Upcounter minutes;
Upcounter seconds;



function new(int hours = 0, int minutes=1, int seconds=0);
    this.hours = new(hours, 23, 0);
    this.minutes = new(minutes, 59, 0);
    this.seconds = new(seconds, 59, 0);
endfunction

function load(int hours = 0, int minutes=1, int seconds=0);
    this.hours.load(hours);
    this.minutes.load(minutes);
    this.seconds.load(seconds);
endfunction

function showval();
    $display("Hours: %0d : %0d : %0d", this.hours.getcount(), this.minutes.getcount(), this.seconds.getcount() );
endfunction

function next();
    this.seconds.next();
    if(this.seconds.carry) begin
        this.minutes.next();
    end

    if(this.minutes.carry && this.seconds.carry) begin
        this.hours.next();
    end

    this.showval();

endfunction
endclass