module tb_pc_register;
    // Declare signals and wires for testbench
    reg clk, reset_n, write_enable;
    reg [14:0] IN; // Assuming a 15-bit input
    wire [14:0] OUT; // Assuming a 15-bit output

    // Instantiate the module under test
    pc_register dut (
        .clk(clk),
        .reset_n(reset_n),
        .write_enable(write_enable),
        .IN(IN),
        .OUT(OUT)
    );


    // Initial values
    initial begin
        clk = 0;
        reset_n = 0;
		  
		  
        write_enable = 1;
        IN = 15'b10001010101010; // Set initial input value
		  #10;
		  
		  
		  reset_n = 1;
		  #10;
		  
		  reset_n = 0;
		  write_enable = 1;
		  IN = 15'b100010101100111;
		  
		  #10;
		  
        $finish; // Terminate simulation 
    end
	 
	 
	always begin 
		#5 clk = ~clk;
	end
	

    // Display outputs during simulation
    always @(posedge clk) begin
        $display("Time = %0t, OUT = %b", $time, OUT);
    end
endmodule // tb_pc_register
