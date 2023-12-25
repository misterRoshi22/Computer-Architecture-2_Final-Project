module tb_ID_stage;

	// Inputs
	reg clk, reset_n;
	reg [4:0] rs1_IF_ID, rs2_IF_ID, rd_IF_ID;
	reg [31:0] instruction_IF_ID;
	reg [6:0] OPCODE_IF_ID;
	reg [2:0] FUNCT3_IF_ID;
	reg [14:0] pc_IF_ID;
	reg control_MUX_select_HZRD;
	reg RegWrite_WB;
	reg [4:0] write_reg_WB;
	reg [31:0] write_data_WB;
	
	// Outputs
	wire[31:0] read_data1_ID_EXE;
   wire  [31:0] read_data2_ID_EXE;
   wire  [31:0] immediate_ID_EXE;
   wire  JAL_ID_EXE;
   wire  JALR_ID_EXE;
   wire  [3:0] MemRead_ID_EXE;
   wire  [3:0] MemWrite_ID_EXE;
   wire  [3:0] ALUOp_ID_EXE;
	wire  [1:0] MemtoReg_ID_EXE;
   wire  ALUSrc_ID_EXE;
   wire  RegWrite_ID_EXE;
   wire  branch_ID_EXE;
   wire  [14:0] branch_address_ID_EXE;
   wire  [14:0] jalr_address_ID_EXE;
	wire  [14:0] pc_ID_EXE;
	wire 	[4:0] rs1_ID_EXE, rs2_ID_EXE, rd_ID_EXE;


	

	ID_stage uut (
		 // Inputs
		 .clk(clk),
		 .reset_n(reset_n),
		 .rs1_IF_ID(rs1_IF_ID),
		 .rs2_IF_ID(rs2_IF_ID),
		 .rd_IF_ID(rd_IF_ID),
		 .instruction_IF_ID(instruction_IF_ID),
		 .OPCODE_IF_ID(OPCODE_IF_ID),
		 .FUNCT3_IF_ID(FUNCT3_IF_ID),
		 .pc_IF_ID(pc_IF_ID),
		 .control_MUX_select_HZRD(control_MUX_select_HZRD),
		 .RegWrite_WB(RegWrite_WB),
		 .write_reg_WB(write_reg_WB),
		 .write_data_WB(write_data_WB),
		 
		 // Outputs
		 .read_data1_ID_EXE(read_data1_ID_EXE),
		 .read_data2_ID_EXE(read_data2_ID_EXE),
		 .immediate_ID_EXE(immediate_ID_EXE),
		 .JAL_ID_EXE(JAL_ID_EXE),
		 .JALR_ID_EXE(JALR_ID_EXE),
		 .MemRead_ID_EXE(MemRead_ID_EXE),
		 .MemWrite_ID_EXE(MemWrite_ID_EXE),
		 .ALUOp_ID_EXE(ALUOp_ID_EXE),
		 .MemtoReg_ID_EXE(MemtoReg_ID_EXE),
		 .ALUSrc_ID_EXE(ALUSrc_ID_EXE),
		 .RegWrite_ID_EXE(RegWrite_ID_EXE),
		 .branch_ID_EXE(branch_ID_EXE),
		 .branch_address_ID_EXE(branch_address_ID_EXE),
		 .jalr_address_ID_EXE(jalr_address_ID_EXE),
		 .pc_ID_EXE(pc_ID_EXE),
		 .rs1_ID_EXE(rs1_ID_EXE),
		 .rs2_ID_EXE(rs2_ID_EXE),
		 .rd_ID_EXE(rd_ID_EXE)
	);

	
	initial begin
	
		clk = 0;
		reset_n = 1;
		rs1_IF_ID = 0;
		rs2_IF_ID= 0;
		rd_IF_ID = 0;
		instruction_IF_ID = 32'h00d30293;
		OPCODE_IF_ID = 0;
		FUNCT3_IF_ID = 0;
		pc_IF_ID = 0;
		control_MUX_select_HZRD = 0;
		RegWrite_WB = 0;
		write_reg_WB = 0;
		write_data_WB = 0;
		#10;
		
		reset_n = 0;
		#10;
		
		rs1_IF_ID = 7;
		rs2_IF_ID= 8;
		#10;
		OPCODE_IF_ID = 33;
		FUNCT3_IF_ID = 3;
		#10;
		RegWrite_WB = 1;
		write_reg_WB = 5;
		write_data_WB = 32'd55;
		#10;
		RegWrite_WB = 0;
		control_MUX_select_HZRD = 1;
		#10;
		RegWrite_WB = 1;
		write_reg_WB = 2;
		write_data_WB = 32'd69;
		#10;
		RegWrite_WB = 0;
		#10;
		instruction_IF_ID = 32'hf853ae23;
		#10;
		
				
		#110;
		$finsih;
	end
	
	always #5 clk = ~clk; // Clock generation

endmodule //tb_ID_stage