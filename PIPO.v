module PIPO(
input wire parin3,parin2,parin1,parin0,clk,reset,
output reg Q3,Q2,Q1,Q0
);

always @(posedge clk or posedge reset)
       begin 
            if (reset) 
          begin
              Q3<=1'b0;
              Q2<=1'b0;
              Q1<=1'b0;
              Q0<=1'b0;
           end
          else 
             begin
              Q3<=parin3;
              Q2<=parin2;
              Q1<=parin1;
              Q0<=parin0;
             end 
         end
endmodule
         