module Systolic_Array_pipeline#(
	parameter DATAWIDTN = 8
)
(
	input                            CLK,
	input                            RSTn,
	input                            start,
	
	input      [ DATAWIDTN - 1 : 0 ] A0,
	input      [ DATAWIDTN - 1 : 0 ] A1,
	input      [ DATAWIDTN - 1 : 0 ] A2,
	input      [ DATAWIDTN - 1 : 0 ] B0,
	input      [ DATAWIDTN - 1 : 0 ] B1,
	input 	   [ DATAWIDTN - 1 : 0 ] B2,
	output				P11v,P1221v,P132231v,P3223v,P33v,
	output reg [ DATAWIDTN * 2 - 1 : 0 ] P11,P12,P13,
	output reg [ DATAWIDTN * 2 - 1 : 0 ] P21,P22,P23,
	output reg [ DATAWIDTN * 2 - 1 : 0 ] P31,P32,P33
	//output                               Done
);

wire [ DATAWIDTN - 1 : 0 ] P11_A,P11_B;
wire [ DATAWIDTN - 1 : 0 ] P12_A,P12_B;
wire [ DATAWIDTN - 1 : 0 ] P21_A,P21_B;
wire [ DATAWIDTN - 1 : 0 ] P22_A,P22_B;
wire [ DATAWIDTN - 1 : 0 ] P31_A,P32_A;
wire [ DATAWIDTN - 1 : 0 ] P13_B,P23_B;

wire [ DATAWIDTN * 2 - 1 : 0 ] P11_reg;
wire [ DATAWIDTN * 2 - 1 : 0 ] P12_reg;
wire [ DATAWIDTN * 2 - 1 : 0 ] P13_reg;
wire [ DATAWIDTN * 2 - 1 : 0 ] P21_reg;
wire [ DATAWIDTN * 2 - 1 : 0 ] P22_reg;
wire [ DATAWIDTN * 2 - 1 : 0 ] P23_reg;
wire [ DATAWIDTN * 2 - 1 : 0 ] P31_reg;
wire [ DATAWIDTN * 2 - 1 : 0 ] P32_reg;
wire [ DATAWIDTN * 2 - 1 : 0 ] P33_reg;

reg [3:0] counter;
reg [3:0] counter1;
reg [3:0] counter2;
reg [3:0] counter3;
reg [3:0] counter4;

always @(posedge CLK or negedge RSTn)
	begin
		if (!RSTn) 
		begin
		counter <= 0;
		counter1 <= 0;
		counter2 <= 0;
		counter3 <= 0;
		counter4 <= 0;
		end
		else if (start) 
		begin
			counter1 <= counter;
			counter2 <= counter1;
			counter3 <= counter2;
			counter4 <= counter3;
			if (counter == 3)
				counter <= 0;
			else
				counter <= counter + 1;
		end
			else
			counter <= 0;
end

assign P11v = ( counter == 3 );
assign P1221v = ( counter1 == 3 );
assign P132231v = ( counter2 == 3 );
assign P3223v = ( counter3 == 3 );
assign P33v = ( counter4 == 3 );

PE_module PE11(.CLK(CLK),
               .RSTn(RSTn),
			   .A(A0),
			   .B(B0),
			   .Next_A(P11_A),
			   .Next_B(P11_B),
			   .PE_out(P11_reg));
PE_module PE12(.CLK(CLK),
               .RSTn(RSTn),
			   .A(P11_A),
			   .B(B1),
			   .Next_A(P12_A),
			   .Next_B(P12_B),
			   .PE_out(P12_reg));
PE_module PE13(.CLK(CLK),
               .RSTn(RSTn),
			   .A(P12_A),
			   .B(B2),
			   .Next_A(),
			   .Next_B(P13_B),
			   .PE_out(P13_reg));
PE_module PE21(.CLK(CLK),
               .RSTn(RSTn),
			   .A(A1),
			   .B(P11_B),
			   .Next_A(P21_A),
			   .Next_B(P21_B),
			   .PE_out(P21_reg));
PE_module PE22(.CLK(CLK),
               .RSTn(RSTn),
			   .A(P21_A),
			   .B(P12_B),
			   .Next_A(P22_A),
			   .Next_B(P22_B),
			   .PE_out(P22_reg));
PE_module PE23(.CLK(CLK),
               .RSTn(RSTn),
			   .A(P22_A),
			   .B(P13_B),
			   .Next_A(),
			   .Next_B(P23_B),
			   .PE_out(P23_reg));
PE_module PE31(.CLK(CLK),
               .RSTn(RSTn),
			   .A(A2),
			   .B(P21_B),
			   .Next_A(P31_A),
			   .Next_B(),
			   .PE_out(P31_reg));
PE_module PE32(.CLK(CLK),
               .RSTn(RSTn),
			   .A(P31_A),
			   .B(P22_B),
			   .Next_A(P32_A),
			   .Next_B(),
			   .PE_out(P32_reg));
PE_module PE33(.CLK(CLK),
               .RSTn(RSTn),
			   .A(P32_A),
			   .B(P23_B),
			   .Next_A(),
			   .Next_B(),
			   .PE_out(P33_reg));
			   
			   
always @ (*)
begin
	if (!RSTn)
		P11 <= 0;
	else if ( P11v ) 
		P11 <= P11_reg;
	else
	   P11 <= 0;
end
always @ (*)
begin
	if (!RSTn)
		P12 <= 0;
	else if ( P1221v ) 
		P12 <= P12_reg;
	else
	   P12 <= 0;
end
always @ (*)
begin
	if (!RSTn)
		P13 <= 0;
	else if ( P132231v ) 
		P13 <= P13_reg;
	else
		P13 <= 0;
end
always @ (*)
begin
	if (!RSTn)
		P21 <= 0;
	else if ( P1221v ) 
		P21 <= P21_reg;
	else
		P21 <= 0;
end
always @ (*)
begin
	if (!RSTn)
		P22 <= 0;
	else if ( P132231v ) 
		P22 <= P22_reg;
	else
		P22 <= 0;
end
always @ (*)
begin
	if (!RSTn)
		P23 <= 0;
	else if ( P3223v ) 
		P23 <= P23_reg;
	else
		P23 <= 0;
end
always @ (*)
begin
	if (!RSTn)
		P31 <= 0;
	else if ( P132231v ) 
		P31 <= P31_reg;
	else
		P31 <= 0;
end
always @ (*)
begin
	if (!RSTn)
		P32 <= 0;
	else if ( P3223v ) 
		P32 <= P32_reg;
	else
		P32 <= 0;
end
always @ (*)
begin
	if (!RSTn)
	begin
		P33 <= 0;
	end
	else if ( P33v ) 
		P33 <= P33_reg;
	else
		P33 <= 0;
end
					   
//assign P11 = ( P11v ) ? P11_reg : 0;
//assign P12 = ( P1221v ) ? P12_reg : 0;
//assign P13 = ( P132231v ) ? P13_reg : 0;
//assign P21 = ( P1221v ) ? P21_reg : 0;
//assign P22 = ( P132231v ) ? P22_reg : 0;
//assign P23 = ( P3223v ) ? P23_reg : 0;
//assign P31 = ( P132231v ) ? P31_reg : 0;
//assign P32 = ( P3223v ) ? P32_reg : 0;
//assign P33 = ( P33v ) ? P33_reg : 0;
endmodule