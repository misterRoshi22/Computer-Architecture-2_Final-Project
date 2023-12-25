module tb_mux_2to1;

    // Inputs
    reg [31:0] A;
    reg [31:0] B;
    reg S;

    // Outputs
    wire [31:0] M;

    // Instantiate the mux_2to1 module
    mux_2to1 #(32) uut (
        .A(A),
        .B(B),
        .S(S),
        .M(M)
    );

    // Test scenario
    initial begin
        // Test values
        A = 32'hABCDEFF1; 
        B = 32'h76543210;
        S = 1'b0;
        #10;

        S = 1'b1;
        #10;
		  
		  B = 32'h01234567;
		  #10;
		  
		  S = 1'b0;
		  #10;
		  
		  A = 32'h9ABCDEFF;
		  #10;

        // Finish simulation
        $finish;
    end

endmodule // tb_mux_2to1
