// Fractional Divider (dividin on an average which is the fractional value)
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

// 3rd-Order Digital delta sigma Modulator
module third_order_ddsm(a,c,clk,rst);
input [15:0]a;
input clk,rst;
output  signed[3:0]c;
wire [15:0]b0,b1,b2;
wire [3:0] c0,c1,c2;
reg signed[3:0]c2_d;
reg  signed[3:0]c3_d; 
wire signed[3:0]c3;

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

endmodule

//Integer divider with cascading 8 2-3 vaucher divider
module integer_divider(in_clk,p,e,out_clk,mout_clk,rst);
input in_clk,rst;
input [7:0]p;
input [2:0]e;
output out_clk,mout_clk;
wire [7:0] t,c,m,mn;
genvar i,j;
generate
    for (i = 0;i<7 ;i=i+1 ) begin:or_gates
        or g(mn[i],m[i+1],c[i]);
    end
endgenerate
generate
    for (j = 1;j<7 ;j=j+1 ) begin:vaucher
        vaucher_2_3 v(t[j],mn[j],p[j],m[j],t[j+1],rst);
    end
endgenerate
vaucher_2_3 v(in_clk,mn[0],p[0],mout_clk,t[1],rst);
vaucher_2_3 v1(t[7],mn[7],p[7],m[7],out_clk,rst);
assign mout_clk=m[0];
assign c[0]=mn[7];
decoder3x8 d(e,c);

endmodule

// 16-bit accumulator
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

//16-bit full adder
module adder_16bit(in1,in2,out,c);
input [15:0]in1,in2;
output [3:0]c;
output [15:0]out;
assign {c,out}=in1+in2;

endmodule

// divider which can switch between 2 or 3 dividing ratio called vaucher divider 
module vaucher_2_3(in,min,p,mout,out,rst);
	input in,min,p,rst;
	output out,mout;
	reg q0,q1;
	wire t0,t1;
	xnor g1(t0,q0,q1);
	and g2(t1,mout,p);
	and g3(mout,q0,min);
	assign out=~q0;
	always @(posedge in)begin
		if (rst==1) begin
			q0<=0;
			q1<=0;
		end
		else begin
		q0<=t0;
		q1<=t1;
		end
	end
endmodule

//3X8 Divider
module decoder3x8(in,out);
    input [2:0]in;
    output reg [7:0]out;
    always @(*) begin
        case (in)
            0:out=1;
            1:out=2;
            2:out=4;
            3:out=8;
            4:out=16;
            5:out=32;
            6:out=64;
            7:out=128;
            default: out=1;
        endcase
    end
endmodule

//8-bit adder
module adder_8_bit(a,b,cout,s);
input [7:0]a,b;
output cout;
output [7:0]s;
wire [6:0] c;
FA f1(a[0],b[0],1'b0,s[0],c[0]);
FA f2(a[1],b[1],c[0],s[1],c[1]);
FA f3(a[2],b[2],c[1],s[2],c[2]);
FA f4(a[3],b[3],c[2],s[3],c[3]);
FA f5(a[4],b[4],c[3],s[4],c[4]);
FA f6(a[5],b[5],c[4],s[5],c[5]);
FA f7(a[6],b[6],c[5],s[6],c[6]);
FA f8(a[7],b[7],c[6],s[7],cout);
endmodule

//full adder
module FA(a,b,cin,s,cout);
input a,b,cin;
output s,cout;
assign s=a^b^cin;
assign cout=a&b|a&cin|b&cin;
endmodule