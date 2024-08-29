
`include "fractional_divider.v"
`timescale 1ns / 1ns
`define Tclk 4
`define TMod 112
/*module vaucher_2_3_tb;
    reg in,min,p,rst;
    wire out,mout;
    vaucher_2_3 v1(in,min,p,mou,out,rst);
    always #10 in<=~in;
    always #100 p=~p;
    initial begin
        rst=1;
        #20 rst=0;
    end
    initial begin
        in=0;
        min=1;
        p=1;
        $dumpfile("div.vcd"); 
        $dumpvars (0,vaucher_2_3_tb);
        # 1000 $finish ;
        
    end
   
endmodule*/
//`include "integer_divider.v"
/*
module tb_;
reg in_clk,rst;
reg [7:0]p;
reg [2:0]e;
wire out_clk,mout_clk;
integer_divider I1(in_clk,p,e,out_clk,mout_clk,rst);
always #10 in_clk<=~in_clk;
initial begin
    p<=0;
    e<=3'b110;
    rst<=1;
    in_clk<=0;
    #60 rst<=0;
end
initial begin
        $dumpfile("div.vcd"); 
        $dumpvars (0,tb_);
        # 20000 $finish ;
        
end
 


endmodule*/
module tb__;
reg [15:0]f_frac;
reg [7:0]p_int;
reg [2:0]e;
wire out_clk;

reg in_clk,rst,rst_ddsm;
wire signed [3:0]c;
fractional_divider t(in_clk,out_clk,p_int,e,f_frac,rst,rst_ddsm);
always #10 in_clk<=~in_clk;
initial begin
    rst=1;
    rst_ddsm=1;
    #50 rst=0;
    #3000 rst_ddsm=0;
end
initial begin
    in_clk<=0;
  
    p_int<=4;
    e<=3'b100;
    
    f_frac<=32768;
     $dumpfile("div.vcd"); 
        $dumpvars (0,tb__);
        # 200000 $finish ;
end
endmodule