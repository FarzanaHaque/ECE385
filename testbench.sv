module testbench();

timeunit 10ns;
timeprecision 1ns;

logic Clk, Reset, Run, ClearA_LoadB;
logic [7:0] S;
logic [6:0] AhexU, AhexL, BhexU, BhexL; 
logic [7:0] Aval, Bval;
logic X;
logic [4:0] state;
logic M;
logic ResetL,RunL,ClearA_LoadBL;
logic[2:0] error_cnt;

multiplier m(.*);


always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
    Clk = 0;
end 

initial begin: TEST_VECTORS

Reset = 1; //State A
Run=0;

#2

ClearA_LoadB = 1; //State B
S = 8'b11000101;
Reset = 0;

#2

ClearA_LoadB = 0; //State C


#2

S = 8'b00000111;

#2

Run = 1; //Start Execution Cycle

#35

Run = 0;
S = 8'b11111111;

#2

Run = 1;



end

endmodule

