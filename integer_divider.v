`include "vaucher_2_3.v"
`include "3x8_decoder.v"
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
//assign in_clk=t[0];
assign mout_clk=m[0];
assign c[0]=mn[7];
decoder3x8 d(e,c);

endmodule