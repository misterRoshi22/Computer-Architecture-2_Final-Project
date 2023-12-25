module control_unit(OPCODE, FUNCT3, control_MUX_select, BEQ, BNE, JAL, JALR, MemRead,
MemWrite, ALUOp, MemtoReg, ALUSrc, RegWrite);

	input [6:0] OPCODE;
	input [2:0] FUNCT3;
	input control_MUX_select; // Input from Hazard Detection Unit used for stalling

	output reg BEQ;
	output reg BNE;
	output reg JAL;
	output reg JALR;
	output reg [3:0] MemRead;
	output reg [3:0] MemWrite;
	output reg [3:0] ALUOp;
	output reg [1:0] MemtoReg;
	output reg ALUSrc;
	output reg RegWrite;
	
	
	always @(OPCODE or FUNCT3 or control_MUX_select) begin
		{RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, ALUOp, BEQ, BNE, JAL, JALR} <= 0; //By Default all Control Signals are equal to zero
			
		case (OPCODE)
			7'h33: begin	//ADD AND XOR OR SLL SRL SUB STL
				RegWrite <= 1;
				
				case(FUNCT3) 
				
					3'h6: begin //ADD
						ALUOp <= 4'b0010;
					end
					
					3'h5: begin //AND
						ALUOp <= 4'b0000;
					end
					
					3'h7: begin //XOR
						ALUOp <= 4'b0011;
					end
					
					3'h3: begin //OR
						ALUOp <= 4'b0001;
					end
					
					3'h4: begin //STL
						ALUOp <= 4'b1000;
					end
					
					3'h2: begin //SLL
						ALUOp <= 4'b0100;
					end
					
					3'h0: begin //SRL
						ALUOp <= 4'b0101;
					end
					
					3'h1: begin //SUB
						ALUOp <= 4'b0110;
					end
					
				endcase
				
			end
			
			7'h1b: begin	//ADDI
				ALUOp <= 4'b0010;
				ALUSrc <= 1;
				RegWrite <= 1;
			end
			
			7'h13: begin
			
				case(FUNCT3)
					3'h6:	begin	//ANDI
						ALUOp <= 4'b0000;
						ALUSrc <= 1;
						RegWrite <= 1;
					end
					
					3'h7: begin	//ORI
						ALUOp <= 4'b0001;
						ALUSrc <= 1;
						RegWrite <= 1;
					end				
					
				endcase
			end
			
			7'h63: begin
			
				case(FUNCT3)
					3'h1: begin //BEQ
						BEQ <= 1;
						ALUOp <= 4'b0110;
					end
					
					3'h0: begin //BNE
						BNE <= 1;
						ALUOp <= 4'b0110;
					end
					
				endcase
			end
			
			7'h03: begin
			
				case(FUNCT3)
					3'h0: begin //LW
						MemRead <= 4'b1111;
						MemtoReg <= 2'b01;
						RegWrite <= 1;
						ALUOp <= 4'b0010;
						ALUSrc <= 1;
					end
					
					3'h2: begin //LB
						MemRead <= 4'b0001;
						MemtoReg <= 2'b01;
						RegWrite <= 1;
						ALUOp <= 4'b0010;
						ALUSrc <= 1;
					end
					
				endcase
			end
			
			
			
			7'h23: begin
			
				case(FUNCT3)
					3'h0: begin //SW
						MemWrite <= 4'b1111;
						ALUSrc <= 1;
						ALUOp <= 4'b0010;
					end
					
					3'h2: begin //SB
						MemWrite <= 4'b0001;
						ALUSrc <=1;
						ALUOp <= 4'b0010;
					end
					
				endcase
			end
			
			7'h6F: begin //JAL
				JAL <= 1;
				MemtoReg <= 2'b10;
				RegWrite <= 1;
			end
			
			7'h67: begin //JALR 
				JALR <= 1;
				MemtoReg <= 2'b10;
				RegWrite <= 1;
			end
			
			7'h38: begin //LUI
				RegWrite <= 1;
				ALUOp <= 4'b0111;
				ALUSrc <= 1;
				RegWrite <= 1;
			end		
			
			
		endcase
		
		if(control_MUX_select) begin 
			{RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, ALUOp, BEQ, BNE, JAL, JALR} <= 0;
		end
		

	end	
	

	
	
	
	
	
	


endmodule //control_unit
