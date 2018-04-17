module register_unit 
(
input logic Clk, 
input logic LoadA,
input logic ClrA_LoadB,
input logic [7:0] Data, //parallel input for a. 8 least significant bits of adder
input logic [7:0] S,
input logic x, //either msb of adder, or sign ext. Upper level will determine //.
input logic Shift,
input logic ClrA,
output logic [7:0] A_out,
output logic [7:0] B_out,
output logic X_out,
output logic M,
output logic shift_out
);

//Treat XAB as a unit. LoadA will load sum from adder into register A. ClrA_LoadB will load values from switches into register B and clear registerA. Shift will shift
//all values in XAB to the right. The new value of X will simply be sign extended. 
logic A_serial_output;
logic dontcare;
logic clearAs;
assign clearAs=ClrA_LoadB | ClrA;
flip_flop X(.Clk(Clk),.Clr(clearAs),.D(x),.Load_FF(LoadA),.Q(X_out));
shift_register A(.Clk(Clk),.Clr(clearAs),.Shift_In(X_out),.Load(LoadA),.Shift_En(Shift),.D(Data[7:0]),.Shift_Out(A_serial_output),.Data_Out(A_out),.M(dontcare));
shift_register B(.Clk(Clk),.Clr(1'b0),.Shift_In(A_serial_output),.Load(ClrA_LoadB),.Shift_En(Shift),.D(S[7:0]),.Shift_Out(shift_out),.Data_Out(B_out),.M(M));

endmodule










module shift_register (input  logic Clk, Clr, Shift_In, Load, Shift_En,
              input  logic [7:0]  D,    //Extended Parallel Input to 8 bits
				  output logic M,
              output logic Shift_Out,
              output logic [7:0]  Data_Out); //Extended Parallel Output to 8 bits
 
    always_ff @ (posedge Clk)
    begin
	 	 if (Clr) //notice, this is a sycnrhonous reset, which is recommended on the FPGA
			  Data_Out <= 8'h00; //reset output of x00
		 else if (Load)
			  Data_Out <= D; 
		 else if (Shift_En)
		 begin
			  //concatenate shifted in data to the previous left-most 3 bits
			  //note this works because we are in always_ff procedure block
			  Data_Out <= { Shift_In, Data_Out[7:1] };    //New data is concatenated with 7 most significant bits of old data 
	    end
    end
	
    assign Shift_Out = Data_Out[0];
	 assign M = Data_Out[1];
	 

endmodule


module flip_flop
(
input Clk,
input Clr,
input D,
input Load_FF,
output logic Q
);

always_ff @ (posedge Clk)
    begin
	 	 if (Clr) 
			  Q <= 0;
		 else if (Load_FF)
			  Q <= D;
		 else 
			  Q <= Q;
	 end

endmodule
