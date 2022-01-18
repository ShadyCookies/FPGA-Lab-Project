`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.11.2021 11:28:37
// Design Name: 
// Module Name: CLK_div_AUTO
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

// Generates a CLK signal for the railway cart automatic mode , with a frequency of 24 Hz or 42 ms

module CLK_div_AUTO(input CLK,input RESET,output CLK_div_auto);
reg [21:0] count_div;
always @ (posedge CLK,posedge RESET)
begin
    if (RESET == 1)
        count_div <= 0;
    else
        count_div <= count_div + 1;
end
assign CLK_div_auto = count_div[21];
endmodule
