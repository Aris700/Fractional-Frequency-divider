module adder_16bit(in1,in2,out,c);
input [15:0]in1,in2;
output [3:0]c;
output [15:0]out;
assign {c,out}=in1+in2;

endmodule