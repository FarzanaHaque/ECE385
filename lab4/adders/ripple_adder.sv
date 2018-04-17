module ripple_adder
(
    input   logic[15:0]     A,   //uses hierarchical design. Combines four four-bit adders
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

logic c0, c1, c2;  //carries between four-bit adder units

four_bit_adder FBA0(.X(A[3:0]),.Y(B[3:0]),.Cin(0),.S(Sum[3:0]),.Cout(c0)); //instantiation of four 4-bit adder units
four_bit_adder FBA1(.X(A[7:4]),.Y(B[7:4]),.Cin(c0),.S(Sum[7:4]),.Cout(c1));
four_bit_adder FBA2(.X(A[11:8]),.Y(B[11:8]),.Cin(c1),.S(Sum[11:8]),.Cout(c2));
four_bit_adder FBA3(.X(A[15:12]),.Y(B[15:12]),.Cin(c2),.S(Sum[15:12]),.Cout(CO));

endmodule

module full_adder
(
    input x, //first input bit
    input y, //second input bit
    input cin,
    output logic s, //sum of bits
    output logic cout
);

    always_comb
    begin
    //logic for basic full adder units
    s = x^y^cin;
    cout = (x&y)|(y&cin)|(x&cin);
    
    end
endmodule


module four_bit_adder   //combines four full adder units
(
    input [3:0] X,
    input    [3:0] Y,
    input Cin,
    output logic [3:0] S,
    output logic Cout
);

    logic c0, c1, c2; //local variables for carries between full adder units
    full_adder FA0(.x(X[0]),.y(Y[0]),.cin(Cin),.s(S[0]),.cout(c0)); //instantiation of four full adder units
    full_adder FA1(.x(X[1]),.y(Y[1]),.cin(c0),.s(S[1]),.cout(c1));
    full_adder FA2(.x(X[2]),.y(Y[2]),.cin(c1),.s(S[2]),.cout(c2));
    full_adder FA3(.x(X[3]),.y(Y[3]),.cin(c2),.s(S[3]),.cout(Cout));

endmodule
