`include "16_bit_Accumulator.v"
`include "two_complement.v"
module third_order_ddsm(a,c,clk,rst);
input [15:0]a;
input clk,rst;
output  signed[3:0]c;
wire [15:0]b0,b1,b2;
wire [3:0] c0,c1,c2;
reg signed[3:0]c2_d;//wire [3:0]neg_c2_d;
reg  signed[3:0]c3_d; //wire [3:0]neg_c3_d;
wire signed[3:0]c3;
//wire [3:0] s0,s1;
//wire g1,g2,g3,g4;
accumulator_16_bit A1(a,clk,b0,c0,rst);
accumulator_16_bit A2(b0,clk,b1,c1,rst);
accumulator_16_bit A3(b1,clk,b2,c2,rst);
always @(posedge clk ) begin
    if (rst==1) begin
        c2_d<=0;
        c3_d<=0;
    end
    else begin
        c2_d<=c2;
        c3_d<=c3;
    end
end
assign c3=c1+c2-c2_d;
assign c=c0+c3-c3_d;
/*two_complement T1(c2_d,neg_c2_d);
two_complement T2(c3_d,neg_c3_d);
FA_4bit S1(c2,neg_c2_d,s0,g1);
FA_4bit S2(c3,neg_c3_d,s1,g2);
FA_4bit S3(c1,s0,c3,g3);
FA_4bit S4(c0,s1,c,g4);*/


endmodule

/*module FA(a,b,cin,s,cout);
input a,b,cin;
output s,cout;
assign s=a^b^cin;
assign cout=a&b|a&cin|b&cin;
endmodule

module FA_4bit(a,b,s,cout);
input [3:0]a,b;
output cout;
output [3:0]s;
wire [2:0] c;
FA f1(a[0],b[0],1'b0,s[0],c[0]);
FA f2(a[1],b[1],c[0],s[1],c[1]);
FA f3(a[2],b[2],c[1],s[2],c[2]);
FA f4(a[3],b[3],c[2],s[3],cout);

endmodule*/