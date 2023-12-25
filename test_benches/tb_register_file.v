module tb_register_file();

  reg Clock;
  reg Reset_n;
  reg [4:0] Read_addr1;
  reg [4:0] Read_addr2;
  reg [4:0] Write_addr;
  reg Write_En;
  reg [31:0] Write_data;
  
  wire [31:0] Read_data1;
  wire [31:0] Read_data2;

  // Instantiate the register_file module
  register_file uut (Clock, Reset_n, Read_addr1, Read_addr2, Write_addr, Write_En, Write_data, Read_data1, Read_data2);


  always begin
    #5 Clock = ~Clock; // Toggle the clock every 5 time units
  end

  // Initialize signals
  initial begin
    Clock = 0;
    Reset_n = 1;
    Write_En = 0;
    Write_data = 0;
    Read_addr1 = 0;
    Read_addr2 = 1;
    Write_addr = 1;

    // Apply reset, all registers are now zero
    #10 Reset_n = 0;
	 
    #10; //Testing Write Enable which is currently Zero, Register[1] Should Remain Zero
	 Reset_n = 0;
    Write_En = 0;
    Write_data = 8;
	 
    #10;//Testing Write Enable which is Currently set to 1, Register[1] should now be 0x6
    Write_En = 1;
    Write_data = 6;
	 
    #10; //Testing Register Zero, Which should remain zero even after writing a value onto it
    Write_data = 7;
    Write_addr = 0;

	 #10; //Reading Value from Register[5] which should be 0x0 and Register[1] which should be 0x6, and writing 0x9 onto Register [7]
    Write_data = 9;
    Read_addr1 = 5;
    Write_addr = 7;
	 
	 #10; //Reading Value from Register[7] which should be 0x9, and Reading from Register[0] which should remain 0x0
    Write_En = 0;
    Read_addr1 = 0;
    Read_addr2 = 7;
	 #10;

    $finish; // Finish simulation
  end

  // Display register values in the simulation
  always @(posedge Clock) begin
    $display("Time %t: Register[%d] = %d, Register[%d] = %d", $time, Read_addr1, Read_data1, Read_addr2, Read_data2);
  end

endmodule //tb_register_file
