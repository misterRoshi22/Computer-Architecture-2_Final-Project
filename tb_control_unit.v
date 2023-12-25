module tb_control_unit;

   reg [6:0] OPCODE;
   reg [2:0] FUNCT3;
	reg control_MUX_select;

   wire BEQ, BNE, JAL, JALR;
   wire [3:0] MemRead, MemWrite, ALUOp;
   wire [1:0] MemtoReg;
   wire ALUSrc, RegWrite;

   // Instantiate the control_unit module
   control_unit dut (
      .OPCODE(OPCODE),
      .FUNCT3(FUNCT3),
		.control_MUX_select(control_MUX_select),
      .BEQ(BEQ),
      .BNE(BNE),
      .JAL(JAL),
		.JALR(JALR),
      .MemRead(MemRead),
      .MemWrite(MemWrite),
      .ALUOp(ALUOp),
      .MemtoReg(MemtoReg),
      .ALUSrc(ALUSrc),
      .RegWrite(RegWrite)
   );

   initial begin

      // Test case 1: ADD instruction
		control_MUX_select = 0;
      OPCODE = 7'h33;
      FUNCT3 = 3'h0;
      #10; 
      FUNCT3 = 3'h1;
      #10;
		FUNCT3 = 3'h2;
      #10; 
		FUNCT3 = 3'h3;
      #10; 
		FUNCT3 = 3'h4;
      #10; 
		FUNCT3 = 3'h5;
      #10; 
		FUNCT3 = 3'h6;
      #10;
		FUNCT3 = 3'h7;
      #10;
		OPCODE = 7'h1b;
      FUNCT3 = 3'h0;
		#10
		OPCODE = 7'h13;
		FUNCT3 = 3'h6;
		#10;
		FUNCT3 = 3'h7;
		#10;
		OPCODE = 7'h63;
		FUNCT3 = 3'h1;
		#10;
		FUNCT3 = 3'h0;
		#10;
		OPCODE = 7'h6f;
		#10;
		OPCODE = 7'h67;
		#10;
		OPCODE = 7'h03;
		FUNCT3 = 3'h0;
		#10;
		FUNCT3 = 3'h2;
		#10;
		OPCODE = 7'h38;
		#10;
		OPCODE = 7'h23;
		FUNCT3 = 3'h0;
		#10;
		FUNCT3 = 3'h2;
		#40;
		control_MUX_select = 1;
		#40;
      // End simulation
      $finish;
   end
endmodule // tb_control_unit
