module tb_EXE_stage();

    // Inputs
	reg clk;
	reg reset_n;
	reg [31:0] read_data1_ID_EXE;
	reg [31:0] read_data2_ID_EXE;
	reg [31:0] immediate_ID_EXE;
	reg ALUSrc_ID_EXE;
	reg [3:0] ALUOp_ID_EXE;
	reg [3:0] MemRead_ID_EXE;
	reg [3:0] MemWrite_ID_EXE;
	reg [1:0] MemtoReg_ID_EXE;
	reg RegWrite_ID_EXE;
	reg [4:0] rd_ID_EXE;
	reg [14:0] pc_ID_EXE;
	reg [1:0] ForwardA_FRWD;
	reg [1:0] ForwardB_FRWD;
	reg [31:0] ALU_Result_MEM_WB;
	reg [31:0] ALU_Result_EX_MEM;

	 // Outputs
	wire [3:0] MemRead_EXE_MEM;
	wire [3:0] MemWrite_EXE_MEM;
	wire [1:0] MemtoReg_EXE_MEM;
	wire RegWrite_EXE_MEM;
	wire [4:0] rd_EXE_MEM;
	wire [14:0] pc_EXE_MEM;
	wire [31:0] ALU_Result_EXE_MEM;
	wire [31:0] write_data_EXE_MEM;
	

	EXE_stage uut (
		 .clk(clk),
		 .reset_n(reset_n),
		 .read_data1_ID_EXE(read_data1_ID_EXE),
		 .read_data2_ID_EXE(read_data2_ID_EXE),
		 .immediate_ID_EXE(immediate_ID_EXE),
		 .ALUSrc_ID_EXE(ALUSrc_ID_EXE),
		 .ALUOp_ID_EXE(ALUOp_ID_EXE),
		 .MemRead_ID_EXE(MemRead_ID_EXE),
		 .MemWrite_ID_EXE(MemWrite_ID_EXE),
		 .MemtoReg_ID_EXE(MemtoReg_ID_EXE),
		 .RegWrite_ID_EXE(RegWrite_ID_EXE),
		 .rd_ID_EXE(rd_ID_EXE),
		 .pc_ID_EXE(pc_ID_EXE),
		 .ForwardA_FRWD(ForwardA_FRWD),
		 .ForwardB_FRWD(ForwardB_FRWD),
		 .ALU_Result_MEM_WB(ALU_Result_MEM_WB),
		 .ALU_Result_EX_MEM(ALU_Result_EX_MEM),
		 .MemRead_EXE_MEM(MemRead_EXE_MEM),
		 .MemWrite_EXE_MEM(MemWrite_EXE_MEM),
		 .MemtoReg_EXE_MEM(MemtoReg_EXE_MEM),
		 .RegWrite_EXE_MEM(RegWrite_EXE_MEM),
		 .rd_EXE_MEM(rd_EXE_MEM),
		 .pc_EXE_MEM(pc_EXE_MEM),
		 .ALU_Result_EXE_MEM(ALU_Result_EXE_MEM),
		 .write_data_EXE_MEM(write_data_EXE_MEM)
	);


  

    // Add initial block for inputs initialization if required

    // Monitor outputs
	initial begin
		clk = 0;
		read_data1_ID_EXE = 32'h5;
		read_data2_ID_EXE = 32'h6;
		reset_n = 0;
		immediate_ID_EXE = 32'h00000000; // Initialize immediate value
		ALUSrc_ID_EXE = 1'b0; // Initialize ALUSrc_ID_EXE to 0 or 1 based on your design
		ALUOp_ID_EXE = 4'b0010; // Initialize ALUOp_ID_EXE to your required value
		MemRead_ID_EXE = 4'b0000; // Initialize MemRead_ID_EXE to your required value
		MemWrite_ID_EXE = 4'b0000; // Initialize MemWrite_ID_EXE to your required value
		MemtoReg_ID_EXE = 2'b00; // Initialize MemtoReg_ID_EXE to your required value
		RegWrite_ID_EXE = 1'b0; // Initialize RegWrite_ID_EXE to 0 or 1 based on your design
		rd_ID_EXE = 5'b00000; // Initialize rd_ID_EXE to your required value
		pc_ID_EXE = 15'b000000000000000; // Initialize pc_ID_EXE to your required value
		ForwardA_FRWD = 2'b00; // Initialize ForwardA_FRWD to your required value
		ForwardB_FRWD = 2'b00; // Initialize ForwardB_FRWD to your required value
		ALU_Result_MEM_WB = 32'h00000000; // Initialize ALU_Result_MEM_WB to your required value
		ALU_Result_EX_MEM = 32'h00000000; // Initialize ALU_Result_EX_MEM to your required value
		#10;
		ALU_Result_MEM_WB = 32'h45;
		ALU_Result_EX_MEM = 32'h52;
		ForwardA_FRWD = 2'b01;
		#10;
		ForwardB_FRWD = 2'b10;
		#10;
		immediate_ID_EXE = 32'h96;
		ALUSrc_ID_EXE = 1'b1;
		ForwardB_FRWD = 2'b00;
		#10;
		ALUOp_ID_EXE = 4'b0110;
		#10;
		
		
      #100; // Simulate for 100 time units
      $finish; // End simulation
	end
	 
	   // Clock generation
    always #5 clk = ~clk;

endmodule // tb_EXE_stage
