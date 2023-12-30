module hazard_detection_unit(ID_EXE_MemRead, IF_ID_rs1, IF_ID_rs2, ID_EXE_rd,
OPCODE, control_MUX_select, IF_ID_REG_Write, PC_Write);

	input ID_EXE_MemRead;
	input [4:0] IF_ID_rs1,IF_ID_rs2;
	input [4:0] ID_EXE_rd;
	input [6:0] OPCODE;
	
	output reg control_MUX_select;
	output reg IF_ID_REG_Write;
	output reg PC_Write;
	
	always @(*) begin
			control_MUX_select <= 0;
			PC_Write <= 1;
			IF_ID_REG_Write <= 1;
		

		if(ID_EXE_MemRead && ((ID_EXE_rd == IF_ID_rs1)||(ID_EXE_rd == IF_ID_rs2))) begin
			control_MUX_select <= 1;
			PC_Write <= 0;
			IF_ID_REG_Write <= 0;
		end
	
	end

endmodule //hazard_detection_unit
