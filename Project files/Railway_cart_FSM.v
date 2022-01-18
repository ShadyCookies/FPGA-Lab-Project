`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2021 11:19:36
// Design Name: 
// Module Name: Railway_cart_FSM
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


module Railway_cart_FSM(RIGHT,LEFT,DIR,AUTO,CLK,RESET,POS);

input RIGHT,LEFT,DIR,AUTO,CLK,RESET;
output reg [7:0]POS;


parameter SSTART = 3'b000, SRIGHT = 3'b001, SLEFT = 3'b010, SMOV_RIGHT = 3'b100, SMOV_LEFT = 3'b101; 
reg [2:0] present_state,next_state;


always @ (posedge CLK,posedge RESET)    // State register and output
begin
    if(RESET == 1) 
        begin
        present_state = SSTART;
        POS = 8'b1100_0000;
        end
    else begin
            present_state = next_state;
            if(next_state == SMOV_RIGHT && POS != 8'b0000_0011) POS = POS >> 1;
            else if (next_state == SMOV_LEFT && POS != 8'b1100_0000) POS = POS << 1;
            else POS = POS;
    end
end    

always @ (present_state,RIGHT,LEFT,DIR) // Input logic
begin
    case(present_state)
    SSTART: if (DIR == 0 && AUTO == 0)                                          // starting state
            next_state = (RIGHT == 1)? SRIGHT : (LEFT == 1)? SLEFT : SSTART;
            else if (DIR == 0 && AUTO == 1)                                     
            next_state = SRIGHT;
            else if (DIR == 1 && AUTO == 0)                                    
            next_state = (RIGHT == 1)? SRIGHT : (LEFT == 1)? SLEFT : SSTART;
            else if (DIR == 1 && AUTO == 1)                                     
            next_state = SLEFT;
    SRIGHT: if (DIR == 0 && AUTO == 0)                                              // right pressed
            next_state = (RIGHT == 1)? SSTART : (LEFT == 1)? SMOV_RIGHT : SRIGHT;   // Multiple RIGHT inputs will reset to the original state
            else if (DIR == 0 && AUTO == 1)                                         
            next_state =  SMOV_RIGHT;
            else if (DIR == 1 && AUTO == 0)                                       
            next_state = (RIGHT == 1)? SSTART : (LEFT == 1)? SLEFT : SRIGHT;
            else if (DIR == 1 && AUTO == 1)                                      
            next_state = SLEFT;
    SLEFT: if (DIR == 0 && AUTO == 0)                                           // left pressed
            next_state = (RIGHT == 1)? SRIGHT : (LEFT == 1)? SSTART : SLEFT;
            else if (DIR == 0 && AUTO == 1)                                    
            next_state = SRIGHT;
            else if (DIR == 1 && AUTO == 0)
            next_state = (RIGHT == 1)? SMOV_LEFT : (LEFT == 1)? SSTART : SLEFT; // Multiple LEFT inputs will reset to the original state
            else if (DIR == 1 && AUTO == 1)
            next_state = SMOV_LEFT;
    SMOV_RIGHT: 
            if (DIR == 0 && AUTO == 0)                                           // right & left pressed OR auto move right
            next_state = (RIGHT == 1)? SRIGHT : (LEFT == 1)? SLEFT : SMOV_RIGHT;
            else if (DIR == 0 && AUTO == 1)
            next_state = SRIGHT;
            else if (DIR == 1 && AUTO == 0)
            next_state = (RIGHT == 1)? SRIGHT : (LEFT == 1)? SLEFT : SMOV_RIGHT;
            else if (DIR == 1 && AUTO == 1)
            next_state = SLEFT;
    SMOV_LEFT: if (DIR == 0 && AUTO == 0)                                       // left and right pressed OR auto move left
            next_state = (RIGHT == 1)? SRIGHT : (LEFT == 1)? SLEFT : SMOV_LEFT;
            else if (DIR == 0 && AUTO == 1)
            next_state = SRIGHT;
            else if (DIR == 1 && AUTO == 0)
            next_state = (RIGHT == 1)? SRIGHT : (LEFT == 1)? SLEFT : SMOV_LEFT;
            else if (DIR == 1 && AUTO == 1)
            next_state = SLEFT;
    endcase
end

endmodule
