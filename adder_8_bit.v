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

module FA(a,b,cin,s,cout);
input a,b,cin;
output s,cout;
assign s=a^b^cin;
assign cout=a&b|a&cin|b&cin;
endmodule


