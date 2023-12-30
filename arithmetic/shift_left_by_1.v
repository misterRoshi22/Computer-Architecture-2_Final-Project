module shift_left_by_1(input_value, shifted_output);

	input [31:0] input_value;
    	output [14:0] shifted_output;
	 
	reg [31:0] SHIFTED_OUTPUT;
	 
	assign shifted_output = SHIFTED_OUTPUT[14:0]; // output is truncated to match size of PC

    	always @(*) begin
        	SHIFTED_OUTPUT = input_value << 1;	// input is multiplied by 2 to become a multiple of 4 for safer instruction memory addressing
    	end

endmodule // shift_left_by_1
