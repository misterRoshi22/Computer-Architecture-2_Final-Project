module adder(A, B, C, S, C_out); 
    parameter AB_width = 15;  	// Width of arguments and result
    input [AB_width-1:0] A,B; // Arguments
    input C;						// 1-bit carry in 
    output [AB_width-1:0] S;	// Result
    output C_out;					// 1-bit carry out
    
    assign {C_out, S} = A + B + C; 
    
endmodule //adder