module comparator(A, B, BEQ, BNE, branch);

	input [31:0] A, B;
	input BEQ, BNE;
	
	output branch;
	
	wire equal;
	
	assign equal = (A == B) ? 1 : 0;		
	assign branch = (equal && BEQ) || (!equal && BNE);



endmodule //comparator
