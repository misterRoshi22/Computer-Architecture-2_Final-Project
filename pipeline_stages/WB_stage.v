module WB_stage(clk, reset_n, 
read_data_MEM_WB, ALU_Result_MEM_WB, 
MemtoReg_MEM_WB, RegWrite_MEM_WB,
write_reg_MEM_WB, pc_MEM_WB,
RegWrite_ID, write_reg_ID, write_data_ID);
	
	input clk, reset_n;
	
	input [31:0] read_data_MEM_WB;
	input [31:0] ALU_Result_MEM_WB;
	input [1:0] MemtoReg_MEM_WB;
	input RegWrite_MEM_WB;
	input [4:0] write_reg_MEM_WB;
	input [31:0] pc_MEM_WB;
	
	
	output RegWrite_ID;
	output [4:0] write_reg_ID;
	output [31:0] write_data_ID;
	
	
	mux_4to1 WB_mux(ALU_Result_MEM_WB, read_data_MEM_WB, pc_MEM_WB, ,MemtoReg_MEM_WB, write_data_ID);
	
	assign write_reg_ID = write_reg_MEM_WB;
	assign RegWrite_ID = RegWrite_MEM_WB;
	

endmodule //WB_stage
