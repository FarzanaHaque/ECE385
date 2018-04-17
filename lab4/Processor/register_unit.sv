module register_unit (input  logic Clk, Reset, A_In, B_In, Ld_A, Ld_B, 
                            Shift_En,
                      input  logic [7:0]  D,     //Parallel inputs extended to 8 bits
                      output logic A_out, B_out, 
                      output logic [7:0]  A,      //Parallel outputs extended to 8 bits
                      output logic [7:0]  B);


    reg_4  reg_A (.*, .Shift_In(A_In), .Load(Ld_A),
                   .Shift_Out(A_out), .Data_Out(A));
    reg_4  reg_B (.*, .Shift_In(B_In), .Load(Ld_B),
                   .Shift_Out(B_out), .Data_Out(B));

endmodule
