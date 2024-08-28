`include "adder_16bit.v"
`include "pipo_16bit.v"
module accumulator_16_bit(a,clk,bd,c,rst);
input [15:0]a;
input clk,rst;
output reg [15:0]bd;
output [3:0]c;
wire [15:0]b;
adder_16bit A1(a,bd,b,c);
always @(posedge clk ) begin
    if (rst==1) begin
        bd<=0;
    end
    else bd<=b;
end

endmodule