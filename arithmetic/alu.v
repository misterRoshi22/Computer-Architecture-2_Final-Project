module alu(A, B, ALU_Result, ALUOpCode, Zero);
 
	
	input 		[31:0] 	A, B; 					// Operands
	input 		[3:0]		ALUOpCode;				// Operation
	
	output reg	[31:0] 	ALU_Result; 			// Result
	output reg 				Zero; 					// Zero flag

	always @ (ALUOpCode or A or B)
	begin
	
	Zero = 0; //By default Zero Flag is equal to 0
		
	
		case(ALUOpCode)
		
			4'h3: // XOR
			ALU_Result = A ^ B;
			
			4'h2:	// ADD
			ALU_Result = $signed(A) + $signed(B);
			
			4'h0:	// AND
			ALU_Result = A & B;
			
			4'h1:	// OR
			ALU_Result = A | B;
			
			4'h5:	// SRL - Shift Right Logical >>
			ALU_Result = (A >> B);
			
			4'h6: // SUB
			ALU_Result = $signed(A) - $signed(B);
			
			4'h4:	// SLL - Shift Left Logical >>
			ALU_Result = (A << B);
		
			4'h7: // LUI - Load Upper Immediate
			ALU_Result = B;
			
			4'h8:	// SLT - Set on Less Than 
			ALU_Result = (A < B) ? 1 : 0;
			
		
		endcase
		

		if (ALU_Result == 32'b0)  //If result is equal to zero zero flag is equal to 1
			Zero = 1;
	
	end

endmodule //alu
