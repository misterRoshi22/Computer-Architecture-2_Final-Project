module immediate_gen(instruction, immediate);
   input [31:0] instruction;
	
   output [31:0] immediate;
	
   reg[31:0] IMM_OUT;
   wire[6:0] OpCode;

   assign immediate = IMM_OUT;
	
   assign OpCode = instruction[6:0];
	
   always @(*)  begin
	
   case(OpCode)
        7'h1b: IMM_OUT <= { {21{instruction[31]}}, instruction[30:25], instruction[24:20]};   													// ADDI     -> I-Type
        7'h13: IMM_OUT <= { {21{instruction[31]}}, instruction[30:25], instruction[24:20]};														// ORI/ANDI -> I-Type
		  7'h03: IMM_OUT <= { {21{instruction[31]}}, instruction[30:25], instruction[24:20]};														// LW/LB		-> I-Type
		  
		  7'h23: IMM_OUT <= { {21{instruction[31]}}, instruction[30:25], instruction[11:7]};     													// SW/SB    -> S-Type
        7'h38: IMM_OUT <= { instruction[31], instruction[30:12], {12{1'b0}} };             														// LUI	   -> U-Type
           												
        7'h6F: IMM_OUT <= { {12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], {1{1'b0}}};  				// JAL 		-> UJ-Type
        7'h63: IMM_OUT <= { {20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], {1{1'b0}}};  					// BEQ/BNE	-> SB-Type
		  
        default: IMM_OUT <= 32'b0;
    endcase
	end

endmodule //immediate_gen