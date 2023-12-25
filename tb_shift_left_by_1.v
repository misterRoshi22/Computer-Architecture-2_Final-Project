module tb_shift_left_by_1;

    // Inputs
    reg [31:0] input_value;

    // Outputs
    wire [14:0] shifted_output;

    // Instantiate the shift_left_by_1 module
    shift_left_by_1 uut (
        .input_value(input_value),
        .shifted_output(shifted_output)
    );

    // Test scenario
    initial begin
        // Initialize input value
			input_value = 32'h00000220; 
			#10;
			
			input_value = 32'h00200030;
			#10;
			
			input_value = 32'h00000033;
			#10;
			
			input_value = 32'h00000002;
			#10;

        // Stop simulation
        $finish;
    end

endmodule // tb_shift_left_by_1
