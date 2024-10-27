module counter(
input wire Q0,Q1,Q2,Q3,
output wire S0,S1,S2,S3,carry
);
 wire C0,C1,C2;

assign S0=Q0^1'b1;
assign C0=Q0&1'b1;
assign S1=Q1^C0;
assign C1=Q1&C0;
assign S2=Q2^C1;
assign C2=Q2&C1;
assign S3=Q3^C2;
assign carry=Q3&C2;

endmodule 