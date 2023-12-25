module data_memory(clk, reset_n, address,
write_enable, read_enable, write_data, read_data);

	input clk;									//CLOCK
	input reset_n;								//Universal Reset
   input [10:0] address;					//Address used for reading and writing
   input [31:0] write_data;				//Store Byte/Word
	input [3:0] read_enable; 				//1 in case of SB, 15 in case of SW, 0 otherwise
   input [3:0] write_enable;				//1 in case of LB, 15 in case of LW, 0 otherwise
   output reg [31:0] read_data;			//Load Byte/Word
	 
   reg [7:0] memory[0:2047];				//the 2048 registers comprising the data memory
	 
	wire [10:0] add0, add1, add2, add3;	//Addresses used to read individual words
	integer i;
	 
	//Round down the address to nearest word as word alignment is not gaurenteed
	assign add0 = (address & 11'hffc)+ 11'd0;
	assign add1 = (address & 11'hffc)+ 11'd1;
	assign add2 = (address & 11'hffc)+ 11'd2;
	assign add3 = (address & 11'hffc)+ 11'd3;
	 
	 
	 
	always@(posedge clk) //posedge for writing
		begin
		
			if(reset_n == 1)  
				begin 
					for( i = 0; i < 2047; i = i + 1)
						 memory[i] = 0;
			  end
		
		
			if(write_enable[0] == 1)  //SB SW
				memory[add0] = write_data[7:0];
			if(write_enable[1] == 1) //SW
				memory[add1] = write_data[15:8];
			if(write_enable[2] == 1) //SW
				memory[add2] = write_data[23:16];
			if(write_enable[3] == 1) //SW
				memory[add3] = write_data[31:24];
		end
	 
	 always@(negedge clk) //negedge for reading
		begin
			 read_data <= 32'b0;
			if(read_enable[0] == 1) begin //LB LW
				read_data <= {{24{memory[add0][7]}}, memory[add0]};
			end
				
			if(read_enable[1] == 1) //LW
				read_data[15:8] <= memory[add1];
				
			if(read_enable[2] == 1) //LW
				read_data[23:16] <= memory[add2];
				
			if(read_enable[3] == 1) //LW
				read_data[31:24] <= memory[add3];
		end
	 
endmodule //data_memory