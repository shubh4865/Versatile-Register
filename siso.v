module siso(
input wire serialin,clk,reset,
output reg serialout
);

reg q0,q1,q2,q3;

always @ (posedge clk or posedge reset)
     begin
      if (reset) 
             begin
                  q0<=1'b0;
                   q1<=1'b0;
                    q2<=1'b0;
                     q3<=1'b0;
               end
     else
              begin
                  q3<=serialin;
                   q2<=q3;
                    q1<=q2;
                     q0<=q1;
               end 
     end
always @ (posedge clk or posedge reset)
     begin
if (reset) 
    begin
        serialout<=1'b0;
     end
        else begin
            serialout<= q0;
              end
    end
endmodule
        