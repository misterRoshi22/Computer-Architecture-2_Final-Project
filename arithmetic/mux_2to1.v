module mux_2to1 (A, B, S, M);

	 parameter AB_width = 32;
    input  [AB_width-1:0] A;
    input  [AB_width-1:0] B;
    input  S;
    output [AB_width-1:0] M;
	 
	 assign M =  S ? B : A;

endmodule // mux_2to1
