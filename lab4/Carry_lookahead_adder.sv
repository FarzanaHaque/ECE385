module carry_lookahead_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    logic c4, c8, c12; //local variables for inputs/outputs of individual 4-bit lookahead adders
    logic Pg0, Pg1, Pg2, Pg3;
    logic Gg0, Gg1, Gg2, Gg3;
    
    four_bit_lookahead_adder FLA0(.X(A[3:0]),.Y(B[3:0]),.Cin(0),.S(Sum[3:0]),.Cout(c4),.Gg(Gg0),.Pg(Pg0)); //instantiate four 4-bit lookahead adders
    four_bit_lookahead_adder FLA1(.X(A[7:4]),.Y(B[7:4]),.Cin(c4),.S(Sum[7:4]),.Cout(c8),.Gg(Gg1),.Pg(Pg1));
    four_bit_lookahead_adder FLA2(.X(A[11:8]),.Y(B[11:8]),.Cin(c8),.S(Sum[11:8]),.Cout(c12),.Gg(Gg2),.Pg(Pg2));
    four_bit_lookahead_adder FLA3(.X(A[15:12]),.Y(B[15:12]),.Cin(c12),.S(Sum[15:12]),.Cout(CO),.Gg(Gg3),.Pg(Pg3));


    /* TODO
     *
     * Insert code here to implement a CLA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
     
endmodule

module lookahead_adder
(
    input x, //first input bit
    input y, //second input bit
    input cin,
    output logic s, //sum of bits
    output logic cout,
    output logic g, //generating
    output logic p //propagating
);

    always_comb
    begin
    //logic for basic full adder units
    s = x^y^cin;
    g = x&y;
    p = x^y;
    cout = g|(p&cin);
    
    end
   endmodule

module four_bit_lookahead_adder
(
    input [3:0] X,
    input [3:0] Y,
    input Cin,
    output logic [3:0] S,
    output logic Cout,
    output logic Gg, //generating group
    output logic Pg //propagation group
);

    logic c0, c1, c2; //local logic variables for carries within four bit adder
    logic g0, g1, g2, g3;
    logic p0, p1, p2, p3;
    
    lookahead_adder LA0(.x(X[0]),.y(Y[0]),.cin(Cin),.s(S[0]),.cout(c0),.g(g0),.p(p0));  //instantiate four unit adders
    lookahead_adder LA1(.x(X[1]),.y(Y[1]),.cin(c0),.s(S[1]),.cout(c1),.g(g1),.p(p1));
    lookahead_adder LA2(.x(X[2]),.y(Y[2]),.cin(c1),.s(S[2]),.cout(c2),.g(g2),.p(p2));
    lookahead_adder LA3(.x(X[3]),.y(Y[3]),.cin(c2),.s(S[3]),.cout(Cout),.g(g3),.p(p3));
    
    always_comb
    begin //perform logic to find Pg and Gg outputs
    
    Pg = (p0&p1&p2&p3);  
    Gg = (g3|(g2&p3)|(g1&p2&p3)|(g0&p1&p2&p3));
    
    end
    
endmodule
