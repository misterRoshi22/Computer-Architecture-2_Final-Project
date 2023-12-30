module forwarding_unit(EXE_MEM_rd, MEM_WB_rd, ID_EXE_rs1, ID_EXE_rs2,
EXE_MEM_RegWrite, MEM_WB_RegWrite, OPCODE,  ForwardA, ForwardB);
	
	input [4:0] EXE_MEM_rd, MEM_WB_rd;
	input [4:0] ID_EXE_rs1, ID_EXE_rs2;
	
	input EXE_MEM_RegWrite, MEM_WB_RegWrite;
	input [6:0] OPCODE;
	
	output[1:0] ForwardA, ForwardB;
	
	reg [1:0] FORWARDA, FORWARDB;
	
	assign ForwardA = FORWARDA;
	assign ForwardB = FORWARDB;
	
	always@(*) begin
	
		{FORWARDA, FORWARDB} <= 0; 
			
		if(EXE_MEM_RegWrite && (EXE_MEM_rd != 5'b0) && (EXE_MEM_rd == ID_EXE_rs1)) FORWARDA <= 2'b10; 						//A is from EXE Stage (ALU-ALU Forwarding)
		else if(MEM_WB_RegWrite && (MEM_WB_rd != 5'b0) && (MEM_WB_rd == ID_EXE_rs1)) FORWARDA <= 2'b01;						//A is from MEM Stage (MEM-ALU Forwarding)
		else FORWARDA <= 2'b00;															//A is from ID Stage (No Forwarding)
		
		if(OPCODE == 7'h1b || OPCODE == 7'h13 || OPCODE == 7'h03 || OPCODE == 7'h6f || OPCODE == 7'h67 || OPCODE == 7'h38 ) FORWARDB <= 2'b00; 	//IF there is no RS2
		else if(EXE_MEM_RegWrite && (EXE_MEM_rd != 5'b0) && (EXE_MEM_rd == ID_EXE_rs2)) FORWARDB <= 2'b10;					//B is from EXE Stage (ALU-ALU Forwarding)
		else if(MEM_WB_RegWrite && (MEM_WB_rd != 5'b0) && (MEM_WB_rd == ID_EXE_rs2)) FORWARDB <= 2'b01;						//B is from MEM Stage (MEM-ALU Forwarding)
		else FORWARDB <= 2'b00;															//B is from ID Stage (No Forwarding)
		
	end
	
	

	



endmodule //forwarding_unit
