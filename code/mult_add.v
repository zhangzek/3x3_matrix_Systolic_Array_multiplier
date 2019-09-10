module mult_add#(
	parameter DATAWIDTN = 8
)
(
	input  [ DATAWIDTN - 1 : 0 ] A,
	input  [ DATAWIDTN - 1 : 0 ] B,
	input  [ DATAWIDTN - 1 : 0 ] C,
	output [ DATAWIDTN * 2  : 0 ] P
);

wire [ DATAWIDTN * 2  : 0 ] mult = A * B;
wire [ DATAWIDTN * 2  : 0 ] P_w = mult + C;
assign P = P_w;

endmodule