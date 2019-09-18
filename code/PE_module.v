module PE_module#(
	parameter DATAWIDTH = 8
)
(
	input                        CLK,
	input                        RSTn,
	input  [ DATAWIDTH - 1 : 0 ] A,
	input  [ DATAWIDTH - 1 : 0 ] B,
	output [ DATAWIDTH - 1 : 0 ] Next_A,
	output [ DATAWIDTH - 1 : 0 ] Next_B,
	output [ DATAWIDTH * 2  : 0 ] PE_out
);

reg [ DATAWIDTH - 1 : 0 ] Next_A_reg;
reg [ DATAWIDTH - 1 : 0 ] Next_B_reg;
reg  [ DATAWIDTH * 2  : 0 ] PE_reg;
wire [ DATAWIDTH * 2 : 0 ] PE_net;
mult_add#(.DATAWIDTH(DATAWIDTH)) multadd(.A(A),
                                         .B(B),
				         .C(PE_reg),
				         .P(PE_net));

always @ ( posedge CLK or negedge RSTn )
begin
	if (!RSTn)
	begin
		Next_A_reg <= 0;
		Next_B_reg <= 0;
		PE_reg <= 0;
		
	end
	else 
	begin
		Next_A_reg <= A;
		Next_B_reg <= B;
		PE_reg <= PE_net;
	end
end

assign PE_out = PE_reg;
assign Next_A = Next_A_reg;
assign Next_B = Next_B_reg;
endmodule
