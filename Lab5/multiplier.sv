module multiplier
( 
input logic Clk, Reset, Run, ClearA_LoadB,
input logic [7:0] S ,
output logic [6:0] AhexU, AhexL, BhexU, BhexL, 
output logic [7:0] Aval, Bval,
output logic X,
output logic ResetL,RunL,ClearA_LoadBL   

//output logic [4:0] state
//output logic M
);

 	
/*
Inputs
S – logic [7:0]
Clk, Reset, Run, ClearA_LoadB – logic
Outputs
AhexU, AhexL, BhexU, BhexL – logic [6:0]
Aval, Bval – logic [7:0]
X –logic

*/
	 
	 
	 //We can use the "assign" statement to do simple combinational logic

//logic Reset_SH, ClearA_LoadB_SH, Run_SH;	
logic Clr_Ld, Shift, Add, Sub;// intermediary logic from control output
logic [8:0] Adder_Sum; //output of adder
logic Load_A;
assign Load_A = Add^Sub; //Load data from adder into register if add or sub is 1.
logic m0;
logic ClrA;
assign ResetL=Reset;
assign RunL=Run;
assign ClearA_LoadBL=ClearA_LoadB;
	// assign LED = {Run_SH,ClearA_LoadB_SH,Reset_SH}; //Concatenate is a common operation in HDL
	 //assign LED = {Run_SH,ClearA_LoadB_SH,Reset_SH}; //Concatenate is a common operation in HDL
controlunit control
(
.Clk(Clk), 
.Reset(~Reset), 
.Run(~Run), 
.ClearA_LoadB(~ClearA_LoadB),
.m(M),
.m0(m0),
.Clr_Ld(Clr_Ld), 
.Shift(Shift), 
.Add(Add), 
.Sub(Sub),
.ClrA(ClrA)//,
//.state(state[4:0])
);

adder Adder
(
.A(Aval),
.S(S[7:0]),
.fn(Sub),
.Sum(Adder_Sum[8:0])
);


register_unit registers
(
.Clk(Clk),
.LoadA(Load_A),
.ClrA_LoadB(Clr_Ld),
.Data(Adder_Sum[7:0]),    //output from adder
.S(S[7:0]),
.x(Adder_Sum[8]), //msb output from adder
.Shift(Shift),
.A_out(Aval),
.B_out(Bval),
.X_out(X),
.M(M),
.shift_out(m0),
.ClrA(ClrA)
);

HexDriver        HexAL (
                        .In0(Aval[3:0]),
                        .Out0(AhexL) );
	 HexDriver        HexBL (
                        .In0(Bval[3:0]),
                        .Out0(BhexL) );
								
	 //When you extend to 8-bits, you will need more HEX drivers to view upper nibble of registers, for now set to 0
	 HexDriver        HexAU (
                        .In0(Aval[7:4]),    //4 most significant bits for upper hex driver (A)
                        .Out0(AhexU) );	
	 HexDriver        HexBU (
                       .In0(Bval[7:4]),     //4 most significant bits for upper hex driver (B)
                        .Out0(BhexU) );

//sync button_sync[3:0] (Clk, {~Reset, ~ClearA_LoadB, ~Run}, {Reset_SH, ClearA_LoadB_SH, Run_SH});
//sync S_sync[7:0] (Clk, S, S_S);/// is s Sin???? aka what goes into the reg unit(Clk, Din, Din_S); 
	  // or is it Din????? aka
	  //sync Din_sync[7:0] (Clk, Din, Din_S);



/*

//clr_ld goes into clear of SR, btw should change that to clear not reset, actually... i think reset is only for fsm, clear is for reg.
//shift goes to shift enable
//confused about how add/ sub interact with adder bc add/sub depends on state for me obviously affecting x but i don't think it'll be right
always_ff @(posedge Clk)
begin
if (Clr_Ld)//clear state
begin
Aval[7:0]=8'b0;
Bval[7:0]=S[7:0];
end
else
begin
Aval[7:0]=S[7:0];
end
end
//register_unit (.Clk(Clk), .LoadA(Aval), .ClrA_LoadB(ClearA_LoadB),.Data(Aval), .S(S[7:0]),.x(X), .Shift(Shift), .XAB({X,Aval,Bval}));

*/

endmodule 
