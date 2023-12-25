module branch_controller(branch, jal, jalr, flush_IF_ID, flush_ID_EXE);

	input branch, jal, jalr;
	
	output flush_IF_ID, flush_ID_EXE;
	
	assign flush_IF_ID = (branch || jal || jalr);
	assign flush_ID_EXE = (branch || jal || jalr);


endmodule //branch_controller