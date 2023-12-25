module MEM_WB_REG(clk, reset_n,
flush, MEM_WB_REG_Write, read_data_MEM, ALU_Result_MEM,
MemtoReg_MEM, RegWrite_MEM, write_reg_MEM,
pc_MEM, read_data_WB, ALU_Result_WB,
MemtoReg_WB, RegWrite_WB, write_reg_WB, pc_WB
);

	input clk, reset_n;
	input flush, MEM_WB_REG_Write;
	
	//Sent to WB stage
	input	[31:0] read_data_MEM;
	input	[31:0] ALU_Result_MEM;
	input [1:0] MemtoReg_MEM;
	input RegWrite_MEM;
	input [4:0] write_reg_MEM;
	input [31:0] pc_MEM;
	
	
	//Sent to WB stage
	output reg [31:0] read_data_WB;
	output reg [31:0] ALU_Result_WB;
	output reg [1:0] MemtoReg_WB;
	output reg RegWrite_WB;
	output reg [4:0] write_reg_WB;
	output reg [31:0] pc_WB;
	
	 always @(posedge clk) begin
        if (reset_n || flush) begin
            read_data_WB <= 0;
            ALU_Result_WB <= 0;
            MemtoReg_WB <= 0;
            RegWrite_WB <= 0;
            write_reg_WB <= 0;
            pc_WB <= 0;
        end 
		  
		  else if (MEM_WB_REG_Write) begin
            read_data_WB <= read_data_MEM;
            ALU_Result_WB <= ALU_Result_MEM;
            MemtoReg_WB <= MemtoReg_MEM;
            RegWrite_WB <= RegWrite_MEM;
            write_reg_WB <= write_reg_MEM;
            pc_WB <= pc_MEM;
        end
    end

endmodule //MEM_WB_REG
