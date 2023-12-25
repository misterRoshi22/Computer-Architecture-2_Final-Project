module tb_IF_stage;

    // Inputs
    reg clk;
    reg reset_n;
    reg pc_write_HZRD;
    reg [14:0] branch_address_EXE, jal_address_EXE, jalr_address_EXE;
    reg branch_EXE, jal_EXE, jalr_EXE;

    // Outputs
    wire [31:0] instruction_IF_ID;
    wire [14:0] pc_IF_ID;

    // Instantiate the IF_stage module
    IF_stage uut (
        .clk(clk),
        .reset_n(reset_n),
        .pc_write_HZRD(pc_write_HZRD),
        .branch_address_EXE(branch_address_EXE),
        .jal_address_EXE(jal_address_EXE),
        .jalr_address_EXE(jalr_address_EXE),
        .branch_EXE(branch_EXE),
        .jal_EXE(jal_EXE),
        .jalr_EXE(jalr_EXE),
        .instruction_IF_ID(instruction_IF_ID),
        .pc_IF_ID(pc_IF_ID)
    );

    // Initialize inputs
    initial begin
		  clk = 0;
        reset_n = 1;
        pc_write_HZRD = 1;
        branch_address_EXE = 15'b0;
        jal_address_EXE = 15'b0;
        jalr_address_EXE = 15'b0;
        branch_EXE = 0;
        jal_EXE = 0;
        jalr_EXE = 0;
        #10;
		 
		reset_n = 0;
		#10;
	
		pc_write_HZRD = 0;
		#20;
		
		pc_write_HZRD = 1;
		branch_address_EXE = 15'd24;
		branch_EXE = 1;
		#10;
		branch_EXE = 0;
		#30;
		jal_address_EXE = 15'd8;
		jal_EXE = 1;
		#10;
		jal_EXE = 0;
		#40;
		jalr_EXE = 1;
		jalr_address_EXE = 15'd4;
		#10;
		jalr_EXE = 0;
        
        // Implement your test scenarios here
        // For instance, applying control signals, changing addresses, etc.

        $monitor("Time=%0t, PC=%h, Instruction=%h", $time, pc_IF_ID, instruction_IF_ID);
        
        #100; // End simulation
        $finish;
    end

    always #5 clk = ~clk; // Clock generation

endmodule // tb_IF_stage
