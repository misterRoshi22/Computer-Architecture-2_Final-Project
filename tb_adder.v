module tb_adder;

    // Inputs
    reg [14:0] A, B;
    reg C;

    // Outputs
    wire [14:0] S;
    wire C_out;

    // Instantiate the adder module
    adder uut (
        .A(A),
        .B(B),
        .C(C),
        .S(S),
        .C_out(C_out)
    );

    // Test scenario
    initial begin
        // Test values
        A = 15'h34; 
        B = 15'h15;
        C = 1'b0;
        #10;
		  A = 15'h34; 
        B = 15'h7FFE;
        C = 1'b0;
        #10;
		  A = 15'h7FFE; 
        B = 15'h7FFE;
        C = 1'b0;
        #10;

        // Finish simulation
        $finish;
    end

endmodule // tb_adder
