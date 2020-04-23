"please correct this file"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:25:32 01/19/2016 
// Design Name: 
// Module Name:    RF 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module decoder5_32(y,x,reg_write);
input [4:0]x;
input reg_write;
wire [3:0]b;
output [31:0]y;

decoder2_4 g1(b,x[4:3],reg_write);
decoder3_8 g2(y[31:24],x[2:0],b[3]);
decoder3_8 g3(y[23:16],x[2:0],b[2]);
decoder3_8 g4(y[15:8],x[2:0],b[1]);
decoder3_8 g5(y[7:0],x[2:0],b[0]);
endmodule

module decoder2_4(y,x,sel);
input [1:0]x;
input sel;
wire bsel;
wire [1:0]nx;
wire [1:0]bx;
output [3:0]y;

not not0(nx[0],x[0]);
not not1(nx[1],x[1]);
buf buf0(bx[0],x[0]);
buf buf1(bx[1],x[1]);
buf buf2(bsel,sel);

and and0(y[0],nx[0],nx[1],bsel);
and and1(y[1],x[0],nx[1],bsel);
and and2(y[2],nx[0],x[1],bsel);
and and3(y[3],x[0],x[1],bsel);
endmodule

module decoder3_8(y,x,sel);
input [2:0]x;
input sel;
wire bsel;
wire [2:0]nx;
wire [2:0]bx;
output [7:0]y;

not not0(nx[0],x[0]);
not not1(nx[1],x[1]);
not not2(nx[2],x[2]);

buf buf0(bx[0],x[0]);
buf buf1(bx[1],x[1]);
buf buf2(bx[2],x[2]);
buf buf3(bsel,sel);

and and0(y[0],nx[0],nx[1],nx[2],bsel);
and and1(y[1],x[0],nx[1],nx[2],bsel);
and and2(y[2],nx[0],x[1],nx[2],bsel);
and and3(y[3],x[0],x[1],nx[2],bsel);
and and4(y[4],nx[0],nx[1],x[2],bsel);
and and5(y[5],x[0],nx[1],x[2],bsel);
and and6(y[6],nx[0],x[1],x[2],bsel);
and and7(y[7],x[0],x[1],x[2],bsel);
endmodule
