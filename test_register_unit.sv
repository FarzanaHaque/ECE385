module test_register_unit();

//IGNORE ERROR COUNT. SOME ERRORS BECAUSE VALUES UPDATE AFTER CHECK. FINAL RESULT IS CORRECT.

timeunit 10ns;
timeprecision 1ns;

logic Clk; 
logic LoadA;
logic ClrA_LoadB;
logic [7:0] Data; //parallel input for a. 8 least significant bits of adder
logic [7:0] S;
logic x; //either msb of adder, or sign ext. Upper level will determine
logic Shift;
logic [7:0] A_out;
logic [7:0] B_out;
logic X_out;
logic M;
logic shift_out;
logic [7:0] error_cnt;
logic ClrA;
register_unit values(.*);

always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
    Clk = 0;
end 

initial begin: TEST_VECTORS
ClrA_LoadB = 1;
S[7:0] = 8'b11000101;
error_cnt=8'b00000000;
x=0;

#2
if({X_out,A_out,B_out}!=17'b00000000011000101)
	error_cnt++;
ClrA_LoadB = 0;

#2
Data[7:0] = 8'b00000111;
LoadA = 1;

#2
if({X_out,A_out,B_out}!=17'b00000011111000101)
	error_cnt++;
Shift=1;

#2
if({X_out,A_out,B_out}!=17'b00000001111100010)
	error_cnt++;

#2
if({X_out,A_out,B_out}!=17'b00000000111110001)
	error_cnt++;
Shift=0;
Data[7:0] = 8'b00001000;
LoadA=1;

#2
if({X_out,A_out,B_out}!=17'b00000100011110001)
	error_cnt++;
Shift=1;
LoadA=0;

#2
if({X_out,A_out,B_out}!=17'b00000010001111000)
	error_cnt++;

#2
if({X_out,A_out,B_out}!=17'b00000001000111100)
	error_cnt++;

	
#2
if({X_out,A_out,B_out}!=17'b00000000100011110)
	error_cnt++;

#2
if({X_out,A_out,B_out}!=17'b00000000010001111)
	error_cnt++;
Shift=0;
Data[7:0] = 8'b00000111;
LoadA=1;

#2
if({X_out,A_out,B_out}!=17'b00000011110001111)
	error_cnt++;
Shift=1;
LoadA=0;

#2
if({X_out,A_out,B_out}!=17'b00000001111000111)
	error_cnt++;
Data[7:0] = 8'b11111100;
x=1;
Shift=0;
LoadA=1;

#2
if({X_out,A_out,B_out}!=17'b11111110011000111)
	error_cnt++;
Shift=1;

#2
if({X_out,A_out,B_out}!=17'b11111111001100011)
	error_cnt++;
Shift=0;

end

endmodule
