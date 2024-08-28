`include "3rd_order_ddsm.v"
`include "integer_divider.v"
`include "adder_8_bit.v"
module fractional_divider(in_clk,out_clk,p_int,e,f_frac,rst,rst_ddsm);
input in_clk,rst,rst_ddsm;
input [7:0]p_int;
input [2:0]e;
input [15:0]f_frac;
output out_clk;
wire [3:0]c;
wire [7:0] p;
reg [7:0]cs;
wire cout;
integer_divider I1 (.in_clk(in_clk),.p(p),.e(e),.mout_clk(out_clk),.rst(rst));
third_order_ddsm T1(f_frac,c,out_clk,rst_ddsm);
always @(c) begin
    if (c[3]==1) begin
        cs={1'b1,1'b1,1'b1,1'b1,c};   
    end
    else cs={1'b0,1'b0,1'b0,2'b0,c};
end
adder_8_bit a1(p_int,cs,cout,p);
endmodule