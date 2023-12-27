module mux_4to1(A, B, C, D,  S, M);

	 parameter AB_width = 32;
    input  [AB_width-1:0] A, C;
    input  [AB_width-1:0] B, D;
    input  [1:0] S;
    output [AB_width-1:0] M;
	 
	 assign M =  S[1] ? (S[0] ? D : C) : (S[0] ? B : A);

endmodule //mux_4to1
