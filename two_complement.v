module two_complement(in,out);
input [3:0]in;
output signed [3:0]out;
assign out=~in+1;

endmodule