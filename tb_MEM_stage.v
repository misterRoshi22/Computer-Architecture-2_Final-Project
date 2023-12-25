module tb_MEM_stage;

    // Declare signals and reg variables for testbench
    reg clk = 0;
    reg reset_n = 0;
    // Declare other necessary reg variables here
    reg [3:0] MemRead_EXE; 
    reg [3:0] MemWrite_EXE;
    reg [31:0] ALU_Result_EXE_MEM;
    reg [31:0] write_data_EXE_MEM;
    reg [1:0] MemtoReg_EXE_MEM;
    reg RegWrite_EXE_MEM;
    reg [4:0] rd_EXE_MEM;
    reg [14:0] pc_EXE_MEM;
	 
    wire [31:0] read_data_MEM_WB;
    wire [31:0] ALU_Result_MEM_WB;
    wire [1:0] MemtoReg_MEM_WB;
    wire RegWrite_MEM_WB;
    wire [4:0] write_reg_MEM_WB;
    wire [31:0] pc_MEM_WB;

    // Instantiate the MEM_stage module
    MEM_stage mem_stage_inst (
        // Connect module ports to testbench signals
        .clk(clk),
        .reset_n(reset_n),
        .MemRead_EXE(MemRead_EXE),
        .MemWrite_EXE(MemWrite_EXE),
        .ALU_Result_EXE_MEM(ALU_Result_EXE_MEM),
        .write_data_EXE_MEM(write_data_EXE_MEM),
        .MemtoReg_EXE_MEM(MemtoReg_EXE_MEM),
        .RegWrite_EXE_MEM(RegWrite_EXE_MEM),
        .rd_EXE_MEM(rd_EXE_MEM),
        .pc_EXE_MEM(pc_EXE_MEM),
        .read_data_MEM_WB(read_data_MEM_WB),
        .ALU_Result_MEM_WB(ALU_Result_MEM_WB),
        .MemtoReg_MEM_WB(MemtoReg_MEM_WB),
        .RegWrite_MEM_WB(RegWrite_MEM_WB),
        .write_reg_MEM_WB(write_reg_MEM_WB),
        .pc_MEM_WB(pc_MEM_WB)
    );

    
	 initial begin 
		clk = 0;
		reset_n = 1;
		MemRead_EXE = 4'b0; 
		MemWrite_EXE = 4'b0; 
		ALU_Result_EXE_MEM = 32'b0;
		rd_EXE_MEM = 5'b0; // Initialize rd_EXE_MEM to 0
		pc_EXE_MEM = 15'b0; // Initialize pc_EXE_MEM to 0
		write_data_EXE_MEM = 32'b0; // Initialize write_data_EXE_MEM to 0
		MemtoReg_EXE_MEM = 2'b0; // Initialize MemtoReg_EXE_MEM to 0
		RegWrite_EXE_MEM = 1'b0; // Initialize RegWrite_EXE_MEM to 0
		rd_EXE_MEM = 5'b00000;
		pc_EXE_MEM = 15'b01110;
		#10;
		
		MemWrite_EXE = 4'b1111;
		write_data_EXE_MEM = 32'h5;
		#10;
		ALU_Result_EXE_MEM = 32'h5;
		write_data_EXE_MEM = 32'hAAA;
		#10;
		ALU_Result_EXE_MEM = 32'd10;
		write_data_EXE_MEM = 32'hAAAB;
		#10;
		ALU_Result_EXE_MEM = 32'd16;
		write_data_EXE_MEM = 32'hABCDE;
		#10;
		MemWrite_EXE = 4'b0000;
		#10;
		MemRead_EXE = 4'b1111;
		ALU_Result_EXE_MEM = 32'h0;
		#10;
		ALU_Result_EXE_MEM = 32'h4;
		#10;
		ALU_Result_EXE_MEM = 32'h8;
		#10;
		ALU_Result_EXE_MEM = 32'h16;
		#10;
			
		
		#100;
		$finish;
	 end
	 
	 always #5 clk = ~clk;

endmodule
