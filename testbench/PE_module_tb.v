module PE_module_tb();

	parameter DATAWIDTH = 8;
	
	reg CLK;
	reg RSTn;
	reg [ DATAWIDTH - 1 : 0 ] A;
	reg [ DATAWIDTH - 1 : 0 ] B;
	wire [ DATAWIDTH - 1 : 0 ] Next_A;
	wire [ DATAWIDTH - 1 : 0 ] Next_B;
	wire [ DATAWIDTH * 2 : 0 ] PE_out;
	
	
PE_module#(.DATAWIDTH(DATAWIDTH)) PE(.CLK(CLK),
             .RSTn(RSTn),
			 .A(A),
			 .B(B),
			 .Next_A(Next_A),
			 .Next_B(Next_B),
			 .PE_out(PE_out));
			 
initial
begin
	CLK = 0;
	forever #100 CLK = ~CLK;
	
end

			 
initial
begin
	RSTn = 1;
	#50 RSTn = 0;
	#100 RSTn = 1;
	A = 2;
	B = 3;
	#200 A=4;B=5;
	#200 A=6;B=7;
	#200 A=8;B=1;
end
endmodule