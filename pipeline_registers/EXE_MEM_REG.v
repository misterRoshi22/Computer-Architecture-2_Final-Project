module EXE_MEM_REG(
	clk, reset_n,
	flush, EXE_MEM_REG_Write,
	MemRead_EXE, MemWrite_EXE,
	MemtoReg_EXE, RegWrite_EXE,
	rd_EXE, pc_EXE,
	ALU_Result_EXE, write_data_EXE,
	MemRead_MEM, MemWrite_MEM,
	MemtoReg_MEM, RegWrite_MEM,
	rd_MEM, pc_MEM,
	ALU_Result_MEM, write_data_MEM
);

	input clk, reset_n;
	input flush, EXE_MEM_REG_Write;
	
	//Sent to the MEM stage
	input [3:0] MemRead_EXE, MemWrite_EXE; 
	
	//Sent to the WB stage
	input [1:0] MemtoReg_EXE;
	input RegWrite_EXE;
	input [4:0] rd_EXE;
	input [14:0] pc_EXE;
	
	//Sent to the EXE_MEM_REG
	input [31:0] ALU_Result_EXE;
	input [31:0] write_data_EXE;
	
	//Sent to the MEM stage
	output reg [3:0] MemRead_MEM, MemWrite_MEM; 
	
	//Sent to the WB stage
	output reg [1:0] MemtoReg_MEM;
	output reg RegWrite_MEM;
	output reg [4:0] rd_MEM;
	output reg [14:0] pc_MEM;
	
	//Sent to the EXE_MEM_REG
	output reg [31:0] ALU_Result_MEM;
	output reg [31:0] write_data_MEM;
	
	always @(posedge clk) begin
		if (reset_n || flush) begin
			MemRead_MEM <= 0;
			MemWrite_MEM <= 0;
			MemtoReg_MEM <= 0;
			RegWrite_MEM <= 0;
			rd_MEM <= 0;
			pc_MEM <= 0;
			ALU_Result_MEM <= 0;
			write_data_MEM <= 0;
		end 
		
		else if (EXE_MEM_REG_Write) begin
			MemRead_MEM <= MemRead_EXE;
			MemWrite_MEM <= MemWrite_EXE;
			MemtoReg_MEM <= MemtoReg_EXE;
			RegWrite_MEM <= RegWrite_EXE;
			rd_MEM <= rd_EXE;
			pc_MEM <= pc_EXE;
			ALU_Result_MEM <= ALU_Result_EXE;
			write_data_MEM <= write_data_EXE;
		end
	end
	
endmodule // EXE_MEM_REG
	
	
