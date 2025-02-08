`include "adder_16bit.v"
`include "pipo_16bit.v"
module accumulator_16_bit(a,clk,b,c,rst);
input [15:0]a;
input clk,rst;
output [15:0]b;
output [3:0]c;
reg [15:0]bd;
adder_16bit A1(a,bd,b,c);
always @(posedge clk ) begin
    if (rst==1) begin
        bd<=0;
    end
    else bd<=b;
end

endmodule
