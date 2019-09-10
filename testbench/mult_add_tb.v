module mult_add_tb();
	
	parameter DATAWIDTN = 8;
	
	reg [ DATAWIDTN - 1 : 0 ] A;
	reg [ DATAWIDTN - 1 : 0 ] B;
	reg [ DATAWIDTN - 1 : 0 ] C;
	wire [ DATAWIDTN * 2  : 0 ] P;
	
	initial
	begin
		A = 2;
		B = 2;
		C = 2;
		#200 A = 3;B = 3;C = 3;
	end
	
	mult_add ff(.A(A),
	            .B(B),
				.C(C),
				.P(P));
	endmodule