module Systolic_Array#(
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
	output reg [ DATAWIDTN * 2 - 1 : 0 ] P11,P12,P13,
	output reg [ DATAWIDTN * 2 - 1 : 0 ] P21,P22,P23,
	output reg [ DATAWIDTN * 2 - 1 : 0 ] P31,P32,P33,
	output                               Done
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
reg isDone;

always @ ( posedge CLK or negedge RSTn )
begin
	if (!RSTn)
		counter <= 0;
	else if (start)
		begin
			if (counter == 7)
				counter <= 0;
			else
				counter <= counter + 1'b1;
		end
	else
		counter <= 0;
	 
		
end

always @ ( posedge CLK or negedge RSTn )
begin
    if (!RSTn)
        isDone <= 0;
    else if ( counter == 7 )
        isDone <= 1;
    else 
        isDone <= 0;
end

assign Done = isDone;

always @ ( posedge CLK or negedge RSTn )
begin
	if (!RSTn)
	begin
		P11 <= 0;
		P12 <= 0;
		P13 <= 0;
		P21 <= 0;
		P22 <= 0;
		P23 <= 0;
		P31 <= 0;
		P32 <= 0;
		P33 <= 0;
	end
	else if (Done)
	begin
		P11 <= P11_reg;
		P12 <= P12_reg;
		P13 <= P13_reg;
		P21 <= P21_reg;
		P22 <= P22_reg;
		P23 <= P23_reg;
		P31 <= P31_reg;
		P32 <= P32_reg;
		P33 <= P33_reg;
	end
	else 
	begin
		P11 <= 0;
		P12 <= 0;
		P13 <= 0;
		P21 <= 0;
		P22 <= 0;
		P23 <= 0;
		P31 <= 0;
		P32 <= 0;
		P33 <= 0;
		
	end
end

//counter ctr (.CLK(CLK),
//                 .RSTn(RSTn),
//				 .start(start),
//				 .counter(icounter));

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
			   
endmodule
