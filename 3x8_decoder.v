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