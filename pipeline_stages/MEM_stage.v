module MEM_stage(clk, reset_n,
MemRead_EXE, MemWrite_EXE,
ALU_Result_EXE_MEM, write_data_EXE_MEM,
MemtoReg_EXE_MEM, RegWrite_EXE_MEM, rd_EXE_MEM, 
pc_EXE_MEM, read_data_MEM_WB, ALU_Result_MEM_WB, 
MemtoReg_MEM_WB, RegWrite_MEM_WB, write_reg_MEM_WB, pc_MEM_WB
);

	input clk, reset_n;
	
	//Used in the MEM stage to access the memory
	input [3:0] MemRead_EXE, MemWrite_EXE; 
	
	input [31:0] ALU_Result_EXE_MEM;
	input [31:0] write_data_EXE_MEM;
	
	//Sent to the WB stage
	input [1:0] MemtoReg_EXE_MEM;
	input RegWrite_EXE_MEM;
	input [4:0] rd_EXE_MEM;
	input [14:0] pc_EXE_MEM;
	
	
	//Sent to WB stage
	output [31:0] read_data_MEM_WB;
	output [31:0] ALU_Result_MEM_WB;
	output [1:0] MemtoReg_MEM_WB;
	output RegWrite_MEM_WB;
	output [4:0] write_reg_MEM_WB;
	
	//Sign extended PC value used to write PC ontor R[rd] in case of JAL or JALR 
	output [31:0] pc_MEM_WB;
	
	//Lower 11 bits of ALU_Result used to access memory
	wire [10:0] address;
	
	//Data memory accessed in the memory stage for read/write operations
	data_memory RAM(clk, reset_n, address,
	MemWrite_EXE, MemRead_EXE, write_data_EXE_MEM, read_data_MEM_WB);
	
	
	assign address = ALU_Result_EXE_MEM[10:0];
	assign ALU_Result_MEM_WB = ALU_Result_EXE_MEM;
	assign write_reg_MEM_WB = rd_EXE_MEM;
	assign RegWrite_MEM_WB = RegWrite_EXE_MEM;
	assign MemtoReg_MEM_WB = MemtoReg_EXE_MEM;
	assign pc_MEM_WB = {{17{1'b0}}, pc_EXE_MEM} + 3'b100;
	



endmodule //MEM_stage
