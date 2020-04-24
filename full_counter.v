// Le Duc Nhan has changed this document on April 24
// Le Duc Nhan has changed again 30 minute later
`timescale 1ms / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:29:28 01/21/2016 
// Design Name: 
// Module Name:    full_counter 
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
module full_counter(out,finish,clk,enable,rst);
	output [3:0]out;
	output [0:0]finish;
	input clk;
	input enable;
	input rst;
	wire [3:0]out1;
	wire [3:0]out2;
	wire clk_2;
	wire sel_1;
	wire [0:0]start;
	
	frequency_divider_by_2 g1(clk_2,clk,start);
	counter_1 g2(out1,sel_1,start,clk,enable,rst);
	counter_2 g3(out2,finish,clk_2,start,rst);
	select g4(out,sel_1,finish,out2,out1);
endmodule

module counter_2(out,finish,clk,start_2,rst);
output [3:0]out;
output [0:0]finish;
input clk;
input start_2;
input rst;
reg [3:0]out;
reg [0:0]finish;

always@(negedge clk or negedge rst) begin: net_1
if (!rst) begin
	out <= 4'b0000; 
	finish <= 1'b0;
	end
else if (start_2) begin
		if (out == 4'b1111) begin
		out <= 4'b0000;
		finish <= 1'b1;
		disable net_1;
		end
	  else out <= out + 1'b1;	  
	 end 
	end
endmodule

module counter_1(out,sel,start_2,clk,enable,rst);
output [3:0]out;
output [0:0]start_2;
output sel;
input clk;
input enable;
input rst;
reg [3:0]out;
reg [0:0]start_2;
reg sel;
 
always@(posedge clk or negedge rst) begin : counter1
if (!rst) begin
	out <= 4'b0000;
	sel <= 1'b0;
	//start_2 <= 1'b0;
	end
else if (enable) begin 
		if (out == 4'b1010) begin	
		start_2 <= 1'b1;
		sel <= 1'b1;
		out <= 4'b0000;
		disable counter1;
		end
	  else out <= out + 1'b1;	  
	 end 
	end
endmodule

module select(a,sel,finish,b,c);
	output [3:0]a;
	input [3:0]b;
	input [3:0]c;
	input sel;
	input finish;
	reg [3:0]a;
	
	always@(finish,sel,b,c) begin
	//assign a = (sel) ? b : c; 
	if(finish==1) begin
	a = 4'b0000;
	end
	else if (sel==0) begin
					a = c;
					end
			else begin 
			a = b;
			end
	end
endmodule

module frequency_divider_by_2 (clk3,clk,start_2);
output clk3;
reg clk3;
input clk;
input start_2;
//wire clk;
//initial clk2 = 0;
initial clk3 = 0;
 always@(posedge(clk)) begin
	if (start_2)
   clk3 <= ~clk3;
 end
endmodule
