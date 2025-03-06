//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2025 01:34:33 PM
// Design Name: 
// Module Name: cpu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Createdgithub
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module flipflop (
    input logic clk,          // Clock
    input logic reset_n,      // Reset assíncrono ativo em nível baixo
    input logic [7:0] d,      // Entrada de dados
    output logic [7:0] q      // Saída armazenada
);

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            q <= 8'b0;  // Resetar saída
        else
            q <= d;  // Capturar entrada
    end

endmodule