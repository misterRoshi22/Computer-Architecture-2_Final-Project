module tb_exception_handler;

    // Inputs
    reg [14:0] pc;
    reg [6:0] OPCODE;
    reg [14:0] branch_address;
    reg [3:0] MemRead_EXE, MemWrite_EXE;
    reg [3:0] ALUOp_EXE;

    // Output
	 wire [14:0] sepc;
	 wire [63:0] scause;
    wire exception;

    // Instantiate the exception_handler module
    exception_handler exception_handler_inst (
        .pc(pc),
        .OPCODE(OPCODE),
        .branch_address(branch_address),
        .MemRead_EXE(MemRead_EXE),
        .MemWrite_EXE(MemWrite_EXE),
        .ALUOp_EXE(ALUOp_EXE),
        .exception(exception),
		  .sepc(sepc),
		  .scause(scause)
    );

    // Initial stimulus
    initial begin
        // Initialize inputs
        pc = 16'h1000;
        OPCODE = 7'h33; // Example opcode value
        branch_address = 15'h2000;
        MemRead_EXE = 4'b0001;
        MemWrite_EXE = 4'b1111;
        ALUOp_EXE = 4'b0010;
		  #10;
        OPCODE = 7'h34;
		  #10;
		  OPCODE = 7'h33;
		  MemRead_EXE = 4'b1010;
		  #10;
        MemRead_EXE = 4'b0000;
		  #10;
		  ALUOp_EXE = 4'b1001;
		  #10;
		  pc = 16'h1004;
        #100; 
		  $finish; // End simulation after 10 time units
    end

endmodule //tb_exception_handler
 