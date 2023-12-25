module tb_WB_stage;

    reg clk = 0;
    reg reset_n = 0;

    reg [31:0] read_data_MEM_WB;
    reg [31:0] ALU_Result_MEM_WB;
    reg [1:0] MemtoReg_MEM_WB;
    reg RegWrite_MEM_WB;
    reg [4:0] write_reg_MEM_WB;
    reg [31:0] pc_MEM_WB;

    wire RegWrite_ID;
    wire [4:0] write_reg_ID;
    wire [31:0] write_data_ID;

    WB_stage wb_stage_inst (
        .clk(clk),
        .reset_n(reset_n),
        .read_data_MEM_WB(read_data_MEM_WB),
        .ALU_Result_MEM_WB(ALU_Result_MEM_WB),
        .MemtoReg_MEM_WB(MemtoReg_MEM_WB),
        .RegWrite_MEM_WB(RegWrite_MEM_WB),
        .write_reg_MEM_WB(write_reg_MEM_WB),
        .pc_MEM_WB(pc_MEM_WB),
        .RegWrite_ID(RegWrite_ID),
        .write_reg_ID(write_reg_ID),
        .write_data_ID(write_data_ID)
    );

    initial begin
			clk = 0;
			reset_n = 1; 
			read_data_MEM_WB = 32'h00000001; 
			ALU_Result_MEM_WB = 32'h0000000A; 
			MemtoReg_MEM_WB = 2'b01; 
			RegWrite_MEM_WB = 1'b1; 
			write_reg_MEM_WB = 5'b00001; 
			pc_MEM_WB = 32'hFFFFFFF0;
			#10;
			MemtoReg_MEM_WB = 2'b00;
			#10;
			MemtoReg_MEM_WB = 2'b10;
			#10;
        
			#100;
			$finish;
    end

    always #5 clk = ~clk;

endmodule //tb_WB_stage
