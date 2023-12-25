module ID_EXE_REG(clk, reset_n, flush,  ID_EXE_REG_Write, 
read_data1_ID, read_data2_ID, immediate_ID,
JAL_ID, JALR_ID, MemRead_ID, MemWrite_ID, ALUOp_ID,
MemtoReg_ID, ALUSrc_ID, RegWrite_ID, branch_ID,
branch_address_ID, jalr_address_ID, pc_ID, 
rs1_ID, rs2_ID, rd_ID, OPCODE_EXE,
read_data1_EXE, read_data2_EXE, immediate_EXE,
JAL_EXE, JALR_EXE, MemRead_EXE, MemWrite_EXE, ALUOp_EXE,
MemtoReg_EXE, ALUSrc_EXE, RegWrite_EXE, branch_EXE,
branch_address_EXE, jalr_address_EXE, pc_EXE,
rs1_EXE, rs2_EXE, rd_EXE, OPCODE_FRWRD
);

	//Universal Inputs
	input clk, reset_n;
	
	//Control Signals
	input flush, ID_EXE_REG_Write;

	//Inputs from ID stage 
	input [31:0] read_data1_ID, read_data2_ID;
	input [31:0] immediate_ID;
	input JAL_ID, JALR_ID;
	input [3:0] MemRead_ID, MemWrite_ID;
	input [3:0] ALUOp_ID;
	input [1:0] MemtoReg_ID;
	input ALUSrc_ID, RegWrite_ID; 
	input branch_ID;
	input [14:0] branch_address_ID; 
	input [14:0] jalr_address_ID;
	input [14:0] pc_ID;
	input [4:0] rs1_ID, rs2_ID, rd_ID;
	input [6:0] OPCODE_EXE;
	
	//Outputs sent to the EXE stage
	output reg [31:0] read_data1_EXE, read_data2_EXE;
	output reg [31:0] immediate_EXE;
	output reg JAL_EXE, JALR_EXE;
	output reg [3:0] MemRead_EXE, MemWrite_EXE;
	output reg [3:0] ALUOp_EXE;
	output reg [1:0] MemtoReg_EXE;
	output reg ALUSrc_EXE, RegWrite_EXE; 
	output reg branch_EXE;
	output reg [14:0] branch_address_EXE;
	output reg [14:0] jalr_address_EXE;
	output reg [14:0] pc_EXE;
	output reg [4:0] rs1_EXE, rs2_EXE, rd_EXE;
	output reg [6:0] OPCODE_FRWRD;
	
	always @(posedge clk) begin
		 if (reset_n || flush) begin			  
			  read_data1_EXE <= 0;
			  read_data2_EXE <= 0;
			  immediate_EXE <= 0;
			  JAL_EXE <= 0;
			  JALR_EXE <= 0;
			  MemRead_EXE <= 0;
			  MemWrite_EXE <= 0;
			  ALUOp_EXE <= 0;
			  MemtoReg_EXE <= 0;
			  ALUSrc_EXE <= 0;
			  RegWrite_EXE <= 0;
			  branch_EXE <= 0;
			  branch_address_EXE <= 0;
			  jalr_address_EXE <= 0;
			  pc_EXE <= 0;
			  rs1_EXE <= 0;
			  rs2_EXE <= 0;
			  rd_EXE <= 0;
			  OPCODE_FRWRD <= 0;
		 end
		 
		 else if (ID_EXE_REG_Write) begin
			  read_data1_EXE <= read_data1_ID;
			  read_data2_EXE <= read_data2_ID;
			  immediate_EXE <= immediate_ID;
			  JAL_EXE <= JAL_ID;
			  JALR_EXE <= JALR_ID;
			  MemRead_EXE <= MemRead_ID;
			  MemWrite_EXE <= MemWrite_ID;
			  ALUOp_EXE <= ALUOp_ID;
			  MemtoReg_EXE <= MemtoReg_ID;
			  ALUSrc_EXE <= ALUSrc_ID;
			  RegWrite_EXE <= RegWrite_ID;
			  branch_EXE <= branch_ID;
			  branch_address_EXE <= branch_address_ID;
			  jalr_address_EXE <= jalr_address_ID;
			  pc_EXE <= pc_ID;
			  rs1_EXE <= rs1_ID;
			  rs2_EXE <= rs2_ID;
			  rd_EXE <= rd_ID;
			  OPCODE_FRWRD <= OPCODE_EXE;
		 end
	end

endmodule //ID_EXE_REG
