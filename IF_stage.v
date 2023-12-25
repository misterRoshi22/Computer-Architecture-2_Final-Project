module IF_stage(clk, reset_n, pc_write_HZRD,
branch_EXE, branch_address_EXE, jal_EXE, jal_address_EXE, jalr_EXE, jalr_address_EXE,
pc_IF_ID, instruction_IF_ID);

	//Universal Inputs
	input clk, reset_n;	
	
	//Input from Hazard Detection used for stalling
	input pc_write_HZRD;	
	
	//Inputs from EXE stage which are the used to determine whether or not we should jump and where to jump
	input [14:0] branch_address_EXE, jal_address_EXE, jalr_address_EXE;		
	input branch_EXE, jal_EXE, jalr_EXE;
	
	//Outputs sent to IF_ID_REG
	output [31:0] instruction_IF_ID;
	output [14:0] pc_IF_ID;
	
	wire [14:0] pc_IN, pc_OUT;
	wire [1:0] pc_mux_select;
	wire [14:0] four;
	wire [14:0] pc_plus4;
	
	wire GND;
	
	//PC MUX used to determine which instruction is the next instruction
	mux_4to1 pc_mux(branch_address_EXE, jal_address_EXE, jalr_address_EXE, pc_plus4, pc_mux_select, pc_IN);	
	defparam pc_mux.AB_width = 15;
	
	//PC control used to calculate select line for PC MUX
	pc_control pc_control_unit(branch_EXE, jal_EXE, jalr_EXE, pc_mux_select);
	
	//Program Counter (PC) used to store current instruction being processed
	pc_register PC(clk, reset_n, pc_write_HZRD, pc_IN, pc_OUT);
	defparam PC.n = 15;  
	
	//Adder used to calculate PC + 4 if that is the next instruction
	adder pc_adder(pc_OUT, four, GND, pc_plus4, );
	defparam pc_adder.AB_width = 15;
	
	//Instruction Memory used to read instructions being processed (Read-Only)
	instruction_memory ROM(clk, pc_IF_ID, instruction_IF_ID);
	
	assign four = 15'd4;
	assign GND = 1'b0;
	assign pc_IF_ID = pc_OUT;
	
	

endmodule //IF_stage