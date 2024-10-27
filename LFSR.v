/*module LFSR(
input wire clk,reset,
output reg [3:0]lfsrout
);

reg q0,q1,q2,q3,y;


always @ (posedge clk or posedge reset)
     begin
      if (reset) 
             begin
                  q0<=1'b1;
                   q1<=1'b1;
                   q2<=1'b1;
                   q3<=1'b1;
                    y<=1'b0;
               end
     else
              begin
                   y<=q3^q0;                  
                   q3<=y;
                   q2<=q3;
                    q1<=q2;
                     q0<=q1;
                    lfsrout<={q2,q1,q0,y};
               end 
     end
/*always @ (posedge clk or posedge reset)
     begin
if (reset) 
    begin
        serialout<=1'b0;
     end
        else begin
            serialout<= q0;
              end
    end
endmodule*/



module LFSR (
    input wire clk,
    input wire reset,
    output reg [3:0] lfsr_out
);

    wire feedback;

    // Feedback is the XOR of the two tap positions Q3 (MSB) and Q2
    assign feedback = lfsr_out[3] ^ lfsr_out[2];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            lfsr_out <= 4'b1111; // Initialize to the state "1111"
        end else begin
            lfsr_out <= {lfsr_out[2:0], feedback}; // Shift left and insert feedback at LSB
        end
    end

endmodule

        