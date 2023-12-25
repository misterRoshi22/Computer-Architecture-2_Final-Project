module exception_handler(pc, OPCODE, branch_address, 
MemRead_EXE, MemWrite_EXE, ALUOp_EXE, exception, sepc, scause);

	input [14:0] pc;
	input [6:0] OPCODE;
	input [14:0] branch_address;
	input [3:0] MemRead_EXE, MemWrite_EXE;
	input [3:0] ALUOp_EXE;
	
	
	reg [14:0] SEPC;
	reg [63:0] SCAUSE;
	reg EXCEPTION;
	
	output exception;
	
	output [14:0] sepc;
	output [63:0] scause;
	
	always@(*) begin
	{SEPC, SCAUSE, EXCEPTION} <= 0;
	
		if(MemRead_EXE != 4'b0001 && MemRead_EXE != 4'b1111 && MemRead_EXE != 4'b0000) begin
			SEPC <= pc;
			SCAUSE <= {3'b000, 57'b0, MemRead_EXE};
			EXCEPTION <= 1;
		end
		
		else if(MemWrite_EXE != 4'b0001 && MemWrite_EXE != 4'b1111 && MemWrite_EXE != 4'b0000) begin
			SEPC <= pc;
			SCAUSE <= {3'b001, 57'b0, MemWrite_EXE};
			EXCEPTION <= 1;
		end
		
		else if(ALUOp_EXE > 4'b1000) begin
			SEPC <= pc;
			SCAUSE <= {3'b010, 57'b0, ALUOp_EXE};
			EXCEPTION <= 1;
		end
		
		else if(branch_address > 15'h2000) begin
			SEPC <= pc;
			SCAUSE <= {3'b011, 46'b0, branch_address};
			EXCEPTION <= 1;
		end
		
//		else if(OPCODE != 7'h33 && OPCODE != 7'h13 && OPCODE != 7'h1b && OPCODE != 7'h63
//			&& OPCODE != 7'h6F && OPCODE != 7'h67 && OPCODE != 7'h03 && OPCODE != 7'h38
//			&& OPCODE != 7'h23) begin
//			SEPC <= pc;
//			SCAUSE <= {3'b100, 54'b0, OPCODE};
//			EXCEPTION <= 1;
//		end
	end
	
	assign scause = SCAUSE;
	assign sepc = SEPC;
	assign exception = EXCEPTION;
	
endmodule //exception_handler
