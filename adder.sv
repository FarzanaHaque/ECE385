module adder
(
input[7:0] A,
input[7:0] S,
input fn,
output logic [8:0] Sum
);

logic CIN;
logic c3, c7, c8;
logic[7:0] newS;


always_comb
begin

if(!fn) begin   
CIN = 0;
newS=S;
end


else begin
CIN = 1;
newS = (S^(8'hFF));
end


end

four_bit_adder FBA0(.X(A[3:0]),.Y(newS[3:0]),.Cin(CIN),.sum(Sum[3:0]),.Cout(c3));
four_bit_adder FBA1(.X(A[7:4]),.Y(newS[7:4]),.Cin(c3),.sum(Sum[7:4]),.Cout(c7));
full_adder FA(.x(A[7]),.y(newS[7]),.cin(c7),.s(Sum[8]),.cout(c8));

endmodule




module four_bit_adder   //combines four full adder units
(
	input [3:0] X,
	input	[3:0] Y,
	input Cin,
	output logic [3:0] sum,
	output logic Cout
);

	logic c0, c1, c2; //local variables for carries between full adder units
	full_adder FA0(.x(X[0]),.y(Y[0]),.cin(Cin),.s(sum[0]),.cout(c0)); //instantiation of four full adder units
	full_adder FA1(.x(X[1]),.y(Y[1]),.cin(c0),.s(sum[1]),.cout(c1));
	full_adder FA2(.x(X[2]),.y(Y[2]),.cin(c1),.s(sum[2]),.cout(c2));
	full_adder FA3(.x(X[3]),.y(Y[3]),.cin(c2),.s(sum[3]),.cout(Cout));

endmodule







module full_adder
(
input x,
input y,
input cin,
output logic s,
output logic cout
);

always_comb
	begin
	//logic for basic full adder units
	s = x^y^cin;
	cout = (x&y)|(y&cin)|(x&cin);
	
	end
endmodule

