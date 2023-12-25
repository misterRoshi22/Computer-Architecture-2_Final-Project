
module tb_immediate_gen;
   reg [31:0] instruction;
   wire [31:0] immediate;
   
   // Instantiate the immediate_gen module
   immediate_gen dut (
      .instruction(instruction),
      .immediate(immediate)
   );

   // Clock generation
   reg clk = 0;
   always #5 clk = ~clk;

   initial begin
      // Test case 1: LUI instruction
      instruction = 32'h555552b8; // Example LUI instruction
      #10; 
      $display("Instruction: %h, Immediate: %h", instruction, immediate);

      // Test case 2: ADDI instruction
      instruction = 32'h00d30293; // Example ADDI instruction
      #10;
      $display("Instruction: %h, Immediate: %h", instruction, immediate);
		
		// Test case 3: ORI instruction
		instruction = 32'h03436293; // Example ORI instruction
      #10;
      $display("Instruction: %h, Immediate: %h", instruction, immediate);

      // Test case 4: SW instruction
		instruction = 32'hf853ae23; // Example SW instruction
      #10;
      $display("Instruction: %h, Immediate: %h", instruction, immediate);
		
		// Test case 5: JAL instruction
		instruction = 32'h008002ef; // Example JAL instruction
      #10;
      $display("Instruction: %h, Immediate: %h", instruction, immediate);
		
		// Test case 6: BEQ instruction
		instruction = 32'h00628263; // Example BEQ instruction
      #10;
      $display("Instruction: %h, Immediate: %h", instruction, immediate);
		
		// Test case 7: LB instruction
		instruction = 32'h06138283; // Example LB instruction
      #10;
      $display("Instruction: %h, Immediate: %h", instruction, immediate);
      
      // End simulation
      $finish;
   end
endmodule // tb_immediate_gen
