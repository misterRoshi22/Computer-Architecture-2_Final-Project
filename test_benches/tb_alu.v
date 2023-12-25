module tb_alu;

  // Inputs
  reg [31:0] A, B;
  reg [3:0] ALUOpCode;

  // Outputs
  wire [31:0] ALU_Result;
  wire Zero;

  // Instantiate the alu module
  alu uut (
    .A(A),
    .B(B),
	 .ALUOpCode(ALUOpCode),
    .ALU_Result(ALU_Result),
    .Zero(Zero)
  );

  // Clock generation
  initial begin
    $monitor("Time=%0t, A=%h, B=%h, ALUOpCode=%h, ALU_Result=%h, Zero=%b",
             $time, A, B, ALUOpCode, ALU_Result, Zero);

    // Add more test scenarios as needed
    A = 32'h00000015;
    B = 32'h00000034;
	 #10;
	 ALUOpCode = 4'h6;  	// SUB operation
    #10;
	 ALUOpCode = 4'h1;  	// OR operation
    #10;
	 ALUOpCode = 4'h0;  	// AND operation
    #10;
	 ALUOpCode = 4'h2;  	// ADD operation
    #10;
	 ALUOpCode = 4'h3;  	// XOR operation
    #10;
	 ALUOpCode = 4'h8;	// STL operation
	 #10;

	 
	 A = 32'h00000034;
    B = 32'h00000002;
	 ALUOpCode = 4'h4;  	// SLL operation
    #10;
	 ALUOpCode = 4'h5;  	// SRL operation
	 #10;
	 
	 B = 32'h55555000;
	 ALUOpCode = 4'h7;	// LUI operation
	 #10;
	 
	 A = 32'd11;
	 B = 32'd12;
	 ALUOpCode = 4'h8;	// STL operation
	 #10;

    // Stop simulation
    $finish;
  end

endmodule // tb_alu
