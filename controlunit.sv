module controlunit 

(
input Clk, Reset, Run, ClearA_LoadB,
input logic m,
input logic m0,
output logic Clr_Ld, ClrA, Shift, Add, Sub//,
//output logic [4:0] state
);


// declare signals curr_state, next_state of type enum
// with enum values of A, B, ..., Q as the state values

enum logic [4:0] {A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U} curr_state, next_state;

//A = Reset, B= Clearing, C=Do nothing (after clear is turned off before run), D-K (shifting), L-> Halt (finished shifting, run=1)

always_ff @ (posedge Clk)

begin
if (Reset) // Asynchronous Reset
curr_state <= A; // A is the reset/start state
else
curr_state <= next_state;
end

// This is the next state logic
always_comb
begin
//next_state = curr_state; //should never happen
unique case (curr_state)

A : if (ClearA_LoadB) //run=1
next_state = B;
else
next_state=A;

B : if(ClearA_LoadB)
next_state=B; //if clearing stay clearing
else
next_state=C;

C : if(Run) //do nothing unless run
		begin
			if(m0) next_state = D;
			else next_state = E;
		end

    else next_state = C;

D : next_state = E;

E : if(m) next_state = F;
	 else next_state = G;

F : next_state = G;

G : if(m) next_state = H;
	 else next_state = I;

H : next_state = I;

I : if(m) next_state = J;
	 else next_state = K;

J : next_state = K;

K : if(m) next_state = L;
	 else next_state = M;

L : next_state = M;

M : if(m) next_state = N;
	 else next_state = O;
	 
N : next_state = O;
	 
O : if(m) next_state = P;
	 else next_state = Q;

P : next_state = Q;

Q : if(m) next_state = R;
	 else next_state = S;

R : next_state = S;

S : next_state = T;

T : if(Run) next_state = T;
    else next_state = U;

U : next_state = C;
	 
endcase
end

// Assign outputs based on ‘state’
always_comb
begin
case (curr_state)
A:
begin
Clr_Ld=1'b0;
Add=1'b0;
Sub=1'b0;
Shift = 1'b0;
ClrA = 1'b0;
//state = 5'b00001;

end
B:
	begin
	Clr_Ld=1'b1;
	Add=1'b0;
	Sub=1'b0;
	Shift = 1'b0;
	ClrA = 1'b0;
	//state=5'b00010;
	end
C:
	begin
	Clr_Ld=1'b0;
	Add=1'b0;
	Sub=1'b0;
	Shift = 1'b0;
	ClrA = 1'b0;
	//state=5'b00011;
	end

D, F, H, J, L, N, P:
   begin
	Clr_Ld=0;
	Add=1;
	Sub=0;
	Shift=0;
	ClrA = 1'b0;
	//state=5'b11111;
	end
   
R:
	begin
	Clr_Ld=0;
	Add=0;
	Sub=1;
	Shift=0;
	ClrA = 1'b0;
	//state=5'b11111;
	end
	
T:
	begin
	Clr_Ld=1'b0;
	Add=1'b0;
	Sub=1'b0;
	Shift = 1'b0;
	ClrA = 1'b0;
	//state=5'b10000;
	//display on hex or is that in the top level?????
	end

U:
	begin
	Clr_Ld=0;
	Add=0;
	Sub=0;
	Shift=0;
	ClrA = 1'b1;
	//state = 5'b01111;
	end
	
default:
	
	begin
		Clr_Ld=0;
		Add=0;
		Sub=0;
		Shift=1;
		ClrA = 1'b0;
		//state=5'b00000;
	end
	
 endcase
end
endmodule
