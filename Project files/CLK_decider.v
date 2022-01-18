`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.11.2021 12:39:46
// Design Name: 
// Module Name: CLK_decider
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

// USed to decide which CLK signal to use based on whether AUTO is 0 or 1

module CLK_decider(CLK_pushbutton,CLK_auto,AUTO,CLK_out);

input CLK_pushbutton,CLK_auto,AUTO;
output reg CLK_out;

always@(AUTO)
begin
    if(AUTO == 0)
        CLK_out = CLK_pushbutton;
    else 
        CLK_out = CLK_auto;
end

endmodule
