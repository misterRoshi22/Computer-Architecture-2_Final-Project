module tb_comparator;

	reg [31:0] A, B;
	reg BEQ, BNE;
	
	wire branch;
	
	comparator uut(
	.A(A),
	.B(B),
	.BEQ(BEQ),
	.BNE(BNE),
	.branch(branch)
	);
	
	
	 initial begin
		 A = 32'd5;
		 B = 32'd5;
		 BEQ = 0;
		 BNE = 0;
		 #10;
		 
		 BEQ = 1;
		 #10;
		 
		 BEQ = 0;
		 BNE = 1;
		 #10;
		 
		 B = 32'd4;
		 #10;
		 
		 BNE = 0;
		 BEQ = 1;
		 #0;
	 $finish;
	 end
	 
	 
	
	

endmodule //tb_comparator