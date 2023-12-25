module ID_stage(clk, reset_n,
rs1_IF_ID, rs2_IF_ID, rd_IF_ID, 
instruction_IF_ID, OPCODE_IF_ID, FUNCT3_IF_ID, pc_IF_ID,
control_MUX_select_HZRD,
RegWrite_WB, write_reg_WB, write_data_WB,
read_data1_ID_EXE, read_data2_ID_EXE, immediate_ID_EXE,
JAL_ID_EXE, JALR_ID_EXE, MemRead_ID_EXE, MemWrite_ID_EXE,
ALUOp_ID_EXE, MemtoReg_ID_EXE, ALUSrc_ID_EXE, RegWrite_ID_EXE,
branch_ID_EXE, branch_address_ID_EXE, jalr_address_ID_EXE,
pc_ID_EXE, rs1_ID_EXE, rs2_ID_EXE, rd_ID_EXE, OPCODE_ID_EXE
);

	//Universal Inputs
	input clk, reset_n;
	
	//IF_ID_REG -> ID_stage
	input [4:0] rs1_IF_ID, rs2_IF_ID, rd_IF_ID;
	input [31:0] instruction_IF_ID;
	input [6:0] OPCODE_IF_ID;
	input [2:0] FUNCT3_IF_ID;
	input [14:0] pc_IF_ID;
	
	//Hazard -> ID_stage
	input control_MUX_select_HZRD;
	
	//WB_stage -> ID_stage
	input RegWrite_WB;
	input [4:0] write_reg_WB;
	input [31:0] write_data_WB;
	
	//Register File Outputs
	output [31:0] read_data1_ID_EXE, read_data2_ID_EXE;
	
	//Immediate Gen Outputs
	output [31:0] immediate_ID_EXE;
	
	//Control Unit Outputs
	output JAL_ID_EXE, JALR_ID_EXE;
	output [3:0] MemRead_ID_EXE, MemWrite_ID_EXE;
	output [3:0] ALUOp_ID_EXE;
	output [1:0] MemtoReg_ID_EXE;
	output ALUSrc_ID_EXE, RegWrite_ID_EXE;
	
	//Comparator Ouputs 
	output branch_ID_EXE;
	
	//Adders Outputs
	output [14:0] branch_address_ID_EXE;
	output [14:0] jalr_address_ID_EXE;
	
	//Passing Signals
	output [14:0] pc_ID_EXE;
	output [4:0] rs1_ID_EXE, rs2_ID_EXE, rd_ID_EXE;
	output [6:0] OPCODE_ID_EXE;
	
	//Wires
	wire [14:0] shifted_immediate, jalr_base_address, jalr_immediate_address;
	wire GND;
	wire BEQ_ID_EXE, BNE_ID_EXE;
	wire [31:0] R1;
	
	
	//Control Unit which dicates the operation of the remaining stages
	control_unit control_unit(OPCODE_IF_ID, FUNCT3_IF_ID, control_MUX_select_HZRD,
	BEQ_ID_EXE, BNE_ID_EXE, JAL_ID_EXE, JALR_ID_EXE, MemRead_ID_EXE,	MemWrite_ID_EXE,
	ALUOp_ID_EXE, MemtoReg_ID_EXE, ALUSrc_ID_EXE, RegWrite_ID_EXE);
	
	//32-bit register file consisting of 32 registers used for fast access
	register_file register_file(clk, reset_n, rs1_IF_ID, rs2_IF_ID, write_reg_WB, 
	RegWrite_WB, write_data_WB, R1, read_data2_ID_EXE);
	
	//Used to calculate immediate according to the instruction format
	immediate_gen immediate_gen(instruction_IF_ID, immediate_ID_EXE);
	
	//Used to deterine whether or not BEQ or BNE will be takes
	comparator comparator(read_data1_ID_EXE, read_data2_ID_EXE, BEQ_ID_EXE, BNE_ID_EXE, branch_ID_EXE);
	
	//Shift Immediate by 1 for branch instructions so that addressing is compatianble with instruction memory (it is also truncated)
	shift_left_by_1 shift_left_by_1(immediate_ID_EXE, shifted_immediate);
	
	//Used to calculate branch and jal target
	adder branch_target(pc_IF_ID, shifted_immediate, GND, branch_address_ID_EXE,);

	//Used to calculate jalr target
	adder jalr_target(jalr_base_address, jalr_immediate_address, GND, jalr_address_ID_EXE,);
	
	
	assign GND = 0;
	assign pc_ID_EXE = pc_IF_ID;
	assign rs1_ID_EXE = rs1_IF_ID;
	assign rs2_ID_EXE = rs2_IF_ID;
	assign rd_ID_EXE = rd_IF_ID;
	assign jalr_base_address = R1[14:0];
	assign read_data1_ID_EXE = R1;
	assign jalr_immediate_address = {{3{instruction_IF_ID[31]}}, instruction_IF_ID[31:20]};
	assign OPCODE_ID_EXE = OPCODE_IF_ID;

endmodule // ID_stage