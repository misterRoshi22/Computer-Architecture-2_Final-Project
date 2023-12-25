
module tb_data_memory;

   // Inputs
   reg clk;
	reg reset_n;
   reg [31:0] address;
   reg [31:0] write_data;
   reg [3:0] read_enable;
   reg [3:0] write_enable;

   // Outputs
   wire [31:0] read_data;

   // Instantiate the data_memory module
   data_memory uut (
      .clk(clk),
		.reset_n(reset_n),
      .address(address),
      .write_data(write_data),
      .read_enable(read_enable),
      .write_enable(write_enable),
      .read_data(read_data)
   );

      

   // Test scenario
   initial begin
	clk = 0;
	reset_n = 0;
	
	
	//MEM[0:3] = 69
	address = 32'h00000000;			
   write_data = 32'd69;
	read_enable = 4'b0000;
   write_enable = 4'b1111;
	#10;
	
	//MEM[4:7] = 420
	address =  32'h00000005; //should get rounded down
	write_data = 32'd420;
	#10;
	
	//READ WORD at MEM[0:3]
	write_enable = 4'b0000;
	read_enable = 4'b1111;
	address = 32'h00000000;
	#10;
	
	//READ WORD at MEM[4:7]
	address = 32'h00000004;
	#10;
	
	//MEM[8:11] = 5
	address = 32'h00000008;
	read_enable = 4'b0000;
	write_enable = 4'b1111;
	write_data = 4'b0101;
	#10;
	
	//READ BYTE AT MEM[8]
	read_enable = 4'b0001;
	write_enable = 4'b0000;
	#10;
	
	//MEM[8] = 15
	read_enable = 4'b0000;
	write_enable = 4'b0001;
	write_data = 4'b1111;
	#10;
	
	//READ WORD AT MEM[11:8]
	read_enable = 4'b1111;
	write_enable = 4'b0000;
	#10;
	
	//MEM[0] = 6
	write_enable = 4'b0001;
	read_enable = 4'b0000;
	address = 0;
	write_data = 4'b0110;
	#10;
	
	//READ WORD at MEM[3:0]
	write_enable = 4'b0000;
	read_enable = 4'b1111;
	#10;
	
	
	
	


      // Monitor outputs
      $monitor("Time=%0t, Address=%h, Write Data=%h, Read Data=%h", $time, address, write_data, read_data);

      // Stop simulation after some time
      #20;
		$finish;
   end
	
		always begin 
		#5 clk = ~clk;
	end
	

endmodule // tb_data_memory
