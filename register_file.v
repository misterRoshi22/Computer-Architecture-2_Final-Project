module register_file(Clock, Reset_n, Read_addr1, Read_addr2, Write_addr, Write_En, Write_data, Read_data1, Read_data2);
  input  Clock, Reset_n;        // Clock and Reset
  input  [4:0] Read_addr1;      // Address of register 1
  input  [4:0] Read_addr2;      // Address of register 2
  input  [4:0] Write_addr;      // Used in to change value of R[Write_addr] in WB stage
  input  Write_En;              // This will only be 1 in load/R-type operations
  input  [31:0] Write_data;     // Data recieved from WB stage
  output [31:0] Read_data1;     // Value stored in register 1
  output [31:0] Read_data2;     // Value stored in register 2
  
  reg [31:0] registers [0:31];  // The 32 registers comprising the register file
  
  integer i;
 
  // Register write
    always @(posedge Clock) begin //Negative Edge
	 
        if(Reset_n)  
        begin 
            for( i = 0; i < 32; i = i + 1)
                registers[i] = 0;
        end
    
        else if (Write_En)
            registers[Write_addr] <= Write_data;
      
        registers[0] <= 0;           // Value of register 0 must always be zero    
    end
  
    assign Read_data1 = registers[Read_addr1]; //Read after Write
    assign Read_data2 = registers[Read_addr2];

endmodule //register_file