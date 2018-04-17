module carry_select_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a carry select.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
     
logic c4, c8, c12;  //carries between layers of four-bit adder units (for select), cout becomes cin for next block
four_bit_adder FBA0(.X(A[3:0]),.Y(B[3:0]),.Cin(0),.S(Sum[3:0]),.Cout(c4)); //0th group of 4 bits-> only requires one full adder
select_adderpair SA1 (.x(A[7:4]),.y(B[7:4]),.cin(c4),.s(Sum[7:4]),.cout(c8)); //1st group of 4 bits [bits 7:4]
select_adderpair SA2 (.x(A[11:8]),.y(B[11:8]),.cin(c8),.s(Sum[11:8]),.cout(c12)); // bits [11:8]
select_adderpair SA3 (.x(A[15:12]),.y(B[15:12]),.cin(c12),.s(Sum[15:12]),.cout(CO)); //bits [15:12]
    
endmodule



module select_adderpair //2 full adders, 1 with carryin 0, 1 with carryin 1
(
    input [3:0] x, //first input
    input [3:0]y, //second input bit
    input cin,
    output logic cout,
    output logic [3:0]s

);
    logic [3:0]s0; //sum of bits for 0 cin
    logic [3:0] s1; //sum of bits for 1 cin
    logic cout0; //cout for 0 cin
    logic cout1; //cout for 1 cin

    four_bit_adder FBA0(.X(x[3:0]),.Y(y[3:0]),.Cin(0),.S(s0[3:0]),.Cout(cout0)); //instantiation of 4 bit adder, cin=0
    four_bit_adder FBA1(.X(x[3:0]),.Y(y[3:0]),.Cin(1),.S(s1[3:0]),.Cout(cout1)); //instantiation of 4 bit adder, cin=1
    
    always_comb
    begin
    //logic for pair

    cout=cout0|(cout1&cin); //new cout
    if(cin==1)
        s[3:0]=s1[3:0]; 
    else
        s[3:0]=s0[3:0];
    end
    
   endmodule


