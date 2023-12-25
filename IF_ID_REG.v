module IF_ID_REG(clk, reset_n, flush, IF_ID_REG_Write, 
pc_IF_ID, instruction_IF_ID,
rs1_ID, rs2_ID, rd_ID, OPCODE_ID, FUNCT3_ID, pc_ID, instruction_ID);

	//Universal Inputs
	input clk, reset_n;
	
	//Input from Hazard Detection Unit to stall in case of Load-Use Hazard
	input flush, IF_ID_REG_Write;
	
	//Inputs from the IF stage transfered to the ID stage
	input [14:0] pc_IF_ID;
	input [31:0] instruction_IF_ID;
	
	//Outputs to the ID stage used for reading register values 
	//and determined control signals and calculating immediate
	output reg [4:0] rs1_ID, rs2_ID, rd_ID;
	output reg [14:0] pc_ID;
	output reg [6:0] OPCODE_ID;
	output reg [2:0] FUNCT3_ID;
	output reg [31:0] instruction_ID;
	
	always @(posedge clk) begin
		if(reset_n || flush) begin
			{rs1_ID, rs2_ID, rd_ID, pc_ID, OPCODE_ID, FUNCT3_ID, instruction_ID} <= 0;
		end
		
		else if(IF_ID_REG_Write) begin
			rs1_ID <= instruction_IF_ID[19:15];
			rs2_ID <= instruction_IF_ID[24:20];
			rd_ID <= instruction_IF_ID[11:7];
			OPCODE_ID <= instruction_IF_ID[6:0];
			FUNCT3_ID <= instruction_IF_ID[14:12];
			instruction_ID <= instruction_IF_ID;
			pc_ID <= pc_IF_ID;
		end
	end
	
endmodule //IF_ID_REG