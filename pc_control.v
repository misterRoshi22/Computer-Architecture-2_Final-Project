module pc_control(branch, jal, jalr, pc_mux_select);

	input branch, jal, jalr;		//inputs from EXE stage used to determine if we should jump or not
	output [1:0] pc_mux_select;	//pc_mux select line used to determine input to mux
	
	//assuming that only one of the inputs is high (which should be true under the right conditions)
	assign pc_mux_select = branch ? 2'd0 : (jal ? 2'd1 : (jalr ? 2'd2 : (2'd3)));


endmodule //pc_control