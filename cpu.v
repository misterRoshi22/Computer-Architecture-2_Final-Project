module cpu(clk, reset_n, sepc, scause);

	input clk, reset_n;
	
	wire VCC, GND;

	wire flush_IF_ID, flush_ID_EXE, flush_EXE_MEM, flush_MEM_WB;
	wire ID_EXE_REG_Write, EXE_MEM_REG_Write, MEM_WB_REG_write;

	//HAZARD -> CPU
	wire pc_write_IF;
	wire IF_ID_REG_Write_HZRD;
	wire control_MUX_select_ID;
	
	//CPU -> Forward
	wire [4:0] EXE_MEM_rd, MEM_WB_rd;
	wire [4:0] ID_EXE_rs1, ID_EXE_rs2;
	wire EXE_MEM_RegWrite, MEM_WB_RegWrite;
	wire [6:0] OPCODE_FORWARD;
	
	//FORWARD ->EXE
	wire [1:0] ForwardA_EXE, ForwardB_EXE;
	
	//EXCEPTION -> CPU
	wire exception;
	output [14:0] sepc;
	output [63:0] scause;
	
	
	//IF -> IF_ID_REG
	wire [14:0] pc_IF_ID;
	wire [31:0] instruction_IF_ID;
	
	//IF_ID_REG -> ID
	wire [4:0] rs1_ID, rs2_ID, rd_ID;
	wire [6:0] OPCODE_ID;
	wire [2:0] FUNCT3_ID;
	wire [14:0] pc_ID;
	wire [31:0] instruction_ID;
	
	//IF -> ID_EXE_REG
	wire [31:0] read_data1_ID_EXE,read_data2_ID_EXE, immediate_ID_EXE;
	wire JAL_ID_EXE, JALR_ID_EXE, branch_ID_EXE;
	wire [14:0] branch_address_ID_EXE, jalr_address_ID_EXE;
	wire [3:0] MemRead_ID_EXE, MemWrite_ID_EXE;
	wire [3:0] ALUOp_ID_EXE;
	wire [1:0] MemtoReg_ID_EXE;
	wire ALUSrc_ID_EXE, RegWrite_ID_EXE;
	wire [14:0] pc_ID_EXE;
	wire [4:0] rs1_ID_EXE, rs2_ID_EXE, rd_ID_EXE;
	wire [6:0] OPCODE_ID_EXE;
	
	//ID_EXE_REG -> EXE
	wire [31:0] read_data1_EXE, read_data2_EXE, immediate_EXE;
	wire [3:0] MemRead_EXE, MemWrite_EXE;
	wire [3:0] ALUOp_EXE;
	wire [1:0] MemtoReg_EXE;
	wire ALUSrc_EXE, RegWrite_EXE;
	wire [14:0] pc_EXE;
	wire [4:0] 	rd_EXE;
			
	//ID_EXE_REG -> IF
	wire branch_IF, jal_IF, jalr_IF;
	wire [14:0] branch_address_IF, jal_address_IF, jalr_address_IF;
	
	//ID_EXE_REG -> FORWARD
	wire [4:0] rs1_FORWARD, rs2_FORWARD;
	
	//EXE -> EXE_MEM_REG
	wire [3:0] MemRead_EXE_MEM, MemWrite_EXE_MEM;
   	wire [1:0] MemtoReg_EXE_MEM;
	wire RegWrite_EXE_MEM;
   	wire [4:0] rd_EXE_MEM;
	wire [14:0] pc_EXE_MEM;
	wire [31:0] ALU_Result_EXE_MEM;
	wire [31:0] write_data_EXE_MEM;
	
	//EXE_MEM_REG -> EXE
	wire [31:0] ALU_Result_EX_MEM_EXE;
	
	//EXE_MEM_REG -> MEM
	wire [3:0] MemRead_MEM, MemWrite_MEM;
	wire [1:0] MemtoReg_MEM; 
	wire RegWrite_MEM;
	wire [4:0] rd_MEM;
	wire [14:0] pc_MEM;
	wire [31:0] ALU_Result_MEM, write_data_MEM;
	
	//MEM -> MEM_WB_REG
	wire [31:0] read_data_MEM_WB, ALU_Result_MEM_WB, pc_MEM_WB;
	wire [1:0] MemtoReg_MEM_WB;
	wire RegWrite_MEM_WB;
	wire [4:0] write_reg_MEM_WB;
	
	//WB -> EXE
	wire [31:0] Write_Data_WB_EXE;
	
	//MEM_WB_REG -> WB
	wire [31:0] read_data_WB, ALU_Result_WB, pc_WB;
	wire [1:0] MemtoReg_WB;
	wire RegWrite_WB;
	wire [4:0] write_reg_WB;
	
	//WB -> ID
	wire RegWrite_ID;
	wire [4:0] write_reg_ID;
	wire [31:0] write_data_ID;
	

	
	exception_handler exception_handler(pc_EXE, OPCODE_FORWARD, branch_address_IF, branch_IF,
	MemRead_EXE, MemWrite_EXE, ALUOp_EXE, exception, sepc, scause);

	forwarding_unit forward(EXE_MEM_rd, MEM_WB_rd, rs1_FORWARD, rs2_FORWARD,
	EXE_MEM_RegWrite, MEM_WB_RegWrite, OPCODE_FORWARD, ForwardA_EXE, ForwardB_EXE);
	
		
	hazard_detection_unit hazard(MemRead_EXE[0], rs1_ID, rs2_ID, rd_EXE, OPCODE_ID,  
	control_MUX_select_ID, IF_ID_REG_Write_HZRD, pc_write_IF );
		
	branch_controller branch(branch_IF, jal_IF, jalr_IF, flush_IF_ID, flush_ID_EXE);

	IF_stage if_stage(clk, reset_n,
	pc_write_IF, branch_IF, branch_address_IF,
	jal_IF, jal_address_IF,
	jalr_IF, jalr_address_IF, 
	pc_IF_ID, instruction_IF_ID
	);
	
	IF_ID_REG if_id_reg(clk, reset_n,
	flush_IF_ID, IF_ID_REG_Write, 
	pc_IF_ID, instruction_IF_ID,
	rs1_ID, rs2_ID, rd_ID,
	OPCODE_ID, FUNCT3_ID, pc_ID, instruction_ID
	);
		
	ID_stage id_stage(clk, reset_n, 
	rs1_ID, rs2_ID, rd_ID,
	instruction_ID, OPCODE_ID, FUNCT3_ID, pc_ID,
	control_MUX_select_ID,
	RegWrite_ID, write_reg_ID, write_data_ID,
	read_data1_ID_EXE, read_data2_ID_EXE, immediate_ID_EXE,
	JAL_ID_EXE, JALR_ID_EXE, MemRead_ID_EXE, MemWrite_ID_EXE,
	ALUOp_ID_EXE, MemtoReg_ID_EXE, ALUSrc_ID_EXE, RegWrite_ID_EXE,
	branch_ID_EXE, branch_address_ID_EXE, jalr_address_ID_EXE,
	pc_ID_EXE, rs1_ID_EXE, rs2_ID_EXE, rd_ID_EXE, OPCODE_ID_EXE
	);
		
	ID_EXE_REG id_exe_reg(clk, reset_n,
	flush_ID_EXE,  ID_EXE_REG_Write, 
	read_data1_ID_EXE, read_data2_ID_EXE, immediate_ID_EXE,
	JAL_ID_EXE, JALR_ID_EXE, MemRead_ID_EXE, MemWrite_ID_EXE, 
	ALUOp_ID_EXE, MemtoReg_ID_EXE, ALUSrc_ID_EXE, RegWrite_ID_EXE,
	branch_ID_EXE,	branch_address_ID_EXE, jalr_address_ID_EXE,
	pc_ID_EXE, rs1_ID_EXE, rs2_ID_EXE, rd_ID_EXE, OPCODE_ID_EXE,
	read_data1_EXE, read_data2_EXE, immediate_EXE,
	jal_IF, jalr_IF, MemRead_EXE, MemWrite_EXE,
	ALUOp_EXE, MemtoReg_EXE, ALUSrc_EXE, RegWrite_EXE,
	branch_IF,	branch_address_IF, jalr_address_IF,
	pc_EXE, rs1_FORWARD, rs2_FORWARD, rd_EXE, OPCODE_FORWARD
	);
		
	EXE_stage exe(clk, reset_n,
	read_data1_EXE, read_data2_EXE, immediate_EXE,
	ALUSrc_EXE, ALUOp_EXE, MemRead_EXE, MemWrite_EXE,
	MemtoReg_EXE, RegWrite_EXE,
	rd_EXE, pc_EXE,
	ForwardA_EXE, ForwardB_EXE,
	Write_Data_WB_EXE, ALU_Result_EX_MEM_EXE,
	MemRead_EXE_MEM, MemWrite_EXE_MEM,
   MemtoReg_EXE_MEM, RegWrite_EXE_MEM,
   rd_EXE_MEM, pc_EXE_MEM,
   ALU_Result_EXE_MEM, write_data_EXE_MEM
	);
		
	EXE_MEM_REG exe_mem_reg(clk, reset_n,
	flush_EXE_MEM, EXE_MEM_REG_Write,
	MemRead_EXE_MEM, MemWrite_EXE_MEM,
   MemtoReg_EXE_MEM, RegWrite_EXE_MEM,
   rd_EXE_MEM, pc_EXE_MEM,
   ALU_Result_EXE_MEM, write_data_EXE_MEM,
	MemRead_MEM, MemWrite_MEM,
	MemtoReg_MEM, RegWrite_MEM,
	rd_MEM, pc_MEM,
	ALU_Result_MEM, write_data_MEM
	);
	
	
	MEM_stage mem_stage(clk, reset_n,
	MemRead_MEM, MemWrite_MEM,
	ALU_Result_MEM, write_data_MEM,
	MemtoReg_MEM, RegWrite_MEM,
	rd_MEM, pc_MEM,
	read_data_MEM_WB, ALU_Result_MEM_WB, 
	MemtoReg_MEM_WB, RegWrite_MEM_WB, write_reg_MEM_WB, pc_MEM_WB	
	);
	
	
	MEM_WB_REG mem_wb_reg(clk, reset_n,
	flush_MEM_WB, MEM_WB_REG_Write,
	read_data_MEM_WB, ALU_Result_MEM_WB, 
	MemtoReg_MEM_WB, RegWrite_MEM_WB, write_reg_MEM_WB,
	pc_MEM_WB, read_data_WB, ALU_Result_WB, 
	MemtoReg_WB, RegWrite_WB, write_reg_WB, pc_WB
	);
	
	WB_stage wb_stage(clk, reset_n,
	read_data_WB, ALU_Result_WB,
	MemtoReg_WB, RegWrite_WB,
	write_reg_WB, pc_WB,
	RegWrite_ID, write_reg_ID, write_data_ID
	);
		

	assign VCC = 1'b1;
	assign GND = 1'b0;
	
	assign jal_address_IF = branch_address_IF;
	assign ID_EXE_REG_Write = !exception;
	assign EXE_MEM_REG_Write = !exception;
	assign MEM_WB_REG_Write = !exception;
	assign IF_ID_REG_Write = !exception && IF_ID_REG_Write_HZRD;
	assign flush_EXE_MEM = GND;
	assign flush_MEM_WB = GND;
	
	assign EXE_MEM_rd = rd_MEM;
	assign MEM_WB_rd = write_reg_WB;
	
	assign EXE_MEM_RegWrite = RegWrite_MEM;
	assign MEM_WB_RegWrite = RegWrite_WB;
	
	assign ALU_Result_EX_MEM_EXE = ALU_Result_MEM;
	assign Write_Data_WB_EXE = MemtoReg_WB[0] ?  read_data_WB: ALU_Result_WB ;

	

endmodule //cpu
