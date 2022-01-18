`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2021 12:19:55
// Design Name: 
// Module Name: Railway_car_topmodule
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


module Railway_car_topmodule(RIGHT,LEFT,DIR,AUTO,CLK,RESET,POS);

input RIGHT,LEFT,DIR,AUTO,CLK,RESET;
output [7:0]POS;

wire RL_comb,CLK_190,CLK_FSM_MANUAL,CLK_FSM_AUTO,CLK_FSM;

assign RL_comb = RIGHT | LEFT;      // Input to debouncer circuit

CLK_div C1(CLK,RESET,CLK_190);
CLK_div_AUTO C2(CLK,RESET,CLK_FSM_AUTO);

debouncer D1(RL_comb,CLK_190,RESET,CLK_FSM_MANUAL);

CLK_decider CD(CLK_FSM_MANUAL,CLK_FSM_AUTO,AUTO,CLK_FSM);

Railway_cart_FSM RCFSM1(RIGHT,LEFT,DIR,AUTO,CLK_FSM,RESET,POS);

endmodule
