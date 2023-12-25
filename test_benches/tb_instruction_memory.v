module tb_instruction_memory;

    // Inputs
    reg clk;
    reg [14:0] address;

    // Outputs
    wire [31:0] read_data;

    // Instantiate the instruction_memory module
    instruction_memory uut (
        .clk(clk),
        .address(address),
        .read_data(read_data)
    );

    // Test scenario
    initial begin
        clk = 0;

        address = 15'h0000; 
        #10;
        address = 15'h0001; 
        #10;
        address = 15'h0002;
        #10;
        address = 15'h0003; 
        #10;
        address = 15'h0004; 
        #10;
        address = 15'h0005; 
        #10;


        // Monitor outputs
        $monitor("Time=%0t, Address=%h, Read Data=%h", $time, address, read_data);

        // Stop simulation after some time
        #20;
        $finish;
    end

    always #5 clk = ~clk; // Clock generation

endmodule // tb_instruction_memory
