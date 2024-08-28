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