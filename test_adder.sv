module test_adder();

timeunit 10ns;
timeprecision 1ns;

logic[7:0] A;
logic[7:0] S;
logic fn;
logic [8:0] Sum;

logic error_cnt;

adder Adder(.*);

initial begin: TEST_VECTORS

error_cnt=0;
A = 8'b0001000; //8
S = 8'b0000100; //4
fn = 0;

#2
if(Sum!=9'b00001100) //8+4=12
	error_cnt++;
	
#2
fn = 1;

#2
if(Sum!=9'b00000100) //8-4=4
	error_cnt++;

#2
A = 8'b11111110; //-2
S = 8'b00000011; //3
fn=0;

#2
if(Sum!=9'b000000001) //-2+3=1
	error_cnt++;

#2
fn=1;

#2
if(Sum!=9'b111111011) //-2-3=-5
	error_cnt++;

#2
A = 10000000; //-128
S = 10000000; //-128
fn = 0;

#2
if(Sum!=9'b100000000) //-128-128=256
	error_cnt++;
	
	

	
end
endmodule
