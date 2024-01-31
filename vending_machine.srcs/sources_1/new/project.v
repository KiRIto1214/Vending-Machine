`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.05.2   022 20:58:19
// Design Name: 
// Module Name: vending_modify
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
module D_FF(
    input clk,
    input D,
    output reg Q
    );

    always @ (posedge clk) begin
        Q <= D;
    end
endmodule

module OneHZ (input clk, reset, output clk1hz);
reg [26:0] counter;
always @(posedge clk)
begin
if (reset)
counter <= 0;
else
counter <= counter + 1;
end
assign clk1hz = (counter == 1);

endmodule

module debounce (clk_10Hz,button, debounced_button);

    input clk_10Hz;
    input button;
    output debounced_button;
    
    wire Q1;
    wire Q2;
    wire Q2_bar;

    D_FF d1(clk_10Hz, button, Q1);
    D_FF d2 (clk_10Hz, Q1, Q2);

    assign Q2_bar = ~Q2;

    assign debounced_button = Q1 & Q2_bar;

endmodule

module vending_modify(db_n,db_d,db_q, reset, clk,x, y);

output reg y;
input db_n,db_d,db_q; //n=5, d=10, q=25
input clk;
input reset;
output reg [6:0]x ;
reg [2:0] cst, nst;
wire clk1 ;
wire d,n,q ;

OneHZ one(clk, reset, clk1);



debounce d1(clk1,db_n,n);
debounce d2(clk1,db_d,d);
debounce d3(clk1,db_q,q);

parameter S0 = 3'b000,
          S1 = 3'b001,
          S2 = 3'b010,
          S3 = 3'b100,
          S4 = 3'b101,
          S5 = 3'b110,
          S6 = 3'b111;



always @(cst or d or n or q)
 begin
 case (cst)
   S0: 
      if (n== 1'b1 && d==1'b0 && q==1'b0)
            begin
             nst = S1;
             y=1'b0;
         //    l0 = 1'b1 ;
             
            end
      else if(n== 1'b0 && d==1'b1 && q==1'b0)
            begin
             nst=S2;
             y=1'b0;
           //  l0 = 1'b1 ;
            end
      else if(n== 1'b0 && d==1'b0 && q==1'b1)
            begin
             nst=S5;
             y=1'b0;
           //  l0 = 1'b1 ;
            end
      else
            begin
             nst = cst;
             y=1'b0;
           ////  l0 = 1'b1 ;
            end
   S1: if (n== 1'b1 && d==1'b0 && q==1'b0)
            begin
             nst = S2;
             y=1'b0;
           //  l1 = 1'b1 ;
            end
      else if(n== 1'b0 && d==1'b1 && q==1'b0)
            begin
             nst=S3;
             y=1'b0;
           //  l1 = 1'b1 ;
            end
      else if(n== 1'b0 && d==1'b0 && q==1'b1)
            begin
             nst=S6;
             y=1'b0;
            // l1 = 1'b1 ;
            end
      else
            begin
             nst = cst;
             y=1'b0;
           //  l1 = 1'b1 ;
            end
    S2: if (n== 1'b1 && d==1'b0 && q==1'b0)
            begin
             nst = S3;
             y=1'b0;
           //  l2 = 1'b1 ;
            end
      else if(n== 1'b0 && d==1'b1 && q==1'b0)
            begin
             nst=S4;
             y=1'b0;
           //  l2 = 1'b1 ;
            end
      else if(n== 1'b0 && d==1'b0 && q==1'b1)
            begin
             nst=S0;
             y=1'b1;
           //   l2 = 1'b1 ;
            end
      else
            begin
             nst = cst;
             y=1'b0;
           ///  l2 = 1'b1 ;
            end
    S3: if (n== 1'b1 && d==1'b0 && q==1'b0)
            begin
             nst = S4;
             y=1'b0;
           //  l3 = 1'b1 ;
            end
      else if(n== 1'b0 && d==1'b1 && q==1'b0)
            begin
             nst=S5;
             y=1'b0;
            // l3 = 1'b1 ;
            end
      else if(n== 1'b0 && d==1'b0 && q==1'b1)
            begin
             nst=S0;
             y=1'b1;
            // l3 = 1'b1 ;
            end
      else
            begin
             nst = cst;
             y=1'b0;
            // l3 = 1'b1 ;
            end  
    S4: if (n== 1'b1 && d==1'b0 && q==1'b0)
            begin
             nst = S5;
             y=1'b0;
            // l4 = 1'b1 ;
            end
      else if(n== 1'b0 && d==1'b1 && q==1'b0)
            begin
             nst=S6;
             y=1'b0;
            // l4 = 1'b1 ;
            end
      else if(n== 1'b0 && d==1'b0 && q==1'b1)
            begin
             nst=S0;
             y=1'b1;
            // l4 = 1'b1 ;
            end
      else
            begin
             nst = cst;
             y=1'b0;
            // l4 = 1'b1 ;
            end
    S5: if (n== 1'b1 && d==1'b0 && q==1'b0)
            begin
         nst = S6;
             y=1'b0;
             //l5 = 1'b1 ;
            end
      else if(n== 1'b0 && d==1'b1 && q==1'b0)
            begin
             nst=S0;
             y=1'b1;
             //l5 = 1'b1 ;
            end
      else if(n== 1'b0 && d==1'b0 && q==1'b1)
            begin
             nst=S0;
             y=1'b1;
            // l5 = 1'b1 ;
            end
      else
            begin
             nst = cst;
             y=1'b0;
            // l5 = 1'b1 ;
            end
    S6: if (n== 1'b1 && d==1'b0 && q==1'b0)
            begin
             nst =S0;
             y=1'b1;
            // l6 = 1'b1 ;
            end
      else if(n== 1'b0 && d==1'b1 && q==1'b0)
            begin
             nst=S0;
             y=1'b1;
            // l6 = 1'b1 ;
            end
      else if(n== 1'b0 && d==1'b0 && q==1'b1)
            begin
             nst=S0;
             y=1'b1;
             
            end
      else
            begin
             nst = cst;
             y=1'b0;
             
            end         
    default: nst = S0;
  endcase
end
always @(cst or d or n or q)
 begin
 case (cst)
   S0: x = 7'b0000001 ;
   S1: x = 7'b0000010 ;
   S2: x = 7'b0000100 ;
   S3: x = 7'b0001000 ;
   S4: x = 7'b0010000 ;
   S5: x = 7'b0100000 ;
   S6: x = 7'b1000000 ;
   
 endcase
end
   
always@(posedge clk1) 
begin
 if (reset)
   cst <= S0;
 else
   cst <= nst;
end
endmodule
