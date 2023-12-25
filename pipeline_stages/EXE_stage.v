module EXE_stage(
    clk, reset_n,
    read_data1_ID_EXE, read_data2_ID_EXE, immediate_ID_EXE,
    ALUSrc_ID_EXE, ALUOp_ID_EXE,
    MemRead_ID_EXE, MemWrite_ID_EXE,
    MemtoReg_ID_EXE, RegWrite_ID_EXE,
    rd_ID_EXE, pc_ID_EXE,
    ForwardA_FRWD, ForwardB_FRWD,
    ALU_Result_MEM_WB, ALU_Result_EX_MEM,
    MemRead_EXE_MEM, MemWrite_EXE_MEM,
    MemtoReg_EXE_MEM, RegWrite_EXE_MEM,
    rd_EXE_MEM, pc_EXE_MEM,
    ALU_Result_EXE_MEM, write_data_EXE_MEM
);


	//Universal Inputs
	input clk, reset_n;
	
	//Used in the EXE stage (inputs to the Forwarding MUXs) in case bypassing is necessary
	input [31:0] read_data1_ID_EXE, read_data2_ID_EXE;
	input [31:0] immediate_ID_EXE;
	
	//Used in the EXE stage (input to the ALUSrc MUX) to choose if ALU_B[0] is immediate or read_data2
	input ALUSrc_ID_EXE;
	input [3:0] ALUOp_ID_EXE;	
	
	//Sent to the MEM stage
	input [3:0] MemRead_ID_EXE, MemWrite_ID_EXE; 
	
	//Sent to the WB stage
	input [1:0] MemtoReg_ID_EXE;
	input RegWrite_ID_EXE;
	input[4:0] rd_ID_EXE;
	input [14:0] pc_ID_EXE;
	
	//Inputs to the Forwarding MUX sent from the Forwarding Unit
	input [1:0] ForwardA_FRWD, ForwardB_FRWD;
	
	//Inputs from Stage Registers used for forwarding
	input [31:0] ALU_Result_MEM_WB, ALU_Result_EX_MEM;
	
	//Sent to the MEM stage
	output [3:0] MemRead_EXE_MEM, MemWrite_EXE_MEM; 
	
	//Sent to the WB stage
	output [1:0] MemtoReg_EXE_MEM;
	output RegWrite_EXE_MEM;
	output [4:0] rd_EXE_MEM;
	output [14:0] pc_EXE_MEM;
	
	//Sent to the EXE_MEM_REG
	output [31:0] ALU_Result_EXE_MEM;
	output [31:0] write_data_EXE_MEM;

	//Signals relating to the ALU
	wire [31:0] A, B;
	wire [31:0] ALU_B0;
	wire [31:0] ALU_Result;
	wire Zero;
	
		
	// ALU performs arithmetic and logical operations for execution stage (EXE)
	alu alu(A, B, ALU_Result, ALUOp_ID_EXE, Zero);
	
	//Used to determine if ALU_B[0] is immediate or read_data2
	mux_2to1 ALUSrc_MUX(read_data2_ID_EXE, immediate_ID_EXE, ALUSrc_ID_EXE , ALU_B0);
	
	//Forwarding MUXs used to bypass result from previous EXE stage or previous MEM stage
	mux_4to1 ALU_A(read_data1_ID_EXE, ALU_Result_MEM_WB, ALU_Result_EX_MEM,,  ForwardA_FRWD, A);
	mux_4to1 ALU_B(ALU_B0, ALU_Result_MEM_WB, ALU_Result_EX_MEM,,  ForwardB_FRWD, B);
	
	
	assign MemRead_EXE_MEM = MemRead_ID_EXE;
	assign MemWrite_EXE_MEM = MemWrite_ID_EXE;
	assign MemtoReg_EXE_MEM = MemtoReg_ID_EXE;
	assign RegWrite_EXE_MEM = RegWrite_ID_EXE;
	assign rd_EXE_MEM = rd_ID_EXE;
	assign pc_EXE_MEM = pc_ID_EXE;
	assign ALU_Result_EXE_MEM = ALU_Result;
	assign write_data_EXE_MEM = read_data2_ID_EXE;

	

endmodule //EXE_stage
