module tb_mux_4to1;

    // Inputs
    reg [31:0] A, B, C, D;
    reg [1:0] S;

    // Outputs
    wire [31:0] M;

    // Instantiate the mux_4to1 module
    mux_4to1 #(32) uut (
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .S(S),
        .M(M)
    );

    // Test scenario
    initial begin
        // Test values
        A = 32'hABCDEFF1; 
        B = 32'h76543210;
        C = 32'h11111111;
        D = 32'h22222222;
        S = 2'b00; 
        #10;
		  
		  S = 2'b01;
		  #10;
		  S = 2'b10;
		  #10;
		  S = 2'b11;
		  #10;
		  
		  A = 32'h45678912; 
        B = 32'h12345678;
        C = 32'h74185263;
        D = 32'h96385214;
		  S = 2'b00; 
        #10;
		  
		  S = 2'b01;
		  #10;
		  S = 2'b10;
		  #10;
		  S = 2'b11;
		  #10;
		  
		  

        

        // Finish simulation
        $finish;
    end

endmodule // tb_mux_4to1
